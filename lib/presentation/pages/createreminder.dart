import 'package:flutter/material.dart';
import 'package:group_button/group_button.dart';
import 'package:intl/intl.dart';
import 'package:realminder/core/theme/theme.dart';
import 'package:realminder/presentation/widgets/customchip_group.dart';
import 'package:realminder/presentation/widgets/mytextfield.dart';

class CreateReminder extends StatefulWidget {
  const CreateReminder({super.key});

  @override
  State<CreateReminder> createState() => _CreateReminderState();
}

class _CreateReminderState extends State<CreateReminder> {
  final GroupButtonController _categoryController = GroupButtonController();
  String _selectedDate = 'Nov 12 2025';
  DateTime? _pickedDate;
  String _selectedTime = '12:00 AM';
  TimeOfDay? _pickedTime;
  TextEditingController? controller;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2028),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.blue, // header background color
              onPrimary: Colors.white, // header text color
              onSurface: Colors.black, // body text color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Colors.blue, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != _pickedDate) {
      setState(() {
        _pickedDate = picked;
        _selectedDate = DateFormat('MMM, dd yyyy').format(picked);
      });
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
    }
  }

  String _formatTimeOfDay(TimeOfDay tod) {
    final hour = tod.hourOfPeriod;
    final minute = tod.minute.toString().padLeft(2, '0');
    final period = tod.period == DayPeriod.am ? 'AM' : 'PM';
    return '$hour:${minute} $period';
  }

  @override
  Widget build(BuildContext context) {
    List<String> _tags = const ['Once', 'Daily', 'Weekly', 'Custom'];
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Create Reminder',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Icon(Icons.save, color: theme.textTheme.titleSmall!.color),
                ],
              ),
            ),
            Divider(thickness: 0.45),
            SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                spacing: 10,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 10,
                    children: [
                      Text('Title', style: theme.textTheme.titleMedium),
                      MyTextField(
                        label: 'Wake up early',
                        controller: controller,
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 10,
                    children: [
                      Text('Description', style: theme.textTheme.titleMedium),
                      TextFormField(
                        controller: controller,
                        maxLines: 5,
                        minLines: 3,
                        style: TextStyle(fontSize: 15),
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 0.4),
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 0.4),
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 0.4),
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 13,
                          ),
                          // filled: true,
                          // fillColor: theme.colorScheme.secondary,
                          hintText:
                              'Plan your morning routine, enjoy the sunrise.',
                        ),
                        onChanged: (value) {},
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 10,
                    children: [
                      Text(
                        'Date & Time',
                        style: theme.textTheme.titleMedium!.copyWith(
                          fontSize: 14,
                        ),
                      ),

                      Row(
                        spacing: 10,
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () => _selectDate(context),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 10,
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey[300]!),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.calendar_month_outlined,
                                      size: 20,
                                      color: Colors.grey[600],
                                    ),
                                    SizedBox(width: 8),
                                    Text(_selectedDate),
                                  ],
                                ),
                              ),
                            ),
                          ),

                          Expanded(
                            child: GestureDetector(
                              onTap: () => _selectTime(context),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 12,
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey[300]!),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.access_time,
                                      size: 20,
                                      color: Colors.grey[600],
                                    ),
                                    SizedBox(width: 8),
                                    Text(_selectedTime),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 10,
                    children: [
                      Text(
                        'Reccurence',
                        style: theme.textTheme.titleMedium!.copyWith(
                          fontSize: 14,
                        ),
                      ),
                      CustomChipsGroup(
                        items: _tags,
                        defaultSelected: [_tags.first],
                        multiSelect: false,
                        onSelectionChanged: (selectedItems) {},
                        chipBuilder: (label, isSelected, onTap) {
                          return CustomSelectableChip(
                            label: label,
                            isSelected: isSelected,
                            onSelected: (_) => onTap(),
                            selectedColor: theme.colorScheme.primary,
                            unselectedColor: const Color.fromARGB(
                              223,
                              236,
                              235,
                              235,
                            ),
                            selectedTextColor: theme.colorScheme.secondary,
                            unselectedTextColor:
                                theme.textTheme.titleMedium!.color,
                            borderRadius: 25,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 8,
                            ),
                            textStyle: theme.textTheme.titleMedium!.copyWith(
                              fontSize: 14,
                            ),
                            showCheckmark: false,
                          );
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),

                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: BoxBorder.all(
                        color: const Color.fromARGB(220, 0, 0, 0),
                        width: 0.4,
                      ),
                    ),
                    child: Row(
                      spacing: 10,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.add_photo_alternate_outlined),
                        Text(
                          "Add Media Attachment",
                          style: theme.textTheme.titleMedium!.copyWith(
                            color: theme.colorScheme.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
