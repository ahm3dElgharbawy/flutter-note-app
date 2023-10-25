import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqlite/cubits/home_cubit/home_cubit.dart';

class GetAllert extends StatelessWidget {
  final int noteIndex;
  const GetAllert({super.key, required this.noteIndex});

  @override
  Widget build(BuildContext context) {
    var blocProvider = BlocProvider.of<HomeCubit>(context);
    return AlertDialog(
      title: const Text("remove this note are you sure ?",
          textAlign: TextAlign.left),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("No"),
            ),
            const SizedBox(
              width: 20,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () async {
                if (context.mounted) {
                  int result = await blocProvider.db.delete(
                      "delete from notes where id = ${blocProvider.notes[noteIndex].id!}");
                  if (result != 0) {
                    blocProvider.deletaAndUpdateNotes(
                        blocProvider.notes[noteIndex].id!);
                  }
                  Navigator.pop(context);
                }
              },
              child: const Text("Yes"),
            ),
          ],
        )
      ],
    );
  }
}
