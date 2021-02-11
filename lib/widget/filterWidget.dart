import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testbloc/bloc/posts/postsBloc.dart';
import 'package:testbloc/bloc/posts/postsEvent.dart';

class TextFiledWidget extends StatefulWidget {
  @override
  _TextFiledWidgetState createState() => _TextFiledWidgetState();
}

class _TextFiledWidgetState extends State<TextFiledWidget> {
  TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    this._textController.addListener(_onFilterChanged);

    super.initState();
  }

  void _onFilterChanged() {
    // ignore: close_sinks
    final PostsBloc postsBloc = BlocProvider.of<PostsBloc>(context);
    postsBloc.add(PostsFilterEvent(this._textController.text));
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: this._textController,
      decoration: InputDecoration(hintText: 'Enter text to filter title'),
    );
  }
}
