import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:group_button/group_button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:realminder/core/constants/lists.dart';
import 'package:realminder/core/theme/theme.dart';
import 'package:realminder/data/models/model.dart';
import 'package:realminder/logic/media/media_manager.dart';
import 'package:realminder/presentation/pages/addmedia_page.dart';
import 'package:realminder/presentation/providers/notifier.dart';
import 'package:realminder/presentation/widgets/customchip_group.dart';
import 'package:realminder/presentation/widgets/datepicker.dart';
import 'package:realminder/presentation/widgets/mybutton.dart';
import 'package:realminder/presentation/widgets/mytextfield.dart';

class CreateReminder extends ConsumerStatefulWidget {
  const CreateReminder({super.key});
  @override
  ConsumerState<CreateReminder> createState() => _CreateReminderState();
}

class _CreateReminderState extends ConsumerState<CreateReminder> {
  final GroupButtonController _categoryController = GroupButtonController();
  TextEditingController descriptioncontroller = TextEditingController();
  TextEditingController titlecontroller = TextEditingController();
  DateTime? dateTime;
  TimeOfDay? time;
  RepeatInterval? repeatInterval;
  ReminderType? reminderType;
  int? priority;
  NotificationStatus? notificationStatus;
  String? imagePath;
  String? selectedDay;
  Map<String, XFile?> mediapath = {};

  String? videoPath;

  List<String>? customDays;

  @override
  Widget build(BuildContext context) {
    List<RepeatInterval> intervalrepeatenum = const [
      RepeatInterval.once,
      RepeatInterval.daily,
      RepeatInterval.weekly,
      RepeatInterval.monthly,
    ];

    final labelsenum = [
      ReminderType.work,
      ReminderType.personal,
      ReminderType.health,
      ReminderType.education,
    ];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(66, 255, 216, 157),
        centerTitle: true,
        title: Text(
          'Create Reminder',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
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
                      controller: titlecontroller,
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 10,
                  children: [
                    Text('Description', style: theme.textTheme.titleMedium),
                    TextFormField(
                      controller: descriptioncontroller,
                      maxLines: 5,
                      minLines: 3,
                      style: TextStyle(fontSize: 15),
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 0.4,
                            color: const Color.fromARGB(186, 154, 154, 154),
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 0.4,
                            color: const Color.fromARGB(186, 154, 154, 154),
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 0.4,
                            color: const Color.fromARGB(186, 154, 154, 154),
                          ),
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
                        hintStyle: TextStyle(
                          color: const Color.fromARGB(185, 96, 96, 96),
                        ),
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
                    MyDateTimePicker(
                      onDateChanged: (DateTime? date) {
                        setState(() {
                          dateTime = date;
                        });
                      },
                      onTimeChanged: (TimeOfDay? time) {
                        time = time;
                      },
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 10,
                  children: [
                    Text(
                      'Reminder Type',
                      style: theme.textTheme.titleMedium!.copyWith(
                        fontSize: 14,
                      ),
                    ),
                    CustomChipsGroup(
                      items: ConstantLists.remindertypes,
                      defaultSelected: [ConstantLists.remindertypes.first],
                      multiSelect: false,
                      onSelectionChanged: (selectedItems) {
                        setState(() {
                          reminderType =
                              labelsenum[ConstantLists.remindertypes.indexOf(
                                selectedItems.first,
                              )];
                        });
                      },
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
                      items: ConstantLists.repeatInterval,
                      defaultSelected: [ConstantLists.repeatInterval.first],
                      multiSelect: false,
                      onSelectionChanged: (selectedItems) {
                        setState(() {
                          repeatInterval =
                              intervalrepeatenum[ConstantLists.repeatInterval
                                  .indexOf(selectedItems.first)];
                        });
                      },
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
                if (repeatInterval == RepeatInterval.weekly)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 10,
                    children: [
                      CustomChipsGroup(
                        items: ConstantLists.days,
                        defaultSelected: [ConstantLists.days.first],
                        multiSelect: false,
                        onSelectionChanged: (selectedItems) {
                          selectedDay = selectedItems[0];
                        },
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
                GestureDetector(
                  onTap: () async {
                    mediapath = await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AddMediaPage()),
                    );
                  },
                  child: Container(
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
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: MyButton(
              color: theme.colorScheme.primary,
              onTap: () async {
                final video = mediapath['video'];
                final image = mediapath['image'];
                if (video != null) {
                  videoPath = await MediaManager.selectAndSaveVideo(video);
                }
                if (image != null) {
                  imagePath = await MediaManager.selectAndSaveImage(video);
                }
                final reminder = ReminderModel(
                  title: titlecontroller.text,
                  description: descriptioncontroller.text,
                  dateTime: dateTime,
                  repeatInterval: repeatInterval ?? RepeatInterval.once,
                  reminderType: reminderType ?? ReminderType.personal,
                  priority: 2,
                  notificationStatus: NotificationStatus.pending,
                  imagePath: imagePath,
                  customDays: [selectedDay!],
                  videoPath: videoPath,
                  timeofday: time ?? TimeOfDay.now(),
                );
                ref.read(reminderProvider.notifier).add(reminder);
                print('done');
              },
              child: Text(
                "Continue",
                style: theme.textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeight.w800,
                  color: theme.colorScheme.secondary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
