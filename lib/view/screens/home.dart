import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqlite/cubits/home_cubit/home_cubit.dart';
import 'package:sqlite/view/widgets/custom_appbar.dart';
import 'package:sqlite/view/widgets/custom_list_view_item.dart';

class Home extends StatelessWidget {
  const Home({super.key});
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<HomeCubit>(context).loadingNotes();
    var blocProvider = BlocProvider.of<HomeCubit>(context);
    return Scaffold(
      // backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: "My Notes",
        action: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: GestureDetector(
              onTap: () {
                // themeProvider.switchTheme(); //? change theme function
              },
              child: const Icon(
                Icons.light_mode,
                color: Colors.orange,
              )),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed('addNote');
        },
        child: const Icon(Icons.add),
      ),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state is HomeLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is HomeSuccess) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: ScrollConfiguration(
                behavior: const ScrollBehavior().copyWith(overscroll: false),
                child: ListView.builder(
                    itemCount: blocProvider.notes.length,
                    itemBuilder: (BuildContext context, int i) {
                      return CustomListViewItem(note: blocProvider.notes[i]);
                    }),
              ),
            );
          } else {
            return Center(
              child: Image.asset(
                "assets/empty.png",
                height: 120,
              ),
            );
          }
        },
      ),
    );
  }
}

