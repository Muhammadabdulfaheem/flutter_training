abstract class TabbarState {}

class TabbarInitial extends TabbarState {
  final int index;
  TabbarInitial({this.index = 0});
}

class TabbarTaped extends TabbarState {
  final int index;
  TabbarTaped(this.index);
}
