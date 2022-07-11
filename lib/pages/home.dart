import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:omeganotes/models/note.dart';
import 'package:omeganotes/pages/note-edit.dart';
import 'package:omeganotes/themes/themes.dart';
import 'package:omeganotes/widgets/note-button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:provider/provider.dart';
import '../models/theme.dart';

class HomePage extends StatefulWidget {
  static const routeName = "/homePage";
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List? notes;
  @override
  void initState() {
    fetchNotes().then((value) => setState(() {}));
    super.initState();
  }

  Future<void> fetchNotes() async {
    var instance = await SharedPreferences.getInstance();
    String? temp;
    try {
      temp = instance.get('notes') as String;
    } catch (e) {
      notes = [];
      return;
    }
    List onemoretemp = json.decode(temp) as List<dynamic>;
    notes = onemoretemp
        .map(
          (e) => Note.fromJson(e),
        )
        .toList();
  }

  Future<void> deleteNote(index) async {
    var instance = await SharedPreferences.getInstance();
    setState(() {
      notes!.removeAt(index);
    });
    notes = notes!.map(
      (e) {
        e.id = notes!.indexOf(e);
        return e;
      },
    ).toList();
    instance.setString(
        'notes', json.encode(notes!.map((e) => e.toJson()).toList()));
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeModel>(
        builder: (context, ThemeModel themeNotifier, child) {
      return Scaffold(
          floatingActionButton: FloatingActionButton(
            tooltip: "Create note",
            backgroundColor: Theme.of(context).primaryColor,
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => NoteEditPage(
                      note: Note(
                          id: notes!.length,
                          pinned: false,
                          text: "",
                          title: ""))));
            },
            child: const Icon(Icons.add),
          ),
          appBar: AppBar(
            title: const Text("OmegaNotes"),
            backgroundColor: Theme.of(context).primaryColor,
            centerTitle: true,
            actions: [
              IconButton(
                  tooltip: "Change theme",
                  icon: Icon(themeNotifier.isDark
                      ? Icons.nightlight_round
                      : Icons.wb_sunny),
                  onPressed: () {
                    themeNotifier.isDark
                        ? themeNotifier.isDark = false
                        : themeNotifier.isDark = true;
                  })
            ],
          ),
          body: this.notes != null
              ? Stack(
                  children: [
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 500),
                      transitionBuilder:
                          (Widget child, Animation<double> animation) {
                        return FadeTransition(opacity: animation, child: child);
                      },
                      child: !themeNotifier.isDark
                          ? ColorFiltered(
                              colorFilter: const ColorFilter.matrix(
                                [
                                  -.2,
                                  0,
                                  0,
                                  0,
                                  255,
                                  0,
                                  -1,
                                  0,
                                  0,
                                  255,
                                  0,
                                  0,
                                  -1,
                                  0,
                                  255,
                                  0,
                                  0,
                                  0,
                                  1,
                                  0,
                                ],
                              ),
                              child: Image.asset(
                                "assets/images/image.jpg",
                                fit: BoxFit.cover,
                                height: double.infinity,
                              ),
                            )
                          : Image.asset(
                              "assets/images/image.jpg",
                              fit: BoxFit.cover,
                              height: double.infinity,
                            ),
                    ),
                    Column(children: [
                      Expanded(
                        child: ListView.builder(
                            itemCount: notes!.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: NoteButton(
                                  note: notes![index],
                                  deleteFunction: () => deleteNote(index),
                                ),
                              );
                            }),
                      )
                    ]),
                  ],
                )
              : const Center(
                  child: CircularProgressIndicator(),
                ));
    });
  }
}
