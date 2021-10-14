import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:sqflite_database_example/db/notes_database.dart';
import 'package:sqflite_database_example/model/days.dart';
import 'package:sqflite_database_example/model/note.dart';
import 'package:sqflite_database_example/page/edit_note_page_mortality.dart';
import 'package:sqflite_database_example/page/note_detail_page.dart';
import 'edit_note_page_sell.dart';
import 'note_detail_page_sum.dart';

class NoteDetailPageTasks extends StatefulWidget {
  final int noteId;
  final Note sameNote;
  final List<Days> days;

  const NoteDetailPageTasks(
      {Key? key,
      required this.noteId,
      required this.sameNote,
      required this.days})
      : super(key: key);

  @override
  _NoteDetailPageTasksState createState() => _NoteDetailPageTasksState();
}

class _NoteDetailPageTasksState extends State<NoteDetailPageTasks> {
  late Note note;
  bool isLoading = false;

  final double rowPadding = 4.0;
  var rowBorderColor = Colors.white12;
  final DateTime now = DateTime.now();
  final tempController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  ScrollController? _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    refreshNote();
    // WidgetsBinding.instance?.addPostFrameCallback((_) {
    //   if (_scrollController!.hasClients) {
    //     print('working');
    //    _scrollController!.animateTo(
    //       _scrollController!.position.maxScrollExtent,
    //       curve: Curves.easeOut,
    //       duration: const Duration(milliseconds: 300),
    //     );
    //   }
    // });
  }

  Future refreshNote() async {
    setState(() => isLoading = true);
    this.note = await NotesDatabase.instance.readNote(widget.noteId);
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      if (_scrollController!.hasClients) {
        print('working');
        _scrollController!.jumpTo(_scrollController!.position.maxScrollExtent / 2);
      }
    });
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.sameNote.title +
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
          : RefreshIndicator(
              onRefresh: () async {
                await refreshNote();
              },
              child: Padding(
                padding: EdgeInsets.all(12),
                child: ListView(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  children: [
                    //TODO:  The tasks widgets(day 1 - day 42) Should be in a separate listView and be stored in a list,
                    //TODO: The list should only return widgets that is today's date, and the days after( The days that have passed, should not be displayed...)
                    //TODO:  If possible, I would like to add a or create a new data field that receives the temperature of each house separately each day... further explanations in call.
                    Text(
                      'Tasks : ',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    Form(
                      key: _formKey,
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.8,
                        child: ListView.separated(
                            controller: _scrollController,

                            // shrinkWrap: true,
                            reverse: false,
                            itemBuilder: (contxet, index) {
                              double temp = getTemp(index);
                              return InkWell(
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return alert(index);
                                      });
                                },
                                child: buildHeader(
                                    header:
                                        '${buildTasksList()[index].title} : ' +
                                            DateFormat.yMMMd().format(
                                                buildTasksList()[index]
                                                    .dateTime),
                                    color: buildTasksList()[index].color!,
                                    temp: temp,
                                    buttons: buildTasksList()[index]
                                        .isThereButtons!),
                              );

                              // if (buildTasksList()[index].dateTime ==
                              //         DateTime.now() ||
                              //     buildTasksList()[index]
                              //         .dateTime
                              //         .isAfter(DateTime.now())) {
                              //   return buildHeader(
                              //       header:
                              //           '${buildTasksList()[index].title} : ' +
                              //               DateFormat.yMMMd().format(
                              //                   buildTasksList()[index].dateTime),
                              //       child: buildTasksList()[index].child,
                              //       buttons:
                              //           buildTasksList()[index].isThereButtons!);
                              // }
                              // return SizedBox();
                            },
                            separatorBuilder: (context, index) => SizedBox(
                                  height: 8,
                                ),
                            itemCount: buildTasksList().length),
                      ),
                    )
                  ],
                ),
              ),
            ),
    );
  }

  double getTemp(index) {
    if (widget.days.isNotEmpty) {
      for (int i = 0; i < widget.days.length; i++) {
        if (buildTasksList()[index].dateTime == widget.days[i].dateTime &&
            widget.noteId == widget.days[i].noteId) {
          return widget.days[i].temp;
        }
      }
    }
    return 0.0;
  }

  AlertDialog alert(int index) {
    return AlertDialog(
      backgroundColor: Colors.blueGrey.shade900,
      content: TextFormField(
        maxLines: 1,
        style: TextStyle(color: Colors.white60, fontSize: 18),
        keyboardType:
            TextInputType.numberWithOptions(decimal: true, signed: false),
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'(^\d*\.?\d*)'))
        ],
        controller: tempController,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'Add temperature',
          hintStyle: TextStyle(color: Colors.white70, fontSize: 18),
        ),
        validator: (value) => value != null && value.isEmpty
            ? 'The spoiled field cannot be empty'
            : null,
      ),
      actions: [
        MaterialButton(
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              Days days = Days(
                  noteId: note.id!,
                  dateTime: buildTasksList()[index].dateTime,
                  temp: double.parse(tempController.text));

              await NotesDatabase.instance.insertDays(days).then((value) {
                Navigator.of(context).pop();
              });
            }
          },
          child: Text(
            'Add',
            style: TextStyle(color: Colors.white),
          ),
        ),
        MaterialButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            'Cancel',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }

  //BuildHeader.
  Widget buildHeader(
          {required String header,
          required Color color,
          required temp,
          required bool buttons}) =>
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
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(header,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blueAccent,
                            fontSize: 16)),
                    taskText(color, temp),
                  ],
                ),
                Spacer(),
                buttons
                    ? Expanded(
                        child: Column(
                          children: [
                            soldBtn(),
                            sumBtn(),
                          ],
                        ),
                      )
                    : SizedBox()
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

            await NotesDatabase.instance
                .readNote(widget.sameNote.id!)
                .then((value) {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => AddEditNotePageMortality(note: value),
              ));
            });

            //  refreshNote();
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
              builder: (context) => AddEditNotePageSell(note: widget.sameNote),
            ));

            //  refreshNote();
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
              builder: (context) => NoteDetailPageSum(
                noteId: widget.noteId,
                note: note,
              ),
            ));

            //  refreshNote();
          },
          child: Text('Summary'),
        ),
      );

  Widget taskText(Color color, double temp) {
    return Text(
      'Task1\n'
      '${temp == 0.0 ? '' : 'Temp today : $temp\n'}'
      'Task2',
      style: TextStyle(
        color: color,
        fontSize: 14,
      ),
    );
  }

  List<Tasks> buildTasksList() {
    return [
      Tasks(
        title: 'Day 1',
        dateTime: note.createdTime.add(const Duration(days: 0)),
      ),
      Tasks(
        title: 'Day 2',
        dateTime: note.createdTime.add(const Duration(days: 1)),
      ),
      Tasks(
        title: 'Day 3',
        dateTime: note.createdTime.add(const Duration(days: 2)),
      ),
      Tasks(
        title: 'Day 12',
        dateTime: note.createdTime.add(const Duration(days: 11)),
      ),
      Tasks(
        title: 'Day 13',
        dateTime: note.createdTime.add(const Duration(days: 12)),
      ),
      Tasks(
        title: 'Day 14',
        dateTime: note.createdTime.add(const Duration(days: 13)),
      ),
      Tasks(
        title: 'Day 15',
        dateTime: note.createdTime.add(const Duration(days: 14)),
      ),
      Tasks(
          title: 'Day 16',
          dateTime: note.createdTime.add(const Duration(days: 15)),
          color: Colors.red),
      Tasks(
          title: 'Day 17',
          dateTime: note.createdTime.add(const Duration(days: 16)),
          color: Colors.red),
      Tasks(
          title: 'Day 18',
          dateTime: note.createdTime.add(const Duration(days: 17)),
          color: Colors.red),
      Tasks(
          title: 'Day 19',
          dateTime: note.createdTime.add(const Duration(days: 18)),
          color: Colors.red),
      Tasks(
          title: 'Day 20',
          dateTime: note.createdTime.add(const Duration(days: 19)),
          color: Colors.red),
      Tasks(
          title: 'Day 21',
          dateTime: note.createdTime.add(const Duration(days: 20)),
          color: Colors.red),
      Tasks(
          title: 'Day 35',
          dateTime: note.createdTime.add(const Duration(days: 34)),
          color: Colors.red,
          isThereButtons: true),
      Tasks(
          title: 'Day 42',
          dateTime: note.createdTime.add(const Duration(days: 41)),
          color: Colors.red,
          isThereButtons: true),
    ];
  }
}

class Tasks {
  late final String title;
  late final DateTime dateTime;
  Color? color;
  bool? isThereButtons;

  Tasks(
      {required this.title,
      required this.dateTime,
      this.color = Colors.white,
      this.isThereButtons = false});
}
