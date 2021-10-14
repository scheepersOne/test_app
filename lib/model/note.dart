final String tableNotes = 'notes1';

class Note {
  //Note Form
  final int? id;
  final String title;
  final DateTime createdTime;
  final double temp;
  final int length;
  final int width;
  final double apples;
  final double applesPrice;
  final int fert;
  final int oldFert;
  final double fertPrice;
  final double oldFertPrice;

  //Mortality Form
  final double spoiled;
  final double oldSpoiled;

  //Sell Form
  final int applesSold;
  final int oldApplesSold;
  final double priceSold;
  final int cashReceived;
  final double oldCashReceived;

  const Note({
    this.id,
    required this.title,
    required this.createdTime,
    required this.length,
    required this.width,
    required this.temp,
    required this.apples,
    required this.spoiled,
    required this.applesPrice,
    required this.oldSpoiled,
    required this.fert,
    required this.oldFert,
    required this.fertPrice,
    required this.oldFertPrice,
    required this.applesSold,
    required this.oldApplesSold,
    required this.priceSold,
    required this.cashReceived,
    required this.oldCashReceived,
  });

  Note copy({
    int? copyId,
    String? copyTitle,
    DateTime? copyCreatedTime,
    int? copyLength,
    int? copyWidth,
    double? copyTemp,
    double? copyApples,
    double? copySpoiled,
    double? oldCopySpoiled,
    double? copyApplesPrice,
    int? copyFert,
    int? copyOldFert,
    double? copyFertPrice,
    double? copyOldFertPrice,
    int? copyApplesSold,
    int? copyOldApplesSold,
    double? copyPriceSold,
    int? copyCashReceived,
    double? copyOldCashReceived,
  }) =>
      Note(
        id: copyId ?? this.id,
        title: copyTitle ?? this.title,
        createdTime: copyCreatedTime ?? this.createdTime,
        length: copyLength ?? this.length,
        width: copyWidth ?? this.width,
        temp: copyTemp ?? this.temp,
        apples: copyApples ?? this.apples,
        spoiled: copySpoiled ?? this.spoiled,
        applesPrice: copyApplesPrice ?? this.applesPrice,
        oldSpoiled: oldCopySpoiled ?? this.oldSpoiled,
        fert: copyFert ?? this.fert,
        oldFert: copyOldFert ?? this.oldFert,
        fertPrice: copyFertPrice ?? this.fertPrice,
        oldFertPrice: copyOldFertPrice ?? this.oldFertPrice,
        applesSold: copyApplesSold ?? this.applesSold,
        oldApplesSold: copyOldApplesSold ?? this.oldApplesSold,
        priceSold: copyPriceSold ?? this.priceSold,
        cashReceived: copyCashReceived ?? this.cashReceived,
        oldCashReceived: copyOldCashReceived ?? this.oldCashReceived,
      );

  static Note fromJson(Map<String, Object?> json) => Note(
        id: json[NoteFields.idField] as int?,
        title: json[NoteFields.titleField] as String,
        createdTime: DateTime.parse(json[NoteFields.timeField] as String),
        length: json[NoteFields.lengthField] as int,
        width: json[NoteFields.widthField] as int,
        temp: json[NoteFields.tempField] as double,
        apples: json[NoteFields.applesField] as double,
        spoiled: json[NoteFields.spoiledField] as double,
        applesPrice: json[NoteFields.applePriceField] as double,
        oldSpoiled: json[NoteFields.oldSpoiledField] as double,
        fert: json[NoteFields.fertField] as int,
        oldFert: json[NoteFields.oldFertField] as int,
        fertPrice: json[NoteFields.fertPriceField] as double,
        oldFertPrice: json[NoteFields.oldFertPriceField] as double,
        applesSold: json[NoteFields.applesSoldField] as int,
        oldApplesSold: json[NoteFields.oldApplesSoldField] as int,
        priceSold: json[NoteFields.priceSoldField] as double,
        cashReceived: json[NoteFields.cashReceivedField] as int,
        oldCashReceived: json[NoteFields.oldCashReceivedField] as double,
      );

  Map<String, Object?> toJson() => {
        NoteFields.idField: id,
        NoteFields.titleField: title,
        NoteFields.timeField: createdTime.toIso8601String(),
        NoteFields.lengthField: length,
        NoteFields.widthField: width,
        NoteFields.tempField: temp,
        NoteFields.applesField: apples,
        NoteFields.spoiledField: spoiled,
        NoteFields.applePriceField: applesPrice,
        NoteFields.oldSpoiledField: oldSpoiled,
        NoteFields.fertField: fert,
        NoteFields.oldFertField: oldFert,
        NoteFields.fertPriceField: fertPrice,
        NoteFields.oldFertPriceField: oldFertPrice,
        NoteFields.applesSoldField: applesSold,
        NoteFields.oldApplesSoldField: oldApplesSold,
        NoteFields.priceSoldField: priceSold,
        NoteFields.cashReceivedField: cashReceived,
        NoteFields.oldCashReceivedField: oldCashReceived,
      };
}

class NoteFields {
  static final List<String> values = [
    /// Add all fields
    idField,
    titleField,
    timeField,
    lengthField,
    widthField,
    tempField,
    applesField,
    spoiledField,
    oldSpoiledField,
    fertField,
    oldFertField,
    fertPriceField,
    oldFertPriceField,
    applePriceField,
    applesSoldField,
    oldApplesSoldField,
    priceSoldField,
    cashReceivedField,
    oldCashReceivedField,
  ];

  

  static final String idField = '_id';
  static final String titleField = 'title';
  static final String timeField = 'time';
  static final String lengthField = 'length';
  static final String widthField = 'width';
  static final String tempField = 'temp';
  static final String applesField = 'apples';
  static final String spoiledField = 'spoiled';
  static final String applePriceField = 'applePrice';
  static final String oldSpoiledField = 'oldSpoiled';
  static final String fertField = 'fert';
  static final String oldFertField = 'oldFert';
  static final String fertPriceField = 'fertPrice';
  static final String oldFertPriceField = 'oldFertPrice';
  static final String applesSoldField = 'applesSold';
  static final String oldApplesSoldField = 'oldApplesSold';
  static final String priceSoldField = 'priceSold';
  static final String cashReceivedField = 'cashReceived';
  static final String oldCashReceivedField = 'oldCashReceived';
}


