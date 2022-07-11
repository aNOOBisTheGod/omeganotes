import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:omeganotes/pages/note-edit.dart';
import '../models/note.dart';

class NoteButton extends StatefulWidget {
  Note note;
  var deleteFunction;
  NoteButton({required this.note, required this.deleteFunction});

  @override
  State<NoteButton> createState() => _NoteButtonState();
}

class _NoteButtonState extends State<NoteButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () => showDialog(
          context: context,
          builder: (context) => AlertDialog(
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                title: Text(
                  "Delete",
                  style: TextStyle(
                      color: widget.note.color == null
                          ? Theme.of(context).primaryColor
                          : Color(widget.note.color!)),
                ),
                content: Text(
                  "Do you really wanna delete this note?",
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
                      child: const Text("No")),
                  TextButton(
                      onPressed: () {
                        widget.deleteFunction();
                        Navigator.of(context).pop();
                      },
                      child: const Text("Yes")),
                ],
              )),
      onTap: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => NoteEditPage(note: widget.note)));
      },
      child: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
          child: Container(
            decoration: BoxDecoration(
                color: widget.note.color != null
                    ? Color(widget.note.color!).withOpacity(.4)
                    : Theme.of(context).primaryColor.withOpacity(.4),
                borderRadius: BorderRadius.circular(10)),
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.note.title ?? "",
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    widget.note.text == null
                        ? ""
                        : widget.note.text!.length <
                                MediaQuery.of(context).size.width ~/ 3.3
                            ? widget.note.text!.replaceAll('\n', " ")
                            : "${widget.note.text!.substring(0, MediaQuery.of(context).size.width ~/ 3.3)}..."
                                .replaceAll('\n', " "),
                    maxLines: (MediaQuery.of(context).size.width ~/ 100),
                    // : widget.note.text!.indexOf("\n") > 10
                    //     ? "${widget.note.text!.substring(0, 10)}..."
                    //     : "${widget.note.text!.substring(0, widget.note.text!.indexOf("\n"))}...",
                    style: const TextStyle(fontSize: 15),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
