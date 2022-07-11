import 'package:flutter/material.dart';
import 'package:omeganotes/pages/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/note.dart';
import 'dart:convert';
import 'package:flex_color_picker/flex_color_picker.dart';

class NoteEditPage extends StatefulWidget {
  Note note;
  NoteEditPage({required this.note});

  @override
  State<NoteEditPage> createState() => _NoteEditPageState();
}

class _NoteEditPageState extends State<NoteEditPage> {
  @override
  void dispose() {
    super.dispose();
  }

  Future<void> saveNote() async {
    var instance = await SharedPreferences.getInstance();
    List notes;
    bool closer;
    try {
      String temp = instance.get('notes') as String;
      List onemoretemp = json.decode(temp) as List<dynamic>;
      closer = false;
      notes = onemoretemp
          .map(
            (e) => Note.fromJson(e),
          )
          .toList();
      notes = notes.map((e) {
        if (e.id == widget.note.id) {
          closer = true;
          return Note(
              title: _titleController.text,
              text: _textController.text,
              id: widget.note.id,
              pinned: widget.note.pinned,
              color: widget.note.color);
        } else {
          return e;
        }
      }).toList();
    } catch (e) {
      notes = [];
      closer = false;
    }
    if (!closer) {
      notes.add(Note(
          title: _titleController.text,
          text: _textController.text,
          id: widget.note.id,
          pinned: widget.note.pinned,
          color: widget.note.color));
    }
    instance.setString(
        'notes', json.encode(notes.map((e) => e.toJson()).toList()));
  }

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (_titleController.text.isEmpty) {
      _titleController.text = widget.note.title!;
    }
    if (_textController.text.isEmpty) {
      _textController.text = widget.note.text!;
    }
    return WillPopScope(
      onWillPop: () async {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  title: Text(
                    "Exit",
                    style: TextStyle(
                        color: widget.note.color == null
                            ? Theme.of(context).primaryColor
                            : Color(widget.note.color!)),
                  ),
                  content: Text(
                    "Do you wanna save the changes?",
                    style: TextStyle(
                        color: widget.note.color == null
                            ? Theme.of(context).primaryColor
                            : Color(widget.note.color!)),
                  ),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text("Cancel")),
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          Navigator.of(context)
                              .pushReplacementNamed(HomePage.routeName);
                        },
                        child: const Text("No")),
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          saveNote().then((value) => Navigator.of(context)
                              .pushReplacementNamed(HomePage.routeName));
                        },
                        child: const Text("Yes")),
                  ],
                ));
        return false;
      },
      child: Scaffold(
          body: Container(
        decoration: BoxDecoration(
          color: widget.note.color == null
              ? Theme.of(context).primaryColor
              : Color(widget.note.color!),
        ),
        padding: const EdgeInsets.all(20),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
          decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(20)),
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      saveNote().then((value) => Navigator.of(context)
                          .pushReplacementNamed(HomePage.routeName));
                    },
                    icon: const Icon(Icons.arrow_back),
                  ),
                  Expanded(
                      child: TextField(
                          controller: _titleController,
                          cursorColor: widget.note.color != null
                              ? Color(widget.note.color!)
                              : Theme.of(context).primaryColor,
                          decoration: InputDecoration(
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                              color: widget.note.color != null
                                  ? Color(widget.note.color!)
                                  : Theme.of(context).primaryColor,
                            )),
                          )))
                ],
              ),
              SizedBox(
                height: 8,
              ),
              Expanded(
                child: TextField(
                    controller: _textController,
                    scrollPadding: const EdgeInsets.all(20.0),
                    keyboardType: TextInputType.multiline,
                    maxLines: 99999,
                    cursorColor: widget.note.color != null
                        ? Color(widget.note.color!)
                        : Theme.of(context).primaryColor,
                    decoration: InputDecoration(
                      hintText: "Insert your note text",
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                        color: widget.note.color != null
                            ? Color(widget.note.color!)
                            : Theme.of(context).primaryColor,
                      )),
                      enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                    )),
              ),
              Container(
                child: Row(children: [
                  IconButton(
                    onPressed: () async {
                      final Color newColor = await showColorPickerDialog(
                        backgroundColor:
                            Theme.of(context).scaffoldBackgroundColor,
                        context,
                        widget.note.color != null
                            ? Color(widget.note.color!)
                            : Theme.of(context).primaryColor,
                        title: const Text(
                          'Pick color',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        width: 40,
                        height: 40,
                        spacing: 0,
                        runSpacing: 0,
                        borderRadius: 0,
                        wheelDiameter: 165,
                        enableOpacity: true,
                        showColorCode: true,
                        colorCodeHasColor: true,
                        pickersEnabled: <ColorPickerType, bool>{
                          ColorPickerType.wheel: true,
                        },
                        actionButtons: const ColorPickerActionButtons(
                          okButton: true,
                          closeButton: false,
                          dialogActionButtons: false,
                        ),
                        constraints: const BoxConstraints(
                            minHeight: 480, minWidth: 320, maxWidth: 320),
                      );
                      String colorString = newColor.toString();
                      String valueString =
                          colorString.split('(0x')[1].split(')')[0];
                      int value = int.parse(valueString, radix: 16);
                      widget.note.color = value;
                      setState(() {});
                    },
                    icon: const Icon(Icons.palette),
                    tooltip: "Edit note color",
                  ),
                  IconButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Color reseted!"),
                        duration: Duration(milliseconds: 500),
                      ));
                      setState((() {
                        widget.note.color = null;
                      }));
                    },
                    icon: Icon(Icons.disabled_by_default_outlined),
                    tooltip: "Set default color",
                  )
                ]),
              )
            ],
          ),
        ),
      )),
    );
  }
}
