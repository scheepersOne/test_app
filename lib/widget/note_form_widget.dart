import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:numberpicker/numberpicker.dart';

class NoteFormWidget extends StatelessWidget {
  final String? length;
  final String? width;
  final String? temp;
  final String? apples;
  final String? spoiled;
  final String? oldSpoiled;
  final String? applesPrice;
  final String? fertPrice;
  final String? priceSold;
  final String? fert;
  final String? oldFert;

  final String? oldFertPrice;
  final int? applesSold;
  final int? oldApplesSold;

  final int? cashReceived;
  final String? oldCashReceived;
  final String? title;
  final bool? customDate;

  final ValueChanged<String> onChangedLength;
  final ValueChanged<String> onChangedWidth;
  final ValueChanged<String> onChangedTemp;
  final ValueChanged<String> onChangedApples;
  final ValueChanged<String> onChangedSpoiled;
  final ValueChanged<String> oldOnChangedSpoiled;
  final ValueChanged<String> onChangedApplesPrice;
  final ValueChanged<String> onChangedFertPrice;
  final ValueChanged<String> onChangedFert;
  final ValueChanged<String> oldOnChangedFert;

  final ValueChanged<String> oldOnChangedFertPrice;
  final ValueChanged<int> onChangedApplesSold;
  final ValueChanged<int> oldOnChangedApplesSold;
  final ValueChanged<String> onChangedPriceSold;
  final ValueChanged<int> onChangedCashReceived;
  final ValueChanged<String> oldOnChangedCashReceived;
  final ValueChanged<String> onChangedTitle;
  final ValueChanged<bool> onChangedCustomDate;

  const NoteFormWidget({
    Key? key,
    this.length = '',
    this.width = '',
    this.temp = '',
    this.apples = '',
    this.spoiled = '',
    this.oldSpoiled = '',
    this.applesPrice = '',
    this.fert = '',
    this.oldFert = '',
    this.fertPrice = '',
    this.oldFertPrice = '',
    this.applesSold = 0,
    this.oldApplesSold = 0,
    this.priceSold = '',
    this.cashReceived = 0,
    this.oldCashReceived = '',
    this.title = '',
    this.customDate = false,
    required this.onChangedLength,
    required this.onChangedWidth,
    required this.onChangedTemp,
    required this.onChangedApples,
    required this.onChangedSpoiled,
    required this.onChangedApplesPrice,
    required this.oldOnChangedSpoiled,
    required this.onChangedFert,
    required this.oldOnChangedFert,
    required this.onChangedFertPrice,
    required this.oldOnChangedFertPrice,
    required this.onChangedApplesSold,
    required this.oldOnChangedApplesSold,
    required this.onChangedPriceSold,
    required this.onChangedCashReceived,
    required this.oldOnChangedCashReceived,
    required this.onChangedTitle,
    required this.onChangedCustomDate,
  }) : super(key: key);

  int? get userLength => length!.isNotEmpty ?  int.parse(length!) : 0;

  int? get userWidth => width!.isNotEmpty ?  int.parse(width!) : 0;

  int? get applesGet => ((userLength! * userWidth!) * 10);

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 8, right: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              buildTitle(),
              buildDate(context),
              buildLength(),
              buildWidth(),
              buildApples(),
              buildApplesPrice(),
              buildFert(),
              buildFertPrice(),
              buildTemp(),
            ],
          ),
        ),
      );

  //Build Header.
  Widget buildHeader({
    required String? header,
    required Widget child,
  }) =>
      Padding(
        padding: const EdgeInsets.all(2.0),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.blueGrey,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          padding: EdgeInsets.symmetric(vertical: 2),
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8, top: 2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  header!,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 16),
                ),
                child,
              ],
            ),
          ),
        ),
      );

  //Build Title.
  Widget buildTitle() => TextFormField(
        maxLines: 1,
        initialValue: title,
        style: TextStyle(
          color: Colors.white70,
          fontWeight: FontWeight.bold,
          fontSize: 22,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'House Name...',
          hintStyle: TextStyle(color: Colors.white24),
        ),
        validator: (title) =>
            title != null && title.isEmpty ? 'The title cannot be empty' : null,
        onChanged: onChangedTitle,
      );

  //TODO: NB !!!!!! Add a check box which allows user to enter date manually.
  //TODO:  If Checkbox is checked, the user should be able to add date time manually. Comments to follow.
  /*
  * The checkbox should be under the title widget and above the length widget.
  * it should look something like this: [x] 'Enter date time manually?' .
  * When user checks the box, widget containing date time picker should become visible, and
  * the user should be able to pick the date and time.
  * If the box is not checked, the dateTime.now() should be used instead.
  * the date time.now() is currently being assigned to all house entries.
  * */

