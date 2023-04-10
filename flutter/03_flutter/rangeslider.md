# rangeslider

```dart
RangeValue _range;
RangeValue _rValue;
RangeSlider(
   values: _rValue,
   max: _range.end,
   min: _range.start,
   divisions: 1,
   onChanged: (value) {
     setState(() {
       _rValue = value;
     });
   },
 ),
```
