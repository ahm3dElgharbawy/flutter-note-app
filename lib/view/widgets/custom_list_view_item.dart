import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqlite/class/helper.dart';
import 'package:sqlite/cubits/home_cubit/home_cubit.dart';
import 'package:sqlite/models/note_model.dart';
import 'package:sqlite/view/screens/edit_note.dart';

class CustomListViewItem extends StatelessWidget {
  const CustomListViewItem({
    super.key,
    required this.note,
  });

  final NoteModel note;

  @override
  Widget build(BuildContext context) {
    final homeCubit = BlocProvider.of<HomeCubit>(context);
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: getColor(colorCode: note.color!),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        title: Text(
          note.title!,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          note.note!,
          maxLines: 1,
        ),
        onTap: () async {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => EditNote(data: note),
            ),
          );
        },
        onLongPress: () async {
          int result = await homeCubit.db
              .delete("delete from notes where id = ${note.id}");
          if (result != 0) {
            homeCubit.deletaAndUpdateNotes(note.id!);
          }
        },
      ),
    );
  }
}
