import 'package:flutter/material.dart';
import 'package:sqflite_database_example/db/notes_database.dart';
import 'package:sqflite_database_example/model/note.dart';
import 'package:sqflite_database_example/widget/note_form_widget_sell.dart';

class AddEditNotePageSell extends StatefulWidget {
  final Note? note;

  const AddEditNotePageSell({
    Key? key,
    this.note,
  }) : super(key: key);
  @override
  _AddEditNotePageSellState createState() => _AddEditNotePageSellState();
}

class _AddEditNotePageSellState extends State<AddEditNotePageSell> {

  final _formKey = GlobalKey<FormState>();
  late int editApplesSold;
  late int editOldApplesSold;
  late int editPriceSold;
  late int editCashReceived;
  late int editOldCashReceived;

  @override
  void initState() {
    super.initState();
    editApplesSold = widget.note?.applesSold ?? 0;
    editOldApplesSold = widget.note?.oldApplesSold ?? 0;
    editPriceSold= widget.note?.priceSold ?? 0;
    editCashReceived= widget.note?.cashReceived ?? 0;
    editOldCashReceived= widget.note?.oldCashReceived ?? 0;
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          actions: [buildButton()],
        ),
        body: Form(
          key: _formKey,
          child: NoteFormWidgetSell(
            applesSold:editApplesSold,
            oldApplesSold:editOldApplesSold,
            priceSold:editPriceSold,
            cashReceived:editCashReceived,
            oldCashReceived:editOldCashReceived,
            oldOnChangedApplesSold: (oldApplesSold) => setState(() => this.editOldApplesSold = oldApplesSold),
            onChangedPriceSold: (priceSold) => setState(() => this.editPriceSold = priceSold),
            oldOnChangedCashReceived: (oldCashReceived) => setState(() => this.editOldCashReceived = oldCashReceived),
          ),
        ),
      );

  Widget buildButton() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
        ),
        onPressed: addOrUpdateNote,
        child: Text('Save'),
      ),
    );
  }

  void addOrUpdateNote() async {
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      final isUpdating = widget.note != null;

      if (isUpdating) {
        await updateNote();
      }
      Navigator.of(context).pop();
    }
  }

  Future updateNote() async {
    final note = widget.note!.copy(
      copyApplesSold: editApplesSold+editOldApplesSold,
      copyPriceSold: editPriceSold,
      copyCashReceived: editCashReceived+editOldCashReceived,
    );
    await NotesDatabase.instance.update(note);
  }
}