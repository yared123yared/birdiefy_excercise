import 'package:app/utils/app_theme.dart';
import 'package:flutter/material.dart';

class DropDownButtonWidget extends StatefulWidget {
  final ValueChanged<String> valueChanged;
  final List<String>? list;
  final String label;
  const DropDownButtonWidget(
      {super.key,
      required this.list,
      required this.label,
      required this.valueChanged});

  @override
  State<DropDownButtonWidget> createState() => _DropDownButtonWidgetState();
}

class _DropDownButtonWidgetState extends State<DropDownButtonWidget> {
  late String dropdownValue;
  @override
  Widget build(BuildContext context) {
    dropdownValue = widget.list![0];
    return SizedBox(
      width: 340,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                widget.label,
                style: TextStyle(color: AppTheme.primaryColor),
              ),
            ),
            const SizedBox(
              height: 3,
            ),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    // borderSide: BorderSide(width: 3),
                  ),
                  border: InputBorder.none,
                  fillColor: Colors.grey.shade900,
                  filled: true),
              value: dropdownValue,
              icon: const Icon(
                Icons.arrow_drop_down,
                size: 35,
                color: AppTheme.primaryColor,
              ),
              dropdownColor: Colors.grey.shade900,
              style: const TextStyle(color: Colors.white),
              onChanged: (String? value) =>
                  widget.valueChanged(value.toString()),
              items:
                  widget.list!.map<DropdownMenuItem<String>>((dynamic value) {
                    
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    widget.label == 'Number of holes' ? '$value holes' : value,
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
