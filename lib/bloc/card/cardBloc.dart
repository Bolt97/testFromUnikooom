import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testbloc/bloc/card/cardEvent.dart';
import 'package:testbloc/bloc/card/cardState.dart';

class CardBloc extends Bloc<CardEvent, CardState> {
  List<bool> _listState = [];

  CardBloc({CardState initialState}) : super(initialState);

  List<bool> _initCard(int countCard) {
    for (var i = 0; i < countCard; i++) {
      _listState.add(false);
    }

    return _listState;
  }

  void _changeListState(int indexOpen, int eventIndex) {
    if (indexOpen == -1)
      _listState[eventIndex] = true;
    else if (eventIndex == indexOpen)
      _listState[eventIndex] = false;
    else {
      _listState[indexOpen] = false;
      _listState[eventIndex] = true;
    }
  }

  @override
  Stream<CardState> mapEventToState(CardEvent event) async* {
    CardState resultState;

    if (event is CardInitEvent) {
      resultState = CardState(_initCard(event.count));
    } else if (event is CardPressEvent) {
      _changeListState(
        _listState.indexWhere((element) => element == true),
        event.index,
      );

      resultState = CardState(_listState);
    }

    yield resultState;
  }
}
