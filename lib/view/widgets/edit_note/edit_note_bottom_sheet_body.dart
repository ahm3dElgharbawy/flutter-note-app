import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqlite/class/helper.dart';
import 'package:sqlite/class/note_styles.dart';
import 'package:sqlite/cubits/edit_note_cubit/edit_note_cubit.dart';


class EditNoteBottomSheetBody extends StatelessWidget {
  const EditNoteBottomSheetBody({super.key});

  @override
  Widget build(BuildContext context) {
    NoteStyles noteStyles = NoteStyles();
    var cubit =  BlocProvider.of<EditNoteCubit>(context);

    return BlocBuilder<EditNoteCubit, EditNoteState>(
      builder: (context, state) {
        return Container(
          color: const Color(0xffadc9df),
          height: 130,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Padding(
                padding: EdgeInsets.only(top:20,left: 10),
                child: Text("Note Color"),
              ),
              Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: noteStyles.colors.length,
                  itemBuilder: (context, i) => Center(
                    child: GestureDetector(
                      onTap: () {
                        cubit.setColor(colorCode: noteStyles.colors[i]);
                      },
                      child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black38, width: 2),
                            color: getColor(colorCode: noteStyles.colors[i]),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: noteStyles.colors[i] == cubit.selectedColor
                              ? const Icon(Icons.check)
                              : null),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
