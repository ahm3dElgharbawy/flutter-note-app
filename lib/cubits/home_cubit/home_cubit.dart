
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqlite/models/note_model.dart';

import '../../class/sqldb.dart';
part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  ThemeData currentTheme = ThemeData.light();
  SqlDb db = SqlDb();
  List<NoteModel> notes = [];
  Future loadingNotes() async {
    notes.clear();
    emit(HomeLoading());
    List<Map> result = await db.select("select * from notes");
    if (result.isEmpty) {
      emit(HomeEmpty());
    } else {
      notes.addAll(result.map((note)=>NoteModel.fromJson(note)));
      emit(HomeSuccess());
    }
  }

  deletaAndUpdateNotes(int noteId) {
    notes.removeWhere((element) => element.id == noteId);
    emit(HomeSuccess());
  }
}
