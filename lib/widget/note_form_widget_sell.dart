import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

class NoteFormWidgetSell extends StatelessWidget {

  final int? applesSold;
  final int? oldApplesSold;
  final int? priceSold;
  final int? cashReceived;
  final int? oldCashReceived;
  final ValueChanged<int> oldOnChangedApplesSold;
  final ValueChanged<int> onChangedPriceSold;
  final ValueChanged<int> oldOnChangedCashReceived;

  const NoteFormWidgetSell({
    Key? key,
    this.applesSold = 0,
    this.oldApplesSold = 0,
    this.priceSold = 0,
    this.cashReceived = 0,
    this.oldCashReceived = 0,

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
                        fontWeight: FontWeight.bold, color: Colors.white, fontSize: 16)),
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
                child: Text('R '+
                  cashReceived.toString(),
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
          child: Slider(
            value: (oldApplesSold ?? 0).toDouble(),
            min: 0,
            max: 200,
            divisions: 50,
            onChanged: (oldChicksSold) =>
                oldOnChangedApplesSold(oldChicksSold.toInt()),
          ),
        ),
      ],
    ),
  );

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
                  child: NumberPicker(
                    textStyle: TextStyle(color: Colors.white),
                    axis: Axis.horizontal,
                    step: 1,
                    value: (priceSold ?? 0),
                    minValue: 0,
                    maxValue: 50,
                    onChanged: (priceSold) =>
                        onChangedPriceSold(priceSold.toInt()),
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
                  child: NumberPicker(
                    textStyle: TextStyle(color: Colors.white),
                    axis: Axis.horizontal,
                    step: 10,
                    value: (oldCashReceived ?? 0),
                    minValue: 0,
                    maxValue: 20000,
                    onChanged: (oldCashReceived) =>
                        oldOnChangedCashReceived(oldCashReceived.toInt()),
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
