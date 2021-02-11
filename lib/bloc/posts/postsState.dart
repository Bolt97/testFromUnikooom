import 'package:flutter/material.dart';
import 'package:testbloc/models/postModel.dart';

abstract class PostsState {}

class PostsEmptyState extends PostsState {}

class PostsLoadingState extends PostsState {}

class PostsErrorState extends PostsState {}

class PostsLoadedState extends PostsState {
  List<Post> loadedPosts;
  PostsLoadedState({@required this.loadedPosts}) : assert(loadedPosts != null);
}

class PostsFilterState extends PostsState {
  List<Post> filteredPosts;

  PostsFilterState({
    @required this.filteredPosts,
  }) : assert(filteredPosts != null);
}

class PostNoSerchState extends PostsState {}
