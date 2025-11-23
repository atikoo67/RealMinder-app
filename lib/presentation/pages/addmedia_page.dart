import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:realminder/core/theme/theme.dart';
import 'package:realminder/logic/media/media_manager.dart';
import 'package:realminder/logic/media/media_service.dart';
import 'package:realminder/presentation/widgets/mybutton.dart';

class AddMediaPage extends StatefulWidget {
  const AddMediaPage({super.key});

  @override
  State<AddMediaPage> createState() => _AddMediaPageState();
}

class _AddMediaPageState extends State<AddMediaPage> {
  XFile? image;
  XFile? video;
  String? imagepath;
  String? videopath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        centerTitle: true,
        title: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Text(
            'Media Attachment',
            style: theme.textTheme.titleMedium!.copyWith(fontSize: 20),
          ),
        ),
      ),
      body: Column(
        children: [
          Divider(
            thickness: 0.385,
            color: const Color.fromARGB(220, 146, 146, 146),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 15,
                    children: [
                      if (image != null)
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 20),

                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: BoxBorder.all(
                              color: const Color.fromARGB(220, 146, 146, 146),
                              width: 0.4,
                            ),
                          ),
                          child: Column(
                            spacing: 15,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.file(
                                fit: BoxFit.fill,
                                File(image!.path),
                                height: 150,
                                width: MediaQuery.of(context).size.width,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 25,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Forest View',
                                      style: theme.textTheme.titleMedium!
                                          .copyWith(
                                            fontWeight: FontWeight.w800,
                                          ),
                                    ),
                                    Row(
                                      spacing: 15,
                                      children: [
                                        IconButton(
                                          icon: Icon(
                                            Icons.delete_outline_rounded,
                                          ),
                                          onPressed: () {},
                                        ),
                                        IconButton(
                                          icon: Icon(
                                            Icons.change_circle_outlined,
                                          ),
                                          onPressed: () {},
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      DottedBorder(
                        options: RoundedRectDottedBorderOptions(
                          padding: EdgeInsets.all(25),
                          color: const Color.fromARGB(255, 192, 192, 192),
                          strokeWidth: 2,
                          dashPattern: [6, 3],
                          radius: const Radius.circular(8),
                        ),
                        child: Column(
                          spacing: 25,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(FontAwesomeIcons.camera, size: 50),
                            Column(
                              children: [
                                Text(
                                  'Tap to add photo or video',
                                  style: theme.textTheme.titleMedium,
                                ),
                                Text(
                                  'or capture new media',
                                  style: theme.textTheme.titleSmall,
                                ),
                              ],
                            ),
                            MyButton(
                              color: Color.fromARGB(151, 215, 215, 215),
                              onTap: () async {
                                video = await MediaService.pickVideo();
                              },
                              padding: EdgeInsets.symmetric(
                                horizontal: 15,
                                vertical: 10,
                              ),
                              child: Text(
                                "Choose Video",
                                style: theme.textTheme.titleMedium!.copyWith(
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                            MyButton(
                              color: Color.fromARGB(151, 215, 215, 215),
                              onTap: () async {
                                image = await MediaService.pickImage();
                              },
                              padding: EdgeInsets.symmetric(
                                horizontal: 15,
                                vertical: 10,
                              ),
                              child: Text(
                                "Choose Image",
                                style: theme.textTheme.titleMedium!.copyWith(
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      MyButton(
                        color: theme.colorScheme.primary,
                        onTap: () async {
                          Navigator.pop(context, {
                            'imagepath': image ?? null,
                            'videopath': video ?? null,
                          });
                        },
                        child: Text(
                          "Continue",
                          style: theme.textTheme.titleMedium!.copyWith(
                            fontWeight: FontWeight.w800,
                            color: theme.colorScheme.secondary,
                          ),
                        ),
                      ),

                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Cancel',
                          style: theme.textTheme.titleMedium!.copyWith(
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
