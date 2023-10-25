import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqlite/class/helper.dart';
import 'package:sqlite/cubits/add_note_cubit/add_note_cubit.dart';
import 'package:sqlite/view/widgets/add_note/add_note_bottom_sheet_body.dart';
import 'package:sqlite/view/widgets/content_text_field.dart';
import 'package:sqlite/view/widgets/custom_bottom_bar.dart';
import 'package:sqlite/view/widgets/custom_appbar.dart';
import 'package:sqlite/view/widgets/title_text_field.dart';

class AddNote extends StatefulWidget {
  const AddNote({Key? key}) : super(key: key);

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  late GlobalKey<FormState> formstate;
  late TextEditingController contentController;
  late TextEditingController titleController;
  @override
  void initState() {
    super.initState();
    formstate = GlobalKey();
    contentController = TextEditingController();
    titleController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    contentController.dispose();
    titleController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var blocProvider = BlocProvider.of<AddNoteCubit>(context);
    return BlocConsumer<AddNoteCubit, AddNoteState>(listener: (context, state) {
      if (state is AddNoteFailure) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('failed to create the note'),
          ),
        );
      } else if (state is AddNoteSuccess) {
        Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
      }
    }, builder: (context, state) {
      return Scaffold(
          backgroundColor: getColor(colorCode: blocProvider.selectedColor),
          appBar: CustomAppBar(
              action: IconButton(
                splashRadius: 20,
                onPressed: () {
                  blocProvider.addNote(
                      title: titleController.text,
                      content: contentController.text);
                },
                icon: const Icon(Icons.check),
              ),
              title: "Add New Note"),
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
                  onTapColorIcon: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (context) => const AddNoteBottomSheetBody(),
                        enableDrag: true);
                  },
                )
              ],
            ),
          ));
    });
  }
}
