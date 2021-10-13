import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqflite_database_example/db/notes_database.dart';
import 'package:sqflite_database_example/model/note.dart';
import 'package:sqflite_database_example/widget/note_form_widget.dart';

class AddEditNotePage extends StatefulWidget {
  final Note? note;

  const AddEditNotePage({
    Key? key,
    this.note,
  }) : super(key: key);
  @override
  _AddEditNotePageState createState() => _AddEditNotePageState();
}

class _AddEditNotePageState extends State<AddEditNotePage> {

  final _formKey = GlobalKey<FormState>();
  late int editLength;
  late int editWidth;
  late int editTemp;
  late String editApples;
  late String editSpoiled;
  late String oldEditSpoiled;
  late String editApplesPrice;
  late int editFert;
  late int editOldFert;
  late int editFertPrice;
  late int editOldFertPrice;
  late int editApplesSold;
  late int editOldApplesSold;
  late int editPriceSold;
  late int editCashReceived;
  late int editOldCashReceived;
  late String editTitle;

  @override
  void initState() {
    super.initState();
    editLength = widget.note?.length ?? 0;
    editWidth = widget.note?.width ?? 0;
    editTemp = widget.note?.temp ?? 0;
    editApples = widget.note?.apples ==null ? '': '${widget.note?.apples}';
    editSpoiled = widget.note?.spoiled ==null ? '0': '${widget.note?.spoiled}';
    oldEditSpoiled = widget.note?.oldSpoiled ==null ? '0': '${widget.note?.oldSpoiled}';
    editApplesPrice = widget.note?.applesPrice ==null ? '': '${widget.note?.applesPrice}';
    editFert = widget.note?.fert ?? 0;
    editOldFert = widget.note?.oldFert ?? 0;
    editFertPrice = widget.note?.fertPrice ?? 0;
    editOldFertPrice = widget.note?.oldFertPrice ?? 0;
    editApplesSold = widget.note?.applesSold ?? 0;
    editOldApplesSold = widget.note?.oldApplesSold ?? 0;
    editPriceSold= widget.note?.priceSold ?? 0;
    editCashReceived= widget.note?.cashReceived ?? 0;
    editOldCashReceived= widget.note?.oldCashReceived ?? 0;
    editTitle = widget.note?.title ?? '';
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          actions: [buildButton()],
        ),
        body: Form(
          key: _formKey,
          child: NoteFormWidget(
            length:editLength,
            width:editWidth,
            temp:editTemp,
            apples:editApples,
            spoiled:editSpoiled,
            applesPrice:editApplesPrice,
            oldSpoiled:oldEditSpoiled,
            fert:editFert,
            oldFert:editOldFert,
            fertPrice:editFertPrice,
            oldFertPrice:editOldFertPrice,
            applesSold:editApplesSold,
            oldApplesSold:editOldApplesSold,
            priceSold:editPriceSold,
            cashReceived:editCashReceived,
            oldCashReceived:editOldCashReceived,
            title: editTitle,
            onChangedLength: (length) => setState(() => this.editLength = length),
            onChangedWidth: (width) => setState(() => this.editWidth = width),
            onChangedTemp: (temp) => setState(() => this.editTemp = temp),
            onChangedApples: (apples) => setState(() => this.editApples = apples),
            onChangedSpoiled: (spoiled) => setState(() => this.editSpoiled = spoiled),
            onChangedApplesPrice: (applesPrice) => setState(() => this.editApplesPrice = applesPrice),
            oldOnChangedSpoiled: (oldSpoiled) => setState(() => this.oldEditSpoiled = oldSpoiled),
            onChangedFert: (fert) => setState(() => this.editFert = fert),
            oldOnChangedFert: (oldFert) => setState(() => this.editOldFert = oldFert),
            onChangedFertPrice: (fertPrice) => setState(() => this.editFertPrice = fertPrice),
            oldOnChangedFertPrice: (oldFertPrice) => setState(() => this.editOldFertPrice = oldFertPrice),
            onChangedApplesSold: (applesSold) => setState(() => this.editApplesSold = applesSold),
            oldOnChangedApplesSold: (oldApplesSold) => setState(() => this.editOldApplesSold = oldApplesSold),
            onChangedPriceSold: (priceSold) => setState(() => this.editPriceSold = priceSold),
            onChangedCashReceived: (cashReceived) => setState(() => this.editCashReceived = cashReceived),
            oldOnChangedCashReceived: (oldCashReceived) => setState(() => this.editOldCashReceived = oldCashReceived),
            onChangedTitle: (title) => setState(() => this.editTitle = title),
          ),
        ),
      );

  Widget buildButton() {
    final isFormValid = editTitle.isNotEmpty;

    // 
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          onPrimary: Colors.white,
          primary: isFormValid ? null : Colors.grey.shade700,
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
      } else {
        await addNote();
      }

      Navigator.of(context).pop();
    }
  }


  Future updateNote() async {
    final note = widget.note!.copy(

    );

    await NotesDatabase.instance.update(note);
  }
  Future addNote() async {
    final note = Note(
      length: editLength,
      width: editWidth,
      temp: editTemp,
      apples: double.parse(editApples),
      spoiled: double.parse(editSpoiled),
      oldSpoiled: double.parse(oldEditSpoiled),
      applesPrice: double.parse(editApplesPrice),
      fert: editFert,
      oldFert: editOldFert,
      fertPrice: editFertPrice,
      oldFertPrice: editOldFertPrice,
      applesSold: editApplesSold,
      oldApplesSold: editOldApplesSold,
      priceSold: editPriceSold,
      cashReceived: editCashReceived,
      oldCashReceived: editOldCashReceived,
      title: editTitle,
      createdTime: DateTime.now(),
    );

    await NotesDatabase.instance.create(note);
  }
}









