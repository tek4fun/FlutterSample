import 'dart:async';

import '../event/text_view_event.dart';
import '../state/text_view_state.dart';

class TextViewBloc {
  var state = TextViewState(20.0, 0, 0, 0, 1.0);

  final eventController = StreamController<TextViewEvent>();

  final stateController = StreamController<TextViewState>();

  TextViewBloc() {
    eventController.stream.listen((event) {
      if (event is ChangeTextSize) {
        state = TextViewState(
            event.size, state.red, state.green, state.blue, state.opacity);
      } else if (event is ChangeTextColorRed) {
        state = TextViewState(
            state.size, event.red, state.green, state.blue, state.opacity);
      } else if (event is ChangeTextColorGreen) {
        state = TextViewState(
            state.size, state.red, event.green, state.blue, state.opacity);
      } else if (event is ChangeTextColorBlue) {
        state = TextViewState(
            state.size, state.red, state.green, event.blue, state.opacity);
      } else if (event is ChangeTextOpacity) {
        state = TextViewState(
            state.size, state.red, state.green, state.blue, event.opacity);
      }
      stateController.sink.add(state);
    });
  }

  void dispose() {
    eventController.close();
    stateController.close();
  }
}
