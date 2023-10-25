import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqlite/cubits/add_note_cubit/add_note_cubit.dart';
import 'package:sqlite/cubits/edit_note_cubit/edit_note_cubit.dart';
import 'package:sqlite/cubits/home_cubit/home_cubit.dart';
import 'package:sqlite/theme_provider.dart';
import 'package:sqlite/view/screens/add_note.dart';
import 'package:sqlite/view/screens/home.dart';

ThemeProvider themeProvider = ThemeProvider();
void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => HomeCubit()),
        BlocProvider(create: (context) => AddNoteCubit()),
        BlocProvider(create: (context) => EditNoteCubit()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    // ? listen on theme changed and refresh MaterialApp()
    themeProvider.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(fontFamily: 'Nunito'),
        debugShowCheckedModeBanner: false,
        routes: {
          "/": (context) => const Home(),
          "addNote": (context) => const AddNote(),
        });
  }
}
