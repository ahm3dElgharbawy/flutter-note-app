import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqlite/class/sqldb.dart';

part 'edit_note_state.dart';

class EditNoteCubit extends Cubit<EditNoteState> {
  EditNoteCubit() : super(EditNoteInitial());

  SqlDb db = SqlDb();
  String selectedColor = "0xFFFFFFFF";

  void editNote({required int id,required String title,required String content,required String color}) async {
      int result = await db.update(
          "update notes set note='$content',title='$title',color='$color',date_time='${DateTime.now()}' where id=$id");
      if (result == 0) {
        emit(EditNoteFailure());
      } else {
        emit(EditNoteSuccess());
      }
  }

  void setColor({required String colorCode}) {
    selectedColor = colorCode;
    emit(ColorChanged());
  }
}
