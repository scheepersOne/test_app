import 'package:flutter/material.dart';
import 'package:sqflite_database_example/db/notes_database.dart';
import 'package:sqflite_database_example/model/note.dart';
import 'package:sqflite_database_example/widget/note_form_widget_mortality.dart';

class AddEditNotePageMortality extends StatefulWidget {
  final Note? note;

  const AddEditNotePageMortality({
    Key? key,
    this.note,
  }) : super(key: key);
  @override
  _AddEditNotePageMortalityState createState() =>
      _AddEditNotePageMortalityState();
}

class _AddEditNotePageMortalityState extends State<AddEditNotePageMortality> {
  final _formKey = GlobalKey<FormState>();
  late String editSpoiled;
  late String oldEditSpoiled;
  late int editFert;
  late String editOldFert;
  late double editFertPrice;
  late String editOldFertPrice;

  @override
  void initState() {
    super.initState();
    editSpoiled = widget.note?.spoiled == null ? '' : '${widget.note?.spoiled}';
    oldEditSpoiled = '0';
    editFert = widget.note?.fert ?? 0;
    editOldFert = widget.note?.oldFertPrice == null
        ? '0.0'
        : '${widget.note?.oldFertPrice}';
    editFertPrice = widget.note?.fertPrice ?? 0;
    editOldFertPrice =
        widget.note?.oldFertPrice == null ? '0.0' : '${widget.note?.oldFertPrice}';
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          actions: [buildButton()],
        ),
        body: Form(
          key: _formKey,
          child: NoteFormWidgetMortality(
            spoiled: editSpoiled,
            oldSpoiled: oldEditSpoiled,
            fert: editFert,
            oldFert: editOldFert,
            fertPrice: editFertPrice,
            oldFertPrice: editOldFertPrice,
            oldOnChangedSpoiled: (oldSpoiled) =>
                setState(() => this.oldEditSpoiled = oldSpoiled),
            oldOnChangedFert: (oldFert) =>
                setState(() => this.editOldFert = oldFert),
            oldOnChangedFertPrice: (oldFertPrice) =>
                setState(() => this.editOldFertPrice = oldFertPrice),
          ),
        ),
      );

  Widget buildButton() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(),
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
        Navigator.of(context).pop();
      }
      //
    }
  }

  Future updateNote() async {
    final note = widget.note!.copy(
      copySpoiled: double.parse(editSpoiled) + double.parse(oldEditSpoiled),
      copyFert: editFert + int.parse(editOldFert),
      copyFertPrice: editFertPrice + double.parse(editOldFertPrice),
    );
    await NotesDatabase.instance.update(note);
  }
}
