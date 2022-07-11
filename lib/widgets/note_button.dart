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
    return ElevatedButton(
      onLongPress: () => showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: const Text("Delete"),
                content: const Text("Do you really wanna delete this note?"),
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
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
              widget.note.color != null
                  ? Color(widget.note.color!)
                  : Theme.of(context).primaryColor),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          )),
          alignment: Alignment.topLeft),
      onPressed: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => NoteEditPage(note: widget.note)));
      },
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.note.title ?? "",
              style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            Text(
              widget.note.text == null
                  ? ""
                  : widget.note.text!.length < 10
                      ? widget.note.text!
                      : widget.note.text!.substring(0, 10),
              style: const TextStyle(fontSize: 20),
            )
          ],
        ),
      ),
    );
  }
}
