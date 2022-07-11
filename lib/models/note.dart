import 'package:flutter/material.dart';

class Note {
  int id;
  String? title;
  String? text;
  int? color;
  bool pinned;

  Note({required this.id, required this.pinned, this.text, this.title, this.color});

  Map<String, dynamic> toJson() => {
    'id': this.id,
    'title': this.title,
    'text': this.text,
    'color': color != null ? this.color.toString() : color,
    'pinned': this.pinned
  };

  Note.fromJson(Map<String, dynamic> json):
    id = json['id'], title = json['title'], text = json['text'], color = json['color'] == null ? json['color'] : int.parse(json['color']), pinned = json['pinned'];
  
}