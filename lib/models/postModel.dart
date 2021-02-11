import 'package:flutter/material.dart';

class Post {
  String title;
  String body;

  Post({@required this.title, @required this.body});

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        title: json['title'],
        body: json['body'],
      );
}
