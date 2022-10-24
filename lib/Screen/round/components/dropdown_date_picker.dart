import 'package:app/utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DropDownDatePicker extends StatefulWidget {
  final String label;
  final ValueChanged<String> valueChanged;
  const DropDownDatePicker(
      {super.key, required this.label, required this.valueChanged});

  @override
  State<DropDownDatePicker> createState() => _DropDownDatePickerState();
}

class _DropDownDatePickerState extends State<DropDownDatePicker> {
  DateTime dateTime = DateTime.now();
  // String formattedDate = DateFormat('MM dd').format(dateTime);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 340,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                '${widget.label}',
                style: TextStyle(color: AppTheme.primaryColor),
              ),
            ),
            const SizedBox(
              height: 3,
            ),
            DropdownButtonFormField<DateTime>(
              items: ['Choose A Date']
                  .map((e) => DropdownMenuItem<DateTime>(
                      child: Text('${DateFormat('MMMd').format(dateTime)}')))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2001),
                          lastDate: DateTime(2099))
                      .then((date) {
                    setState(() {
                      dateTime = date!;
                      widget.valueChanged(DateFormat('MMMd').format(dateTime));
                    });
                  });
                });
              },

              // onChanged: (value) => Container(),
              decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    // borderSide: BorderSide(width: 3),
                  ),
                  border: InputBorder.none,
                  fillColor: Colors.grey.shade900,
                  filled: true),
              // value: dateTime,
              icon: const Icon(
                Icons.arrow_drop_down,
                size: 35,
                color: AppTheme.primaryColor,
              ),
              // elevation: 10,
              dropdownColor: Colors.grey.shade900,
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
