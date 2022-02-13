import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:provider/provider.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

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
          final List<Note> notes = snapshot.data ?? [];
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
            body: notes.isEmpty
                ? Container(
                    color: Colors.white,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          'Click on the add button to add a new note!',
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                      ),
                    ),
                  )
                : Container(
                    color: Colors.white,
                    child: MasonryGridView.count(
                      physics: const BouncingScrollPhysics(),
                      itemCount: notes.length,
                      mainAxisSpacing: 4.0,
                      crossAxisSpacing: 4.0,
                      crossAxisCount: 4,
                      itemBuilder: (BuildContext context, int index) =>
                          GestureDetector(
                        onTap: () {
                          // navigateToDetail(noteList[index], 'Edit Note');
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            padding: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              color: AppHelper.colors[notes[index].color ?? 0],
                              border: Border.all(width: 2, color: Colors.black),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Column(
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          notes[index].title ?? '',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText2,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      AppHelper.getPriorityText(
                                          notes[index].priority ?? 0),
                                      style: TextStyle(
                                        color: AppHelper.getPriorityColor(
                                            notes[index].priority ?? 0),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Expanded(
                                        child: Text(
                                          notes[index].description ?? '',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Text(
                                      notes[index].date ?? '',
                                      style:
                                          Theme.of(context).textTheme.subtitle2,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                context.pushRoute(const NoteDetailsRoute());
              },
              tooltip: 'Add Note',
              shape: const CircleBorder(
                side: BorderSide(color: Colors.black, width: 2.0),
              ),
              child: const Icon(Icons.add, color: Colors.black),
              backgroundColor: Colors.white,
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}
