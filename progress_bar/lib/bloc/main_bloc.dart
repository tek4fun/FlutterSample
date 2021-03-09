import 'dart:async';
import '../state/main_state.dart';
import '../event/main_event.dart';

class MainBloc {
  var state = MainState([]);

  final eventController = StreamController<MainEvent>();

  final stateController = StreamController<MainState>();

  MainBloc() {
    eventController.stream.listen((event) {
      if (event is AddPage) {
        state = MainState([...state.widgets, event.pageName]);
      } else if (event is RemovePage) {
        state = MainState([]);
      }
      stateController.sink.add(state);
    });
  }

  void dispose() {
    stateController.close();
    eventController.close();
  }
}
