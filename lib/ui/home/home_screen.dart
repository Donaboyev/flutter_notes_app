import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:provider/provider.dart';

import '../ui.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final repository = Provider.of<Repository>(context, listen: false);
    return StreamBuilder<List<Note>>(
      stream: repository.watchAllNotes(),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final notes = snapshot.data ?? [];
          return Scaffold(
            appBar: AppBar(
              title:
                  Text('Notes', style: Theme.of(context).textTheme.headline5),
              centerTitle: true,
              elevation: 0,
              backgroundColor: Colors.white,
              leading: notes.isEmpty
                  ? const SizedBox()
                  : IconButton(
                      splashRadius: 22,
                      icon: const Icon(
                        Icons.search,
                        color: Colors.black,
                      ),
                      onPressed: () async {
                        // final Note result = await showSearch(
                        //     context: context,
                        //     delegate: NotesSearch(notes: noteList));
                        // if (result != null) {
                        //   navigateToDetail(result, 'Edit Note');
                        // }
                      },
                    ),
              actions: <Widget>[
                notes.isEmpty
                    ? Container()
                    : IconButton(
                        splashRadius: 22,
                        icon: Icon(
                          /*axisCount == 2 ?*/
                          Icons.list /*: Icons.grid_on*/,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          // setState(() {
                          //   axisCount = axisCount == 2 ? 4 : 2;
                          // });
                        },
                      )
              ],
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Home screen'),
                  TextButton(
                    onPressed: () {
                      context.pushRoute(const NoteDetailsRoute());
                    },
                    child: const Text('Go to details screen'),
                  ),
                  TextButton(
                    onPressed: () {
                      context.pushRoute(const SearchRoute());
                    },
                    child: const Text('Go to search screen'),
                  ),
                ],
              ),
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}
