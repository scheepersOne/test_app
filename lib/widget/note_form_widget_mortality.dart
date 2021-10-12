import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:numberpicker/numberpicker.dart';

class NoteFormWidgetMortality extends StatelessWidget {

  final String? spoiled;
  final String? oldSpoiled;
  final int? fert;
  final int? oldFert;
  final int? fertPrice;
  final int? oldFertPrice;

  final ValueChanged<String> oldOnChangedSpoiled;
  final ValueChanged<int> oldOnChangedFert;
  final ValueChanged<int> oldOnChangedFertPrice;


  const NoteFormWidgetMortality({
    Key? key,
    this.spoiled = '',
    this.oldSpoiled = '',
    this.fert = 0,
    this.oldFert = 0,
    this.fertPrice = 0,
    this.oldFertPrice = 0,

    required this.oldOnChangedSpoiled,
    required this.oldOnChangedFert,
    required this.oldOnChangedFertPrice,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              dispCurSpoiled(),
              SizedBox(height: 4),
              dispCurFertKg(),
              SizedBox(height: 4),
              dispCurFertPrice(),
              SizedBox(height: 4),
              buildSpoiled(),
              buildFert(),
              buildFertPrice(),
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
              color: Colors.blueGrey,
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

  Widget dispCurSpoiled() => Container(
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
              'Total Spoiled : ',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              spoiled.toString()+' rotten',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ],
      ),
    ),
  );


  Widget dispCurFertKg() => Container(
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
              'Total kg of fertilizer  : ',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              fert.toString()+' kg',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ],
      ),
    ),
  );

  Widget dispCurFertPrice() => Container(
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
              'Total Rands of fertilizer bought : ',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text('R '+
              fertPrice.toString(),
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ],
      ),
    ),
  );

  //Build Spoiled.
  Widget buildSpoiled() => buildHeader(
        header: 'Add Spoiled today: ',
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Text(
                oldSpoiled.toString(),
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
            Expanded(
              flex: 6,
              child: TextFormField(
                maxLines: 1,
                initialValue: oldSpoiled,
                style: TextStyle(color: Colors.white60, fontSize: 18),
                keyboardType: TextInputType.numberWithOptions(decimal: true , signed: false),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'(^\d*\.?\d*)'))
                ],

                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: '        (spoiled)',
                  hintStyle: TextStyle(color: Colors.white24),
                ),
                validator: (value) => value != null && value.isEmpty
                    ? 'The spoiled field cannot be empty'
                    : null,
                onChanged: oldOnChangedSpoiled,
              ),
            ),
          ],
        ),
      );

  //Build fert.
  Widget buildFert() => buildHeader(
    header: 'Add fertilizer: ',
    child: Row(
      children: [
        Expanded(
          flex: 1,
          child: Text(
            oldFert.toString()+' kg',
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
        Expanded(
          flex: 6,
          child: Slider(
            value: (oldFert ?? 0).toDouble(),
            min: 0,
            max: 50,
            divisions: 50,
            onChanged: (oldChangeFeed) =>
                oldOnChangedFert(oldChangeFeed.toInt()),
          ),
        ),
      ],
    ),
  );

  //Build fert Price.
  Widget buildFertPrice() => Padding(
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
                    style: TextStyle(color: Colors.white, fontSize: 16),
                    text: 'Price paid for fertilizer:',
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
                    step: 50,
                    value: (oldFertPrice ?? 0),
                    minValue: 0,
                    maxValue: 40000,
                    onChanged: (oldFeedPrice) => oldOnChangedFertPrice(oldFeedPrice.toInt()),
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
