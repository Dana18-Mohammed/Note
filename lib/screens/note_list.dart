import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes_app/db_helper/db_helper.dart';
import 'package:notes_app/modal_class/notes.dart';
import 'package:notes_app/screens/note_detail.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:notes_app/utils/widgets.dart';
import 'package:sqflite/sqflite.dart';

class NoteList extends StatefulWidget {
  const NoteList({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return NoteListState();
  }
}

class NoteListState extends State<NoteList> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Note> noteList;
  int count = 0;
  int axisCount = 2;
  Color bckgroud = new Color(0xffCBF0F8);
  Color mycolor = new Color(0xff1321E0);
  Color x = new Color(0xff004d99);
  @override
  Widget build(BuildContext context) {
    if (noteList == null) {
      noteList = [];
      updateListView();
    }
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('MY Notes',
              textAlign: TextAlign.center, style: GoogleFonts.openSans()
              // lato(fontStyle: FontStyle.italic)
              ),
        ),
        backgroundColor: mycolor,
        foregroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: noteList.isEmpty
          ? Container(color: bckgroud, child: getNoNotes())
          : Container(
              color: bckgroud,
              child: getNotesList(),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          navigateToDetail(Note('', '', 0), 'Add Note');
        },
        tooltip: 'Add new Notes',
        child: Container(
          height: 60,
          width: 60,
          child: const Icon(
            Icons.add,
            size: 50,
          ),
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(colors: [
                // x,
                mycolor,
                Colors.deepPurple,
                mycolor,
                Colors.purple,
              ])),
        ),
      ),
    );
  }

  Widget getNoNotes() {
    return Column(children: [
      SizedBox(
        height: 150,
      ),
      Container(
        alignment: Alignment.center,
        width: double.infinity,
        padding: EdgeInsets.only(left: 45),
        height: 260,
        child: Image.asset(
          'lib/images/home_icon.jpg',
        ),
      ),
      SizedBox(
        height: 6,
      ),
      Text(
        "No Notes :(",
        style: GoogleFonts.openSans(
            color: mycolor, fontSize: 24, fontWeight: FontWeight.w500),
      ),
      SizedBox(
        height: 20,
      ),
      Text(
        "You have no task to do.",
        style: GoogleFonts.openSans(color: Colors.blueGrey[300], fontSize: 14),
      )
    ]);
  }

  Widget getNotesList() {
    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int index) => GestureDetector(
                  onTap: () {
            navigateToDetail(noteList[index], 'Edit Note');
          },
          child: Padding(
              padding: EdgeInsets.all(18.0),
              child: Container(
                padding: const EdgeInsets.all(18.0),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  border: Border(
                    // top: BorderSide(width: 2, color: Colors.white),
                    left: BorderSide(
                        color: colors[noteList[index].color],
                        width: 5,
                        style: BorderStyle.solid),
                  ),

                  boxShadow: [
                    BoxShadow(
                      color: Colors.white,
                      offset: const Offset(
                        0.2,
                        0.2,
                      ),
                      blurRadius: 2,
                      spreadRadius: 0.1,
                    ),
                  ],
                ),


                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 0.0, top: 8.0, right: 8.0, bottom: 0.0),
                            child: Text(
                              noteList[index].title,
                              style: TextStyle(
                                  color: mycolor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 0.0, top: 10.0, right: 8.0, bottom: 0.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                              child: Text(
                            noteList[index].description ?? '',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          ))
                        ],
                      ),
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Text(noteList[index].date,
                              style:
                                  TextStyle(fontSize: 10, color: Colors.grey)),
                        ])
                  ],
                ),
                // decoration: BoxDecoration(
                //   borderRadius: BorderRadius.circular(8),
                //   // borderRadius: BorderRadius.all(Radius.circular(8.0)),
                //   color: Colors.white,
                //   // border: Border(
                //   //   // top: BorderSide(width: 2, color: Colors.white),
                //   //   left: BorderSide(
                //   //       color: colors[noteList[index].color],
                //   //       width: 6,
                //   //       style: BorderStyle.solid),
                //   //   // bottom: BorderSide(width: 2, color: Colors.white),
                //   //   // right: BorderSide(width: 2, color: Colors.white),
                //   // ),
                //   // border: Border.fromBorderSide(
                //   //
                //   //     BorderSide(color: colors[noteList[index].color], width: 6)),
                //   //
                //
                //   // boxShadow: [
                //   //   BoxShadow(
                //   //     color: Colors.white,
                //   //     offset: const Offset(
                //   //       1.0,
                //   //       1.0,
                //   //     ),
                //   //     blurRadius: 10.0,
                //   //     spreadRadius: 2.0,
                //   //   ),
                //   //   BoxShadow(
                //   //     color: Colors.white,
                //   //     offset: const Offset(0.0, 0.0),
                //   //     blurRadius: 0.0,
                //   //     spreadRadius: 1.0,
                //   //   ), //BoxShadow
                //   // ],
                //                   ),
                // decoration: ShapeDecoration(
                //
                //   color: Colors.white,
                // shape: RoundedRectangleBorder(
                //   side: BorderSide(
                //    color: colors[noteList[index].color]),
                //   borderRadius: BorderRadius.all(
                //
                // Radius.circular(10),),
                // ),
                //     )
              ))),
    );
  }

  void navigateToDetail(Note note, String title) async {
    bool result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => NoteDetail(note)));
    if (result == true) {
      updateListView();
    }
  }

  void updateListView() {
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<Note>> noteListFuture = databaseHelper.getNoteList();
      noteListFuture.then((noteList) {
        setState(() {
          this.noteList = noteList;
          count = noteList.length;
        });
      });
    });
  }
}
