import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqlite/class/helper.dart';
import 'package:sqlite/cubits/edit_note_cubit/edit_note_cubit.dart';
import 'package:sqlite/models/note_model.dart';
import 'package:sqlite/view/widgets/content_text_field.dart';
import 'package:sqlite/view/widgets/custom_bottom_bar.dart';
import 'package:sqlite/view/widgets/custom_appbar.dart';
import 'package:sqlite/view/widgets/title_text_field.dart';

import '../widgets/edit_note/edit_note_bottom_sheet_body.dart';

class EditNote extends StatefulWidget {
  final NoteModel data;

  const EditNote({Key? key, required this.data}) : super(key: key);

  @override
  State<EditNote> createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
  late GlobalKey<FormState> formstate;
  late TextEditingController contentController;
  late TextEditingController titleController;
  late NoteModel note;
  @override
  void initState() {
    super.initState();
    note = widget.data;
    formstate = GlobalKey();
    contentController = TextEditingController();
    titleController = TextEditingController();
    contentController.text = note.note!;
    titleController.text = note.title!;
  }

  @override
  void dispose() {
    super.dispose();
    contentController.dispose();
    titleController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var blocProvider = BlocProvider.of<EditNoteCubit>(context);
    blocProvider.selectedColor = note.color!;
    return BlocConsumer<EditNoteCubit, EditNoteState>(
      listener: (context, state) {
        if (state is EditNoteFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('failed to update the note')),
          );
        } else if (state is EditNoteSuccess) {
          Navigator.of(context).pushNamedAndRemoveUntil("/", (route) => false);
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: getColor(colorCode: blocProvider.selectedColor),
          appBar: CustomAppBar(
              action: IconButton(
                splashRadius: 20,
                onPressed: () {
                  blocProvider.editNote(
                    id: note.id!,
                    title: titleController.text,
                    content: contentController.text,
                    color: blocProvider.selectedColor,
                  );
                },
                icon: const Icon(Icons.check),
              ),
              title: "Edit Note"),
          body: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                Expanded(
                  child: ListView(children: [
                    Column(
                      children: [
                        TitleTextField(
                          hintText: 'Title',
                          controller: titleController,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        ContentTextField(
                          hintText: 'Note',
                          controller: contentController,
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                    const SizedBox(height: 20),
                  ]),
                ),
                CustomBottomBar(
                  dateTime: note.dateTime,
                  onTapColorIcon: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (context) => const EditNoteBottomSheetBody(),
                        enableDrag: true);
                  },
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
