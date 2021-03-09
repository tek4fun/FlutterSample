abstract class MainEvent {}

class AddPage extends MainEvent {
  AddPage(this.pageName);
  final String pageName;
}

class RemovePage extends MainEvent {
  RemovePage();
}
