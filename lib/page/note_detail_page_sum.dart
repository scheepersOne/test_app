import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sqflite_database_example/db/notes_database.dart';
import 'package:sqflite_database_example/model/note.dart';
class NoteDetailPageSum extends StatefulWidget {
  final int noteId;

  const NoteDetailPageSum({
    Key? key,
    required this.noteId,
  }) : super(key: key);

  @override
  _NoteDetailPageSumState createState() => _NoteDetailPageSumState();
}

class _NoteDetailPageSumState extends State<NoteDetailPageSum> {
  late Note note;
  bool isLoading = false;

  final double rowPadding = 4.0;
  var rowBorderColor = Colors.white12;
  final DateTime now = DateTime.now();

  //Variables to be displayed on view.
  get remainingApples => (note.apples-note.spoiled);

  get applesBought => note.apples*note.applesPrice;

  get fertBought => note.fertPrice;

  get moneyIn => note.cashReceived;

  get profit => note.cashReceived-(applesBought+fertBought);


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
            note.title + ',\nToday : ' + DateFormat.yMMMd().format(DateTime.now()),
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [],
        ),
        body: isLoading
            ? Center(child: CircularProgressIndicator())
            : Padding(
                padding: EdgeInsets.all(12),
                child: ListView(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  children: [
                    Text(
                      'Finances',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Money out :',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    buildApplesBought(),
                    buildFertBought(),
                    buildTotalCosts(),
                    SizedBox(height: 20),
                    Text(
                      'Money in :',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    buildMoneyIn(),
                    SizedBox(height: 20),
                    Text(
                      'Profit/Loss :',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    buildProfit(),

                  ],
                ),
              ),
      );

  Widget buildApplesBought() => buildHeader(
        header: 'Apples Bought Price : ',
        child: Text(
          'R '+applesBought.toString(),
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
          ),
        ),
      );

  Widget buildFertBought() => buildHeader(
    header: 'Fertilizer Bought Price : ' ,
    child: Text(
      'R '+fertBought.toString(),
      style: TextStyle(
        color: Colors.white,
        fontSize: 16,
      ),
    ),
  );

  //Total Costs.
  Widget buildTotalCosts() => buildHeader(
    header: 'TOTAL : ' ,
    child: Text(
      'R '+(applesBought+fertBought).toString(),
      style: TextStyle(
        color: Colors.white,
        fontSize: 16,
      ),
    ),
  );

  //Cash from apples.
  Widget buildMoneyIn() => buildHeader(
    header: 'Money from selling Apples : ' ,
    child: Text(
      'R '+moneyIn.toString(),
      style: TextStyle(
        color: Colors.white,
        fontSize: 16,
      ),
    ),
  );


  Widget buildProfit() => buildHeader(
    header: 'Money made/lost : ' ,
    child: Text(
      'R '+profit.toString(),
      style: TextStyle(
        color: Colors.white,
        fontSize: 16,
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
                        fontWeight: FontWeight.bold, color: Colors.blueAccent, fontSize: 16)),
                child,
              ],
            ),
          ),
        ),
      );
}
