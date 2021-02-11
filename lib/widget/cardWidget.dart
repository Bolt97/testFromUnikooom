import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testbloc/bloc/card/cardBloc.dart';
import 'package:testbloc/bloc/card/cardEvent.dart';
import 'package:testbloc/bloc/card/cardState.dart';

class CardWidget extends StatelessWidget {
  final int index;
  final String title;
  final String body;
  final Function onPress;

  CardWidget({
    @required this.index,
    @required this.title,
    @required this.body,
    @required this.onPress,
  });

  Widget _buildWidget({
    @required BuildContext context,
    @required bool isOpen,
  }) {
    return Card(
      shadowColor: Colors.black,
      margin: EdgeInsets.all(8),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    this.title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Icon(
                  isOpen
                      ? Icons.arrow_drop_up_rounded
                      : Icons.arrow_drop_down_rounded,
                  size: 44,
                  color: Theme.of(context).accentColor,
                ),
              ],
            ),
          ),
          if (isOpen)
            Container(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      this.body,
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: FlatButton(
                      textColor: Theme.of(context).accentColor,
                      child: Text('Подробнее'),
                      onPressed: this.onPress,
                    ),
                  ),
                ],
              ),
            )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget resultWidget = _buildWidget(context: context, isOpen: false);
    // ignore: close_sinks
    CardBloc _cardBloc = BlocProvider.of<CardBloc>(context);

    return GestureDetector(
      onTap: () {
        _cardBloc.add(CardPressEvent(this.index));
      },
      child: BlocBuilder<CardBloc, CardState>(
          builder: (BuildContext context, CardState state) {
        if (state is CardState) {
          resultWidget = _buildWidget(
            context: context,
            isOpen: state.listItem[this.index],
          );
        }

        return resultWidget;
      }),
    );
  }
}
