import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../ui.dart';
import 'note_detail_notifier.dart';

class NoteDetailsScreen extends StatelessWidget {
  final Note? note;

  const NoteDetailsScreen({Key? key, this.note}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool _isEdited = false;
    String _title = '';
    String _description = '';
    final repository = Provider.of<Repository>(context);
    return WillPopScope(
      onWillPop: () async {
        _isEdited ? showDiscardDialog(context) : Navigator.pop(context, true);
        return false;
      },
      child: Consumer<NoteDetailNotifier>(
        builder: (context, notifier, child) {
          return KeyboardDismisser(
            child: Scaffold(
              backgroundColor: AppHelper.colors[notifier.color],
              appBar: AppBar(
                elevation: 0,
                title: Text(
                  note != null ? 'Edit note' : 'Add note',
                  style: Theme.of(context).textTheme.headline5,
                ),
                backgroundColor: AppHelper.colors[notifier.color],
                leading: IconButton(
                  splashRadius: 22,
                  icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
                  onPressed: () {
                    _isEdited
                        ? showDiscardDialog(context)
                        : Navigator.pop(context, true);
                  },
                ),
                actions: <Widget>[
                  IconButton(
                    splashRadius: 22,
                    icon: const Icon(
                      Icons.save,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      _title.trim().isEmpty
                          ? showEmptyTitleDialog(context)
                          : _save(
                              context,
                              title: _title,
                              description: _description,
                              repository: repository,
                              color: notifier.color,
                              priority: notifier.priority,
                            );
                    },
                  ),
                  IconButton(
                    splashRadius: 22,
                    icon: const Icon(Icons.delete, color: Colors.black),
                    onPressed: () {
                      showDeleteDialog(context, repository);
                    },
                  )
                ],
              ),
              body: Container(
                color: AppHelper.colors[notifier.color],
                child: Column(
                  children: <Widget>[
                    PriorityPicker(
                      selectedIndex: notifier.priority,
                      onTap: (index) {
                        _isEdited = true;
                        notifier.changePriority(index);
                      },
                    ),
                    ColorPicker(
                      selectedIndex: notifier.color,
                      onTap: (index) {
                        // setState(() {
                        //   _color = index;
                        // });
                        _isEdited = true;
                        notifier.changeColor(index);
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextField(
                        maxLength: 255,
                        style: Theme.of(context).textTheme.bodyText2,
                        onChanged: (value) {
                          _isEdited = true;
                          _title = value;
                        },
                        decoration: const InputDecoration.collapsed(
                          hintText: 'Title',
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: TextField(
                          keyboardType: TextInputType.multiline,
                          maxLines: 10,
                          maxLength: 255,
                          style: Theme.of(context).textTheme.bodyText1,
                          onChanged: (value) {
                            _isEdited = true;
                            _description = value;
                          },
                          decoration: const InputDecoration.collapsed(
                            hintText: 'Description',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void showDiscardDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          title: Text(
            "Discard Changes?",
            style: Theme.of(context).textTheme.bodyText2,
          ),
          content: Text(
            "Are you sure you want to discard changes?",
            style: Theme.of(context).textTheme.bodyText1,
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                "No",
                style: Theme.of(context)
                    .textTheme
                    .bodyText2
                    ?.copyWith(color: Colors.purple),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(
                "Yes",
                style: Theme.of(context)
                    .textTheme
                    .bodyText2
                    ?.copyWith(color: Colors.purple),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pop(context, true);
              },
            ),
          ],
        );
      },
    );
  }

  void showEmptyTitleDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          title: Text(
            "Title is empty!",
            style: Theme.of(context).textTheme.bodyText2,
          ),
          content: Text(
            'The title of the note cannot be empty.',
            style: Theme.of(context).textTheme.bodyText1,
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                "Okay",
                style: Theme.of(context)
                    .textTheme
                    .bodyText2
                    ?.copyWith(color: Colors.purple),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _save(
    BuildContext context, {
    required String title,
    String? description,
    required Repository repository,
    int? color,
    int? priority,
  }) async {
    Navigator.pop(context, true);

    final date = DateFormat.yMMMd().format(DateTime.now());
    if (note != null) {
      final newNote = note!.copyWith(
        title: title,
        description: description,
        date: date,
        color: color,
        priority: priority,
      );
      await repository.updateNote(newNote);
    } else {
      final newNote = Note(
        title: title,
        description: description,
        date: date,
        color: color,
        priority: priority,
      );
      await repository.insertNote(newNote);
    }
  }

  void showDeleteDialog(BuildContext context, Repository repository) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          title: Text(
            "Delete Note?",
            style: Theme.of(context).textTheme.bodyText2,
          ),
          content: Text(
            "Are you sure you want to delete this note?",
            style: Theme.of(context).textTheme.bodyText1,
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                "No",
                style: Theme.of(context)
                    .textTheme
                    .bodyText2
                    ?.copyWith(color: Colors.purple),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(
                "Yes",
                style: Theme.of(context)
                    .textTheme
                    .bodyText2
                    ?.copyWith(color: Colors.purple),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                _delete(context, repository);
              },
            ),
          ],
        );
      },
    );
  }

  void _delete(BuildContext context, Repository repository) async {
    if (note != null) {
      await repository.deleteNote(note!);
    }
    Navigator.pop(context, true);
  }
}
