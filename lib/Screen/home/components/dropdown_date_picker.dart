import 'package:app/utils/app_theme.dart';
import 'package:flutter/material.dart';

class DropDownDatePicker extends StatefulWidget {
  final String label;
  const DropDownDatePicker({super.key, required this.label});

  @override
  State<DropDownDatePicker> createState() => _DropDownDatePickerState();
}

class _DropDownDatePickerState extends State<DropDownDatePicker> {
  DateTime dateTime = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 340,
      // decoration: BoxDecoration(
      //   borderRadius: BorderRadius.circular(20),
      // ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                "${widget.label}",
                style: TextStyle(color: AppTheme.primaryColor),
              ),
            ),
            const SizedBox(
              height: 3,
            ),
            DropdownButtonFormField<DateTime>(
              items: ['Choose A Date']
                  .map((e) => DropdownMenuItem<DateTime>(child: Text(e)))
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
