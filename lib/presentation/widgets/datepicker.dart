import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MyDateTimePicker extends StatefulWidget {
  final void Function(DateTime? date) onDateChanged;
  final void Function(TimeOfDay? time) onTimeChanged;

  const MyDateTimePicker({
    super.key,
    required this.onDateChanged,
    required this.onTimeChanged,
  });

  @override
  State<MyDateTimePicker> createState() => _MyDateTimePickerState();
}

class _MyDateTimePickerState extends State<MyDateTimePicker> {
  String _selectedDate = 'Nov 12 2025';
  DateTime? _pickedDate;

  String _selectedTime = '12:00 AM';
  TimeOfDay? _pickedTime;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2050),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            dataTableTheme: DataTableThemeData(
              dataRowMaxHeight: 50,
              dataRowMinHeight: 10,
              columnSpacing: 5,
            ),
            colorScheme: ColorScheme.light(
              primary: const Color.fromARGB(255, 13, 6, 0),
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: const Color.fromARGB(255, 224, 142, 0),
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        _pickedDate = picked;
        _selectedDate = DateFormat('MMM, dd yyyy').format(picked);
      });

      widget.onDateChanged(picked);
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.blue,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        _pickedTime = picked;
        _selectedTime = _formatTimeOfDay(picked);
      });

      widget.onTimeChanged(picked);
    }
  }

  String _formatTimeOfDay(TimeOfDay tod) {
    final hour = tod.hourOfPeriod == 0 ? 12 : tod.hourOfPeriod;
    final minute = tod.minute.toString().padLeft(2, '0');
    final period = tod.period == DayPeriod.am ? 'AM' : 'PM';
    return '$hour:$minute $period';
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () => _selectDate(context),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[300]!),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.calendar_month_outlined,
                    size: 20,
                    color: Colors.grey[600],
                  ),
                  const SizedBox(width: 8),
                  Text(_selectedDate),
                ],
              ),
            ),
          ),
        ),

        const SizedBox(width: 10),

        Expanded(
          child: GestureDetector(
            onTap: () => _selectTime(context),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[300]!),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(Icons.access_time, size: 20, color: Colors.grey[600]),
                  const SizedBox(width: 8),
                  Text(_selectedTime),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
