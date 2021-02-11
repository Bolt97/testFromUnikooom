import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testbloc/bloc/card/cardBloc.dart';
import 'package:testbloc/bloc/card/cardEvent.dart';
import 'package:testbloc/bloc/posts/postsBloc.dart';
import 'package:testbloc/bloc/posts/postsState.dart';
import 'package:testbloc/models/postModel.dart';
import 'package:testbloc/screen/moreScreen.dart';
import 'package:testbloc/widget/cardWidget.dart';

class PostsList extends StatelessWidget {
  Widget _listViewBuilder({@required List<Post> item}) => ListView.builder(
        itemCount: item.length,
        itemBuilder: (BuildContext context, int index) => CardWidget(
          index: index,
          title: item[index].title,
          body: item[index].body,
          onPress: () => _openMore(
            context: context,
            title: item[index].title,
            body: item[index].body,
          ),
        ),
      );

  void _openMore({
    context,
    @required String title,
    @required String body,
  }) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => MoreScreenWidget(
              title: title,
              body: body,
            )));
  }

  @override
  Widget build(BuildContext context) {
    Widget resultWidget = Text('sdsdsd');

    // ignore: close_sinks
    CardBloc _cardBloc = BlocProvider.of<CardBloc>(context);

    return BlocBuilder<PostsBloc, PostsState>(
        builder: (BuildContext context, PostsState state) {
      if (state is PostsEmptyState) {
        resultWidget = Center(
          child: Text(
            'Please wait, data loading...',
            style: TextStyle(fontSize: 24),
          ),
        );
      } else if (state is PostsLoadingState) {
        resultWidget = Center(
          child: CircularProgressIndicator(),
        );
      } else if (state is PostsLoadedState) {
        _cardBloc.add(CardInitEvent(state.loadedPosts.length));
        resultWidget = _listViewBuilder(item: state.loadedPosts);
      } else if (state is PostsErrorState) {
        resultWidget = Center(
          child: Text('Error fetching posts.'),
        );
      } else if (state is PostsFilterState) {
        resultWidget = _listViewBuilder(item: state.filteredPosts);
      } else if (state is PostNoSerchState)
        resultWidget = Center(
          child: Text('По вашему запросу ничего не найдено'),
        );
      return resultWidget;
    });
  }
}
