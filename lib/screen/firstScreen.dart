import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testbloc/bloc/posts/postsBloc.dart';
import 'package:testbloc/bloc/posts/postsEvent.dart';
import 'package:testbloc/widget/filterWidget.dart';
import 'package:testbloc/widget/postsList.dart';

class FirstScreenWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    final PostsBloc postsBloc = BlocProvider.of<PostsBloc>(context);
    postsBloc.add(PostsLoadEvent());
    return Scaffold(
      appBar: AppBar(
        title: Text('Тестовое задание для Unikoom'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextFiledWidget(),
          ),
          Expanded(child: PostsList()),
        ],
      ),
    );
  }
}
