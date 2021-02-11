abstract class CardEvent {}

class CardInitEvent extends CardEvent {
  int count;
  CardInitEvent(this.count);
}

class CardPressEvent extends CardEvent {
  int index;

  CardPressEvent(this.index);
}
