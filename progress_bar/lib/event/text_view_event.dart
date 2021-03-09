abstract class TextViewEvent {}

class ChangeTextSize extends TextViewEvent {
  ChangeTextSize(this.size);
  final double size;
}

class ChangeTextColorRed extends TextViewEvent {
  ChangeTextColorRed(this.red);
  final int red;
}

class ChangeTextColorGreen extends TextViewEvent {
  ChangeTextColorGreen(this.green);
  final int green;
}

class ChangeTextColorBlue extends TextViewEvent {
  ChangeTextColorBlue(this.blue);
  final int blue;
}

class ChangeTextOpacity extends TextViewEvent {
  ChangeTextOpacity(this.opacity);
  final double opacity;
}
