import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sqflite_database_example/db/notes_database.dart';
import 'package:sqflite_database_example/model/note.dart';
import 'package:sqflite_database_example/page/edit_note_page.dart';
import 'package:sqflite_database_example/page/edit_note_page_mortality.dart';
import 'package:sqflite_database_example/page/note_detail_page_tasks.dart';
import 'package:url_launcher/url_launcher.dart';

//TODO:  Apples remaining cannot be less than total Apples.
class NoteDetailPage extends StatefulWidget {
  final int noteId;

  const NoteDetailPage({
    Key? key,
    required this.noteId,
  }) : super(key: key);

  @override
  _NoteDetailPageState createState() => _NoteDetailPageState();
}

class _NoteDetailPageState extends State<NoteDetailPage> {
  late Note note;
  bool isLoading = false;

  final double rowPadding = 4.0;
  var rowBorderColor = Colors.white12;
  final DateTime now = DateTime.now();

  //Variables to be displayed on view.
  get boxesNeeded => (note.apples * 0.2).round();
  get waterNeeded => (note.apples * 0.1).ceil();
  get squareMeter => (note.length * note.width).round();
  get remainingApples => (note.apples - note.spoiled - note.applesSold);

  @override
  void initState() {
    super.initState();

    refreshNote();
  }

  Future refreshNote() async {
    setState(() => isLoading = true);

    this.note = await NotesDatabase.instance.readNote(widget.noteId);

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(
            note.title +
                ',\nToday : ' +
                DateFormat.yMMMd().format(DateTime.now()),
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [tasksBtn()],
        ),
        body: isLoading
            ? Center(child: CircularProgressIndicator())
            : Padding(
                padding: EdgeInsets.all(12),
                child: ListView(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  children: [
                    Text(
                      'Date House was Added: \t ' +
                          DateFormat.yMMMd().format(note.createdTime),
                      style: TextStyle(color: Colors.white38),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'How to Setup:',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    dispBoxes(),
                    SizedBox(height: 8),
                    dispWater(),
                    SizedBox(height: 20),
                    Text(
                      'House details:',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    dispSquareMeter(),
                    SizedBox(height: 8),
                    dispSpoiled(),
                    SizedBox(height: 8),
                    dispApplesSold(),
                    SizedBox(height: 8),
                    dispRemainingApples(),
                    SizedBox(height: 20),
                  ],
                ),
              ),
      );

  //BuildHeader.
  Widget buildHeader({
    required String header,
    required Widget child,
  }) =>
      Padding(
        padding: const EdgeInsets.all(2.0),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.white12,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          padding: EdgeInsets.symmetric(vertical: 2),
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(header,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.blueAccent)),
                child,
              ],
            ),
          ),
        ),
      );

  Widget dispBoxes() => Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: rowBorderColor,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: EdgeInsets.all(rowPadding),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  'Boxes Needed: ',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  boxesNeeded.toString(),
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      );

  Widget dispWater() => Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: rowBorderColor,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: EdgeInsets.all(rowPadding),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  'Water Needed: ',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  waterNeeded.toString(),
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      );

  Widget dispSquareMeter() => Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: rowBorderColor,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: EdgeInsets.all(rowPadding),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  'House Size: ',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  squareMeter.toString() + ' m^2',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      );

  //Display Spoiled
  Widget dispSpoiled() => Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: rowBorderColor,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: EdgeInsets.all(rowPadding),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  'Rotten apples in house: ',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  note.spoiled.toString() + ' rotten',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      );

  //Display Apples Sold.
  Widget dispApplesSold() => Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: rowBorderColor,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: EdgeInsets.all(rowPadding),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  'Apples Sold so far: ',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  note.applesSold.toString() + ' sold',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      );

  //Display Remaining Apples.
  Widget dispRemainingApples() => Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: rowBorderColor,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: EdgeInsets.all(rowPadding),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  'Apples Remaining: ',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  remainingApples.toString() + ' remaining',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      );

  //BUTTONS.
  //Mortality Button.
  Widget tasksBtn() => Padding(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.all(12),
            onPrimary: Colors.white,
          ),
          onPressed: () async {
            if (isLoading) return;

            await Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => NoteDetailPageTasks(noteId: note.id!),
            ));

            refreshNote();
          },
          child: Text('Tasks'),
        ),
      );
}
