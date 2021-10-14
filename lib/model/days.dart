final String tableDays = 'days1';

class Days {
  final int? id;
  final int noteId;
  final DateTime dateTime;
  final double temp;

  const Days({
   this.id,
    required this.noteId,
    required this.dateTime,
    required this.temp
  });


    Days copy({
    int? copyId,
    int? copyNoteId,
    DateTime? copyDateTime,
    double? copyTemp,
  }) =>
      Days(
        id: copyId ?? this.id,
        noteId: copyNoteId ?? this.noteId,
        dateTime: copyDateTime ?? this.dateTime,
        temp: copyTemp ?? this.temp,
      );

  static Days fromJson(Map<String, Object?> json) => Days(
        id: json[DaysFields.idField] as int?,
        noteId: json[DaysFields.noteIdField] as int,
        dateTime: DateTime.parse(json[DaysFields.timeField] as String),
        temp: json[DaysFields.tempField] as double
      );

  Map<String, Object?> toJson() => {
        DaysFields.idField: id,
        DaysFields.noteIdField: noteId,
        DaysFields.timeField: dateTime.toIso8601String(),
        DaysFields.tempField: temp,

      };

  
}

class DaysFields {
  static final List<String> values = [
    /// Add all fields
    idField,
    noteIdField,
    timeField,
    tempField,
  ];

  static final String idField = '_id';
  static final String noteIdField = 'noteId';
  static final String timeField = 'time';
  static final String tempField = 'temp';

}