// Build Date

  Widget buildDate(context) {
    return buildHeader(
        header: 'Date',
        child: Container(
          child: Theme(
            data: Theme.of(context).copyWith(
              unselectedWidgetColor: Colors.white,
            ),
            child: CheckboxListTile(
                title: Text(
                  'Enter date time manually?',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                controlAffinity: ListTileControlAffinity.leading,
                value: customDate,
                onChanged: (value) => onChangedCustomDate(value!)),
          ),
        ));
  }

  //Build Length Box.
  Widget buildLength() => buildHeader(
        header: 'House Length: ',
        child: TextFormField(
          maxLines: 1,
          initialValue: length,
          style: TextStyle(color: Colors.white60, fontSize: 18),
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: '        (Length)',
            hintStyle: TextStyle(color: Colors.white24),
          ),
          validator: (value) => value != null && value.isEmpty
              ? 'The Length cannot be empty'
              : null,
          onChanged: onChangedLength,
        ),
      );

  //Build Width.
  Widget buildWidth() => buildHeader(
        header: 'House Width: ',
        child: TextFormField(
          maxLines: 1,
          initialValue: width,
          style: TextStyle(color: Colors.white60, fontSize: 18),
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: '        (Width)',
            hintStyle: TextStyle(color: Colors.white24),
          ),
          validator: (value) => value != null && value.isEmpty
              ? 'The Width cannot be empty'
              : null,
          onChanged: onChangedWidth,
        ),
      );

  //Build Apples.
  Widget buildApples() => Padding(
        padding: EdgeInsets.all(2),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.blueGrey,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          padding: EdgeInsets.symmetric(vertical: 2),
          child: Padding(
            padding: const EdgeInsets.only(left: 8, right: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                          style: TextStyle(color: Colors.white, fontSize: 16),
                          text: 'Enter Number of Apples: \n'
                                  'We Recommend: ' +
                              applesGet.toString()),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 10,
                      child: TextFormField(
                        maxLines: 1,
                        initialValue: apples,
                        style: TextStyle(color: Colors.white60, fontSize: 18),
                        keyboardType: TextInputType.numberWithOptions(
                            decimal: true, signed: false),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp(r'(^\d*\.?\d*)'))
                        ],
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: '        (number of apples)',
                          hintStyle: TextStyle(color: Colors.white24),
                        ),
                        validator: (value) => value != null && value.isEmpty
                            ? 'The amount of apples cannot be empty'
                            : null,
                        onChanged: onChangedApples,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );

  //Build Apples Price.
  Widget buildApplesPrice() => buildHeader(
        header: 'Price paid for Apples: ',
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Text(
                ' R',
                style: TextStyle(color: Colors.white),
              ),
            ),
            Expanded(
              flex: 9,
              child: TextFormField(
                maxLines: 1,
                initialValue: applesPrice,
                style: TextStyle(color: Colors.white60, fontSize: 18),
                keyboardType: TextInputType.numberWithOptions(
                    decimal: true, signed: false),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'(^\d*\.?\d*)'))
                ],
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: '(Apples price)',
                  hintStyle: TextStyle(color: Colors.white24),
                ),
                validator: (value) => value != null && value.isEmpty
                    ? 'The Apples cannot be empty'
                    : null,
                onChanged: onChangedApplesPrice,
              ),
            ),
          ],
        ),
      );

  //Build Temp.
  Widget buildTemp() => buildHeader(
        header: 'House Temperature: ',
        child: TextFormField(
          maxLines: 1,
          initialValue: temp,
          style: TextStyle(color: Colors.white60, fontSize: 18),
          keyboardType:
              TextInputType.numberWithOptions(decimal: true, signed: false),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'(^\d*\.?\d*)'))
          ],
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: '        (number of apples)',
            hintStyle: TextStyle(color: Colors.white24),
          ),
          validator: (value) => value != null && value.isEmpty
              ? 'The temp cannot be empty'
              : null,
          onChanged: onChangedTemp,
        ),
      );

  Widget buildFert() => buildHeader(
        header: 'Fertilizer Bought (kg): ',
        child: TextFormField(
          maxLines: 1,
          initialValue: fert,
          style: TextStyle(color: Colors.white60, fontSize: 18),
          keyboardType:
              TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly
          ],
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: '        (Fert)',
            hintStyle: TextStyle(color: Colors.white24),
          ),
          validator: (value) => value != null && value.isEmpty
              ? 'The Fert cannot be empty'
              : null,
          onChanged: onChangedFert,
        ),
      );

  //TODO:  Fertilizer Price should also be input from the user through textFormField of type double, but it gets used again on note_form_widget_mortality.  so it needs to update.

  Widget buildFertPrice() {
    return buildHeader(
        header: 'Price paid for fertilizer:',
        child: TextFormField(
          maxLines: 1,
          initialValue: fertPrice,
          style: TextStyle(color: Colors.white60, fontSize: 18),
          keyboardType:
              TextInputType.numberWithOptions(decimal: true, signed: false),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'(^\d*\.?\d*)'))
          ],
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: '        (Fert price)',
            hintStyle: TextStyle(color: Colors.white24),
          ),
          validator: (value) => value != null && value.isEmpty
              ? 'The Price cannot be empty'
              : null,
          onChanged: onChangedFertPrice,
        ));
  }
  // Widget buildFertPrice() => Padding(
  //       padding: EdgeInsets.all(2),
  //       child: Container(
  //         decoration: BoxDecoration(
  //           border: Border.all(
  //             color: Colors.white12,
  //           ),
  //           borderRadius: BorderRadius.circular(8),
  //         ),
  //         padding: EdgeInsets.symmetric(vertical: 2),
  //         child: Padding(
  //           padding: const EdgeInsets.only(left: 8, right: 8),
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               RichText(
  //                 text: TextSpan(
  //                   children: [
  //                     TextSpan(
  //                       style: TextStyle(color: Colors.white),
  //                       text: 'Price paid for fertilizer:',
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //               Row(
  //                 children: [
  //                   Expanded(
  //                     flex: 10,
  //                     child: NumberPicker(
  //                       textStyle: TextStyle(color: Colors.white),
  //                       axis: Axis.horizontal,
  //                       step: 50,
  //                       value: (fertPrice ?? 0),
  //                       minValue: 0,
  //                       maxValue: 40000,
  //                       onChanged: (feedPrice) =>
  //                           onChangedFertPrice(feedPrice.toInt()),
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ],
  //           ),
  //         ),
  //       ),
  //     );
}
