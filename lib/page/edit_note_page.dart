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
  bool isCustomDate = false;

  DateTime? pickedDate;

  final _formKey = GlobalKey<FormState>();
  late String editLength;
  late String editWidth;
  late String editTemp;
  late String editApples;
  late String editSpoiled;
  late String oldEditSpoiled;
  late String editApplesPrice;
  late String editFertPrice;
  late String editPriceSold;
  late String editFert;
  late String editOldFert;

  late String editOldFertPrice;
  late int editApplesSold;
  late int editOldApplesSold;

  late int editCashReceived;
  late String editOldCashReceived;
  late String editTitle;

  @override
  void initState() {
    super.initState();
    editLength = widget.note?.length == null ? '0' : '${widget.note?.length}';
    editWidth = widget.note?.width == null ? '0' : '${widget.note?.width}';
    editTemp = widget.note?.temp == null ? '0.0' : '${widget.note?.temp}';
    editApples = widget.note?.apples == null ? '' : '${widget.note?.apples}';
    editSpoiled =
        widget.note?.spoiled == null ? '0' : '${widget.note?.spoiled}';
    oldEditSpoiled =
        widget.note?.oldSpoiled == null ? '0' : '${widget.note?.oldSpoiled}';
    editApplesPrice =
        widget.note?.applesPrice == null ? '' : '${widget.note?.applesPrice}';
    editFert = widget.note?.fert == null ?  '0' : '${widget.note?.fert}';
    editOldFert =
        widget.note?.oldFert == null ? '0' : '${widget.note?.oldFert}';
    editFertPrice =
        widget.note?.fertPrice == null ? '' : '${widget.note?.fertPrice}';
    editOldFertPrice = widget.note?.oldFertPrice == null
        ? '0.0'
        : '${widget.note?.oldFertPrice}';
    editApplesSold = widget.note?.applesSold ?? 0;
    editOldApplesSold = widget.note?.oldApplesSold ?? 0;
    editPriceSold =
        widget.note?.priceSold == null ? '0.0' : '${widget.note?.priceSold}';
    editCashReceived = widget.note?.cashReceived ?? 0;
    editOldCashReceived = widget.note?.oldCashReceived == null
        ? '0.0'
        : '${widget.note?.oldCashReceived}';
    editTitle = widget.note?.title ?? '';
  }

  Future<void> showDate() async {
    this.pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2020),
        lastDate: DateTime(2025));
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          actions: [buildButton()],
        ),
        body: Form(
          key: _formKey,
          child: NoteFormWidget(
            length: editLength,
            width: editWidth,
            temp: editTemp,
            apples: editApples,
            spoiled: editSpoiled,
            applesPrice: editApplesPrice,
            oldSpoiled: oldEditSpoiled,
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
            customDate: isCustomDate,
            onChangedCustomDate: (value) async {
              if (isCustomDate = true) {
                await showDate();
              }
              setState(() {
                this.isCustomDate = value;
                print(value);
              });
            },
            onChangedLength: (length) =>
                setState(() => this.editLength = length),
            onChangedWidth: (width) => setState(() => this.editWidth = width),
            onChangedTemp: (temp) => setState(() => this.editTemp = temp),
            onChangedApples: (apples) =>
                setState(() => this.editApples = apples),
            onChangedSpoiled: (spoiled) =>
                setState(() => this.editSpoiled = spoiled),
            onChangedApplesPrice: (applesPrice) =>
                setState(() => this.editApplesPrice = applesPrice),
            oldOnChangedSpoiled: (oldSpoiled) =>
                setState(() => this.oldEditSpoiled = oldSpoiled),
            onChangedFert: (fert) => setState(() => this.editFert = fert),
            oldOnChangedFert: (oldFert) =>
                setState(() => this.editOldFert = oldFert),
            onChangedFertPrice: (fertPrice) =>
                setState(() => this.editFertPrice = fertPrice),
            oldOnChangedFertPrice: (oldFertPrice) =>
                setState(() => this.editOldFertPrice = oldFertPrice),
            onChangedApplesSold: (applesSold) =>
                setState(() => this.editApplesSold = applesSold),
            oldOnChangedApplesSold: (oldApplesSold) =>
                setState(() => this.editOldApplesSold = oldApplesSold),
            onChangedPriceSold: (priceSold) =>
                setState(() => this.editPriceSold = priceSold),
            onChangedCashReceived: (cashReceived) =>
                setState(() => this.editCashReceived = cashReceived),
            oldOnChangedCashReceived: (oldCashReceived) =>
                setState(() => this.editOldCashReceived = oldCashReceived),
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
    final note = widget.note!.copy();

    await NotesDatabase.instance.update(note);
  }

  Future addNote() async {
    final note = Note(
      length: int.parse(editLength),
      width: int.parse(editWidth),
      temp: double.parse(editTemp),
      apples: double.parse(editApples),
      spoiled: double.parse(editSpoiled),
      oldSpoiled: double.parse(oldEditSpoiled),
      applesPrice: double.parse(editApplesPrice),
      fert: int.parse(editFert),
      oldFert: int.parse(editOldFert),
      fertPrice: double.parse(editFertPrice),
      oldFertPrice: double.parse(editOldFertPrice),
      applesSold: editApplesSold,
      oldApplesSold: editOldApplesSold,
      priceSold: double.parse(editPriceSold),
      cashReceived: editCashReceived,
      oldCashReceived: double.parse(editOldCashReceived),
      title: editTitle,
      createdTime: pickedDate != null && isCustomDate == true
          ? pickedDate!
          : DateTime.now(),
    );

    await NotesDatabase.instance.create(note);
  }
}
