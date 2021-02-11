abstract class PostsEvent {}

class PostsLoadEvent extends PostsEvent {}

class PostsFilterEvent extends PostsEvent {
  String filterQuery;

  PostsFilterEvent(this.filterQuery);
}
