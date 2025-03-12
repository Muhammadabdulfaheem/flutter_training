import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_training_project/screens/tabbar/bloc/tabbar_state.dart';

class TabbarCubit extends Cubit<TabbarState> {
  TabbarCubit() : super(TabbarInitial());

  void updatedIndex(int index) {
    emit(TabbarTaped(index));
  }
}
