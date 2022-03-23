import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'data/db/notes_repository.dart';
import 'data/repository.dart';
import 'routes/app_router.gr.dart';
import 'ui/details/note_detail_notifier.dart';
import 'data/models/models.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(NoteDataAdapter());
  await Hive.openBox<NoteData>('notes');
  // final repository = NotesRepository();
  // await repository.init();
  final appRouter = AppRouter();
  runApp(
    MyApp(/*repository: repository,*/ appRouter: appRouter),
  );
}

class MyApp extends StatelessWidget {
  // final Repository repository;
  final AppRouter appRouter;

  const MyApp({Key? key,/* required this.repository,*/ required this.appRouter})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Provider<Repository>(
        //   lazy: false,
        //   create: (_) => repository,
        //   dispose: (_, Repository repository) => repository.close(),
        // ),
        ChangeNotifierProvider<NoteDetailNotifier>(
          lazy: false,
          create: (_) => NoteDetailNotifier(),
        ),
      ],
      child: MaterialApp.router(
        title: 'Notes App',
        debugShowCheckedModeBanner: false,
        routerDelegate: appRouter.delegate(),
        routeInformationParser: appRouter.defaultRouteParser(),
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
          textTheme: TextTheme(
            headline5: GoogleFonts.poppins(
              textStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 24,
              ),
            ),
            bodyText2: GoogleFonts.poppins(
              textStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 20,
              ),
            ),
            bodyText1: GoogleFonts.poppins(
              textStyle: const TextStyle(
                fontWeight: FontWeight.normal,
                color: Colors.black,
                fontSize: 18,
              ),
            ),
            subtitle2: GoogleFonts.poppins(
              textStyle: const TextStyle(
                fontWeight: FontWeight.normal,
                color: Colors.black,
                fontSize: 14,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
