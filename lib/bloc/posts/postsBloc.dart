import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testbloc/bloc/posts/postsEvent.dart';
import 'package:testbloc/bloc/posts/postsState.dart';
import 'package:testbloc/models/postModel.dart';
import 'package:testbloc/services/repository.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  Repository repository;

  PostsBloc(this.repository) : super(PostsEmptyState());

  _filterPost(List<Post> listPost, String filterQuery) {
    final regex = RegExp(filterQuery);
    return listPost.where((p) => regex.hasMatch(p.title)).toList();
  }

  @override
  Stream<PostsState> mapEventToState(PostsEvent event) async* {
    PostsState resultState;
    List<Post> _posts = await repository.getAllPosts();

    if (event is PostsLoadEvent) {
      resultState = PostsLoadingState();
      try {
        resultState = PostsLoadedState(loadedPosts: _posts);
      } catch (e) {
        resultState = PostsErrorState();
      }
    } else if (event is PostsFilterEvent) {
      try {
        _posts = _filterPost(_posts, event.filterQuery);

        resultState = _posts.length == 0
            ? PostNoSerchState()
            : PostsFilterState(filteredPosts: _posts);
      } catch (e) {
        resultState = PostsErrorState();
      }
    }
    yield resultState;
  }
}
