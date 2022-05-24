import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notes_app/db_helper/db_helper.dart';
import 'package:notes_app/modal_class/notes.dart';
import 'package:notes_app/utils/widgets.dart';

class NoteDetail extends StatefulWidget {
  final Note note;
  NoteDetail(this.note);
  @override
  State<StatefulWidget> createState() {
    return NoteDetailState(this.note);
  }
}

class NoteDetailState extends State<NoteDetail> {
  DatabaseHelper helper = DatabaseHelper();
  Color bckgroud = new Color(0xffCBF0F8);
  Color mycolor = new Color(0xff1321E0);
  Color p = new Color(0xffFBCFE9);
  // String appBarTitle;
  Note note;
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  int color;
  bool isEdited = false;
  NoteDetailState(this.note);
  // NoteDetailState(this.note, this.appBarTitle);

  @override
  Widget build(BuildContext context) {
    titleController.text = note.title;
    descriptionController.text = note.description;
    color = note.color;
    return WillPopScope(
        onWillPop: () async {
          isEdited ? showDiscardDialog(context) : moveToLastScreen();
          return false;
        },
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            title: Text(
                // appBarTitle,
                'New Notes',
                style: TextStyle(
                  color: Colors.white,
                )),
            backgroundColor: colors[color],
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.more_vert, color: Colors.white),
                onPressed: () {
                  showModalBottomSheet(
                    backgroundColor: colors[color],
                    elevation: 0,
                    builder: (BuildContext context) {
                      return Container(
                        color: colors[color],
                        height: 300,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                RaisedButton(
                                  onPressed: () {},
                                  child: Icon(
                                    Icons.share,
                                    size: 28,
                                  ),
                                  shape: CircleBorder(),
                                  color: Colors.grey,
                                  // Navigator.of(context).pop();
                                  // widget.callBackOptionTapped(moreOptions.share);
                                  // }),
                                ),
                                Text(
                                  'Share with your friends',
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Row(
                              children: [
                                RaisedButton(
                                  onPressed: () {
                                    setState(() {
                                      showDeleteDialog(context);
                                    });
                                  },
                                  child: Icon(
                                    Icons.delete,
                                    size: 28,
                                  ),
                                  shape: CircleBorder(),
                                  color: Colors.grey,
                                ),
                                Text(
                                  'Delete',
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Row(
                              children: [
                                RaisedButton(
                                  onPressed: () {
                                    setState(() {

                                    });
                                  },
                                  child: Icon(
                                    Icons.copy_outlined,
                                    size: 28,
                                  ),
                                  shape: CircleBorder(),
                                  color: Colors.grey,
                                ),
                                Text(
                                  'Duplicate',
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Row(
                              children: [
                                SingleChildScrollView(
                                    child: ColorPicker(
                                    selectedIndex: note.color,
                                    onTap: (index) {
                                      setState(() {
                                        color = index;
                                        // color=Colors[noteList[index].color];
                                      });
                                      isEdited = true;
                                      note.color = index;
                                    },
                                  ),
                                ),

                                // Text('Share with your friends',style: TextStyle(fontSize: 20,color: Colors.white),)
                              ],
                            )
                          ],
                        ),
                      );
                    },
                    context: context,
                  );
                },
              ),
              IconButton(
                splashRadius: 22,
                icon: const Icon(Icons.done, color: Colors.white),
                onPressed: () {
                  titleController.text.isEmpty
                      ? showEmptyTitleDialog(context)
                      : _save();
                },
              ),
            ],
          ),
          body: Container(
            // color: colors[color],
            color: bckgroud,
            child: Column(
              children: <Widget>[
                            SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    controller: titleController,
                    // maxLength: 255,
                    decoration: InputDecoration(
                        // border: InputBorder.none,
                        hintText: "   Type Something....",
                        hintStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: mycolor,
                          fontSize: 18,
                        )),
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    onChanged: (value) {
                      updateTitle();
                    },
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 16, bottom: 16, right: 16),
                    child: TextField(
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        // maxLength: 255,
                        controller: descriptionController,
                        onChanged: (value) {
                          updateDescription();
                        },
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Type Something....",
                            hintStyle: TextStyle(
                                // fontWeight: FontWeight.bold,
                                color: mycolor,
                                fontSize: 14))),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  void showDiscardDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: bckgroud,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(18.0))),
          title: Text(
            "Discard Changes?",
            style: TextStyle(
                fontSize: 20, color: Colors.black, fontWeight: FontWeight.w700),
          ),
          content: Text("Are you sure you want to discard changes?",
              style: TextStyle(fontSize: 16, color: Colors.black)),
          actions: <Widget>[
            TextButton(
              child: Text("No", style: TextStyle(color: Colors.purple)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("Yes", style: TextStyle(color: Colors.purple)),
              onPressed: () {
                Navigator.of(context).pop();
                moveToLastScreen();
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
          backgroundColor: p,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            side: BorderSide(color: Colors.red)


          ),
          title: Text(
            "Title is empty!",
            style: TextStyle(
                fontSize: 20, color: Colors.black, fontWeight: FontWeight.w700),
          ),
          content: Text(
            'The title of this note cannot be empty.',
            style: TextStyle(fontSize: 16, color: Colors.black),
          ),
          actions: <Widget>[
            TextButton(
              child: Text("Okay", style: TextStyle(color: Colors.purple)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor:  Colors.red,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))
              , side: BorderSide(color: Colors.red),

          ),
          title: Text(
            "Delete Note!!",
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.w700),
          ),
          content: Text("Are you sure you want to delete this note?",
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w700)),
          actions: <Widget>[
            TextButton(
              child: Text("No", style: TextStyle(color: Colors.purple)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("Yes",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2
                      .copyWith(color: Colors.purple)),
              onPressed: () {
                Navigator.of(context).pop();
                _delete();
              },
            ),
          ],
        );
      },
    );
  }

  void moveToLastScreen() {
    Navigator.pop(context, true);
  }

  void updateTitle() {
    isEdited = true;
    note.title = titleController.text;
  }

  void updateDescription() {
    isEdited = true;
    note.description = descriptionController.text;
  }

  // Save data to database
  void _save() async {
    moveToLastScreen();
    note.date = DateFormat.yMMMd().format(DateTime.now());
    if (note.id != null) {
      await helper.updateNote(note);
    } else {
      await helper.insertNote(note);
    }
  }

  void _delete() async {
    await helper.deleteNote(note.id);
    moveToLastScreen();
  }
  //this function duplicates a note with the selected id whenever
  //copy is tapped on from the bottom sheet

}
