import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:numberpicker/numberpicker.dart';

class NoteFormWidgetSell extends StatelessWidget {
  final int? applesSold;
  final String? oldApplesSold;
  final String? priceSold;
  final int? cashReceived;
  final String? oldCashReceived;
  final ValueChanged<String> oldOnChangedApplesSold;
  final ValueChanged<String> onChangedPriceSold;
  final ValueChanged<String> oldOnChangedCashReceived;

  const NoteFormWidgetSell({
    Key? key,
    this.applesSold = 0,
    this.oldApplesSold = '',
    this.priceSold = '',
    this.cashReceived = 0,
    this.oldCashReceived = '',
    required this.oldOnChangedApplesSold,
    required this.onChangedPriceSold,
    required this.oldOnChangedCashReceived,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              buildApplesSold(),
              buildPriceSold(),
              buildCashReceived(),
            ],
          ),
        ),
      );

  //Build Header.
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
                        color: Colors.white,
                        fontSize: 16)),
                child,
              ],
            ),
          ),
        ),
      );

  //Display cash received in sale
  Widget dispCashReceived() => Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.white12,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: EdgeInsets.all(4),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  'Cash Received so far: ',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  'R ' + cashReceived.toString(),
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      );

  Widget buildApplesSold() => buildHeader(
        header: 'Apples Sold ',
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Text(
                oldApplesSold.toString(),
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
            Expanded(
                flex: 6,
                //TODO:  Should be textFormField of type double.
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  maxLines: 1,
                  initialValue: oldApplesSold,
                  style: TextStyle(color: Colors.white60, fontSize: 18),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: '        (Apples sold)',
                    hintStyle: TextStyle(color: Colors.white24),
                  ),
                  validator: (value) => value != null && value.isEmpty
                      ? 'The Field cannot be empty'
                      : null,
                  onChanged: oldOnChangedApplesSold,
                )

                //  Slider(
                //   value: (oldApplesSold ?? 0).toDouble(),
                //   min: 0,
                //   max: 200,
                //   divisions: 50,
                //   onChanged: (oldChicksSold) =>
                //       oldOnChangedApplesSold(oldChicksSold.toInt()),
                // ),
                ),
          ],
        ),
      );

  // Build price

  Widget buildPriceSold() => Padding(
        padding: EdgeInsets.all(2),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.white12,
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
                        style: TextStyle(color: Colors.white),
                        text: 'Price per apple:',
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    
                    Expanded(
                      flex: 10,
                      //TODO:  Should be textFormField of type double.
                      child: TextFormField(
                        maxLines: 1,
                        initialValue: priceSold,
                        style: TextStyle(color: Colors.white60, fontSize: 18),
                        keyboardType:
                           TextInputType.numberWithOptions(decimal: true, signed: false),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'(^\d*\.?\d*)'))
                        ],
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: '        (Apple price)',
                          hintStyle: TextStyle(color: Colors.white24),
                        ),
                        validator: (value) => value != null && value.isEmpty
                            ? 'The Price cannot be empty'
                            : null,
                        onChanged: onChangedPriceSold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );

  Widget buildCashReceived() => Padding(
        padding: EdgeInsets.all(2),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.white12,
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
                        style: TextStyle(color: Colors.white),
                        text: 'Cash received for sale:',
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 10,
                      //TODO:  Should be textFormField of type double.
                      child: TextFormField(
                        maxLines: 1,
                        initialValue: oldCashReceived,
                        style: TextStyle(color: Colors.white60, fontSize: 18),
                        keyboardType: TextInputType.numberWithOptions(
                            decimal: true, signed: false),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp(r'(^\d*\.?\d*)'))
                        ],
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: '        (Cash received)',
                          hintStyle: TextStyle(color: Colors.white24),
                        ),
                        validator: (value) => value != null && value.isEmpty
                            ? 'The Cash cannot be empty'
                            : null,
                        onChanged: oldOnChangedCashReceived,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
}
