import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/helpers/view_style_helper.dart';

part 'view_style_event.dart';
part 'view_style_state.dart';

///this bloc is for handling the home page view if it's ListView or GridView
class ViewStyleBloc extends Bloc<ViewStyleEvent, ViewStyleState> {
  ///this is for getting the value from SharedPreferences
  ViewStyleBloc() : super(ViewStyleInitial()) {
    on<LoadViewStyleEvent>((event, emit) async {
      ViewStyleHelper viewStyleHelper = ViewStyleHelper();
      final prefs = await viewStyleHelper.getCachedViewStyle() ?? 0;
      emit(LoadedViewStyleState(currentStyle: prefs));
    });

    ///this is for setting the new value to SharedPreferences and sending it to UI
    on<ChangeViewStyleEvent>((event, emit) async {
      ViewStyleHelper viewStyleHelper = ViewStyleHelper();
      int flag = event.currentStyle;
      if (kDebugMode) {
        print('BEFORE Changed successfully from viewStyleBloc $flag');
      }
      flag = flag == 0 ? 1 : 0;
      if (kDebugMode) {
        print('Changed successfully from viewStyleBloc $flag');
      }
      await viewStyleHelper.cacheViewStyle(flag);
      emit(LoadedViewStyleState(currentStyle: flag));
    });
  }
}
