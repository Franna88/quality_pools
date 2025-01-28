import 'package:flutter/material.dart';
import 'package:quality_pools/CommonComponants/common_button.dart';
import 'package:quality_pools/CommonComponants/my_utility.dart';
import 'package:quality_pools/Themes/quality_pool_textstyle.dart';
import 'package:quality_pools/Themes/quality_pools_colors.dart';

class PostNotePopup extends StatelessWidget {
  final TextEditingController noteController;
  final VoidCallback onPostNote;
  final VoidCallback onCancel;

  const PostNotePopup({
    Key? key,
    required this.noteController,
    required this.onPostNote,
    required this.onCancel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      title: Center(
        child: Text(
          'Enter New Note',
          style: QualityPoolTextstyle(context).pageTitle,
        ),
      ),
      content: Container(
        width: MyUtility(context).width, // Adjust width of the popup
        height: MyUtility(context).height * 0.3,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: noteController,
              decoration: InputDecoration(
                hintText: 'Enter your note here...',
                border: OutlineInputBorder(),
                contentPadding:
                    EdgeInsets.all(15), // Larger padding for the text field
              ),
              maxLines:
                  10, // Increase the number of lines to allow for more text input
            ),
          ],
        ),
      ),
      actions: [
        Row(
          children: [
            Container(
              width:
                  MyUtility(context).width * 0.3, // Increased width for button
              decoration: BoxDecoration(
                color: MyColors().red,
                borderRadius: BorderRadius.circular(18.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    spreadRadius: 0.5,
                    blurRadius: 1,
                    offset: const Offset(0, 4), // Bottom shadow
                  ),
                ],
              ),
              child: FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: Colors
                      .transparent, // Transparent to maintain container color
                  minimumSize: const Size(250, 50), // Larger button size
                ),
                onPressed: onCancel,
                child: Text(
                  'Cancel',
                  style: const TextStyle(
                    fontFamily: 'Judson',
                  ),
                ),
              ),
            ),
            Spacer(),
            Container(
              width:
                  MyUtility(context).width * 0.3, // Increased width for button
              decoration: BoxDecoration(
                color: MyColors().lightBlue,
                borderRadius: BorderRadius.circular(18.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    spreadRadius: 0.5,
                    blurRadius: 1,
                    offset: const Offset(0, 4), // Bottom shadow
                  ),
                ],
              ),
              child: FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: Colors
                      .transparent, // Transparent to maintain container color
                  minimumSize: const Size(250, 50), // Larger button size
                ),
                onPressed: onPostNote,
                child: Text(
                  'Post Note',
                  style: const TextStyle(
                    fontFamily: 'Judson',
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
