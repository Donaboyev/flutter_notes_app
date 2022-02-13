import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'data/db/notes_repository.dart';
import 'data/repository.dart';
import 'routes/app_router.gr.dart';
import 'ui/details/note_detail_notifier.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final repository = NotesRepository();
  await repository.init();
  final appRouter = AppRouter();
  runApp(
    MyApp(repository: repository, appRouter: appRouter),
  );
}

class MyApp extends StatelessWidget {
  final Repository repository;
  final AppRouter appRouter;

  const MyApp({Key? key, required this.repository, required this.appRouter})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<Repository>(
          lazy: false,
          create: (_) => repository,
          dispose: (_, Repository repository) => repository.close(),
        ),
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
      ),
    );
  }
}
