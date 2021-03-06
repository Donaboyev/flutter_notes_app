// import 'package:flutter/material.dart';
//
// import '../ui.dart';
//
// class NoteSearchDelegate extends SearchDelegate<Note?> {
//   @override
//   List<Widget>? buildActions(BuildContext context) {
//     return [
//       IconButton(
//         splashRadius: 22,
//         icon: const Icon(
//           Icons.clear,
//           color: Colors.black,
//         ),
//         onPressed: () {
//           query = '';
//         },
//       )
//     ];
//   }
//
//   @override
//   Widget? buildLeading(BuildContext context) {
//     return IconButton(
//       splashRadius: 22,
//       icon: const Icon(
//         Icons.arrow_back,
//         color: Colors.black,
//       ),
//       onPressed: () {
//         close(context, null);
//       },
//     );
//   }
//
//   @override
//   Widget buildResults(BuildContext context) {
//     if (query == '') {
//       return Container(
//         color: Colors.white,
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: const [
//               SizedBox(
//                 width: 50,
//                 height: 50,
//                 child: Icon(
//                   Icons.search,
//                   size: 50,
//                   color: Colors.black,
//                 ),
//               ),
//               Text(
//                 'Enter a note to search.',
//                 style: TextStyle(color: Colors.black),
//               )
//             ],
//           ),
//         ),
//       );
//     } else {
//       filteredNotes = [];
//       getFilteredList(notes);
//       if (filteredNotes.isEmpty) {
//         return Container(
//           color: Colors.white,
//           child: Center(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: const <Widget>[
//                 SizedBox(
//                   width: 50,
//                   height: 50,
//                   child: Icon(
//                     Icons.sentiment_dissatisfied,
//                     size: 50,
//                     color: Colors.black,
//                   ),
//                 ),
//                 Text(
//                   'No results found',
//                   style: TextStyle(color: Colors.black),
//                 )
//               ],
//             ),
//           ),
//         );
//       } else {
//         return Container(
//           color: Colors.white,
//           child: ListView.builder(
//             itemCount: filteredNotes.length ?? 0,
//             itemBuilder: (context, index) {
//               return ListTile(
//                 leading: const Icon(
//                   Icons.note,
//                   color: Colors.black,
//                 ),
//                 title: Text(
//                   filteredNotes[index].title,
//                   style: const TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 18.0,
//                       color: Colors.black),
//                 ),
//                 subtitle: Text(
//                   filteredNotes[index].description,
//                   style: const TextStyle(fontSize: 14.0, color: Colors.grey),
//                 ),
//                 onTap: () {
//                   close(context, filteredNotes[index]);
//                 },
//               );
//             },
//           ),
//         );
//       }
//     }
//   }
//
//   @override
//   Widget buildSuggestions(BuildContext context) {
//     // TODO: implement buildSuggestions
//     throw UnimplementedError();
//   }
// }
