import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqlite/class/sqldb.dart';

part 'add_note_state.dart';

class AddNoteCubit extends Cubit<AddNoteState> {
  AddNoteCubit() : super(AddNoteInitial());

  SqlDb db = SqlDb();
  String selectedColor = "0xffffffff";

  void addNote({required String title,required String content}) async{
      if(title == ""){
        title = "No Title";
      }
      int result = await db.insert("insert into notes (note,title,color,date_time) values ('$content','$title','$selectedColor','${DateTime.now()}')");
      if (result == 0) {
        emit(AddNoteFailure());
      } else {
        emit(AddNoteSuccess());
      }
  }

  void setColor({required String colorCode}){
    selectedColor = colorCode;
    emit(ColorChanged());
  }
}
