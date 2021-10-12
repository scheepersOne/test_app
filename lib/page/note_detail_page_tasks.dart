import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sqflite_database_example/db/notes_database.dart';
import 'package:sqflite_database_example/model/note.dart';
import 'package:sqflite_database_example/page/edit_note_page_mortality.dart';
import 'edit_note_page_sell.dart';
import 'note_detail_page_sum.dart';

class NoteDetailPageTasks extends StatefulWidget {
  final int noteId;

  const NoteDetailPageTasks({
    Key? key,
    required this.noteId,
  }) : super(key: key);

  @override
  _NoteDetailPageTasksState createState() => _NoteDetailPageTasksState();
}

class _NoteDetailPageTasksState extends State<NoteDetailPageTasks> {
  late Note note;
  bool isLoading = false;

  final double rowPadding = 4.0;
  var rowBorderColor = Colors.white12;
  final DateTime now = DateTime.now();

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
          actions: [captureBtn()],
        ),
        body: isLoading
            ? Center(child: CircularProgressIndicator())
            : Padding(
                padding: EdgeInsets.all(12),
                child: ListView(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  children: [
                    //TODO:  The tasks widgets(day 1 - day 42) Should be in a separate listView and be stored in a list,
                    //TODO: The list should only return widgets that is today's date, and the days after( The days that have passed, should not be displayed...)
                    //TODO:  If possible, I would like to add a or create a new data field that receives the temperature of each house separately each day... further explanations in call.
                    Text(
                      'Tasks :',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    buildDay1(),
                    SizedBox(height: 8),
                    buildDay2(),
                    SizedBox(height: 8),
                    buildDay3(),
                    SizedBox(height: 8),
                    buildDay12(),
                    SizedBox(height: 8),
                    buildDay13(),
                    SizedBox(height: 8),
                    buildDay14(),
                    SizedBox(height: 8),
                    buildDay15(),
                    SizedBox(height: 8),
                    buildDay16(),
                    SizedBox(height: 8),
                    buildDay17(),
                    SizedBox(height: 8),
                    buildDay18(),
                    SizedBox(height: 8),
                    buildDay19(),
                    SizedBox(height: 8),
                    buildDay20(),
                    SizedBox(height: 8),
                    buildDay21(),
                    SizedBox(height: 8),
                    buildDay26(),
                    SizedBox(height: 8),
                    buildDay28(),
                    SizedBox(height: 8),
                    buildDay35(),
                    SizedBox(height: 8),
                    buildDay42(),
                  ],
                ),
              ),
      );

  //Day 1.
  Widget buildDay1() => buildHeader(
        header: 'Day 1 : ' +
            DateFormat.yMMMd()
                .format(note.createdTime.add(const Duration(days: 0))),
        child: Text(
          'Task1\n'
          'Task2',
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
          ),
        ),
      );

  //Day 2.
  Widget buildDay2() => buildHeader(
        header: 'Day 2 : ' +
            DateFormat.yMMMd()
                .format(note.createdTime.add(const Duration(days: 1))),
        child: Text(
          'Task1\n'
              'Task2',
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
          ),
        ),
      );

  //Day 3.
  Widget buildDay3() => buildHeader(
        header: 'Day 3 : ' +
            DateFormat.yMMMd()
                .format(note.createdTime.add(const Duration(days: 2))),
        child: Text(
          'Task1\n'
              'Task2',
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
          ),
        ),
      );

  //Day 12.
  Widget buildDay12() => buildHeader(
        header: 'Day 12 : ' +
            DateFormat.yMMMd()
                .format(note.createdTime.add(const Duration(days: 11))),
        child: Text(
          'Task1\n'
              'Task2',
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
          ),
        ),
      );

  //Day 13.
  Widget buildDay13() => buildHeader(
        header: 'Day 13 : ' +
            DateFormat.yMMMd()
                .format(note.createdTime.add(const Duration(days: 12))),
        child: Text(
          'Task1\n'
              'Task2',
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
          ),
        ),
      );

  //Day 14.
  Widget buildDay14() => buildHeader(
        header: 'Day 14 : ' +
            DateFormat.yMMMd()
                .format(note.createdTime.add(const Duration(days: 13))),
        child: Text(
          'Task1\n'
              'Task2',
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
          ),
        ),
      );

  //Day 15.
  Widget buildDay15() => buildHeader(
        header: 'Day 15 : ' +
            DateFormat.yMMMd()
                .format(note.createdTime.add(const Duration(days: 14))),
        child: Text(
          'Task1\n'
              'Task2',
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
          ),
        ),
      );

  //Day 16.
  Widget buildDay16() => buildHeader(
        header: 'Day 16 : ' +
            DateFormat.yMMMd()
                .format(note.createdTime.add(const Duration(days: 15))),
        child: Text(
          'Task1\n'
              'Task2',
          style: TextStyle(
            color: Colors.red,
            fontSize: 14,
          ),
        ),
      );

  //Day 17.
  Widget buildDay17() => buildHeader(
        header: 'Day 17 : ' +
            DateFormat.yMMMd()
                .format(note.createdTime.add(const Duration(days: 16))),
        child: Text(
          'Task1\n'
              'Task2',
          style: TextStyle(
            color: Colors.red,
            fontSize: 14,
          ),
        ),
      );

  //Day 18.
  Widget buildDay18() => buildHeader(
        header: 'Day 18 : ' +
            DateFormat.yMMMd()
                .format(note.createdTime.add(const Duration(days: 17))),
        child: Text(
          'Task1\n'
              'Task2',
          style: TextStyle(
            color: Colors.red,
            fontSize: 14,
          ),
        ),
      );

  //Day 19.
  Widget buildDay19() => buildHeader(
        header: 'Day 19 : ' +
            DateFormat.yMMMd()
                .format(note.createdTime.add(const Duration(days: 18))),
        child: Text(
          'Task1\n'
              'Task2',
          style: TextStyle(
            color: Colors.red,
            fontSize: 14,
          ),
        ),
      );

  //Day 20.
  Widget buildDay20() => buildHeader(
        header: 'Day 20 : ' +
            DateFormat.yMMMd()
                .format(note.createdTime.add(const Duration(days: 19))),
        child: Text(
          'Task1\n'
              'Task2',
          style: TextStyle(
            color: Colors.red,
            fontSize: 14,
          ),
        ),
      );

  //Day 21.
  Widget buildDay21() => buildHeader(
        header: 'Day 21 : ' +
            DateFormat.yMMMd()
                .format(note.createdTime.add(const Duration(days: 20))),
        child: Text(
          'Task1\n'
              'Task2',
          style: TextStyle(
            color: Colors.red,
            fontSize: 14,
          ),
        ),
      );

  //Day 26.
  Widget buildDay26() => buildHeader(
        header: 'Day 26 : ' +
            DateFormat.yMMMd()
                .format(note.createdTime.add(const Duration(days: 25))),
        child: Text(
          'Task1\n'
              'Task2',
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
          ),
        ),
      );

  //Day 28.
  Widget buildDay28() => buildHeader(
        header: 'Day 28 : ' +
            DateFormat.yMMMd()
                .format(note.createdTime.add(const Duration(days: 27))),
        child: Text(
          'Task1\n'
              'Task2',
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
          ),
        ),
      );

  Widget buildDay35() => Padding(
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
            padding: const EdgeInsets.only(left: 8.0, right: 1),
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          'Day 35 : ' +
                              DateFormat.yMMMd().format(note.createdTime
                                  .add(const Duration(days: 34))),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blueAccent,
                              fontSize: 16)),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Task1\n'
                            'Task2',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      soldBtn(),
                      sumBtn(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  Widget buildDay42() => Padding(
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
            padding: const EdgeInsets.only(left: 8.0, right: 1),
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          'Day 42 : ' +
                              DateFormat.yMMMd().format(note.createdTime
                                  .add(const Duration(days: 41))),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blueAccent,
                              fontSize: 16)),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Task1\n'
                            'Task2',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      soldBtn(),
                      sumBtn(),
                    ],
                  ),
                ),
              ],
            ),
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
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent,
                        fontSize: 16)),
                child,
              ],
            ),
          ),
        ),
      );

  //BUTTONS.
  Widget captureBtn() => Padding(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 6),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.all(12),
            onPrimary: Colors.white,
          ),
          onPressed: () async {
            if (isLoading) return;

            await Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => AddEditNotePageMortality(note: note),
            ));

            refreshNote();
          },
          child: Text('Spoiled'),
        ),
      );

  //Apples Sold Btn
  Widget soldBtn() => Padding(
        padding: EdgeInsets.symmetric(vertical: 0, horizontal: 1),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.all(1),
            onPrimary: Colors.white,
          ),
          onPressed: () async {
            if (isLoading) return;

            await Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => AddEditNotePageSell(note: note),
            ));

            refreshNote();
          },
          child: Text('Sell Apples'),
        ),
      );

  //Summary Button.
  Widget sumBtn() => Padding(
        padding: EdgeInsets.symmetric(vertical: 0, horizontal: 1),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.all(4),
            onPrimary: Colors.white,
          ),
          onPressed: () async {
            if (isLoading) return;

            await Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => NoteDetailPageSum(noteId: note.id!),
            ));

            refreshNote();
          },
          child: Text('Summary'),
        ),
      );
}
