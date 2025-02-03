import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:quality_pools/CommonComponants/my_utility.dart';
import 'package:quality_pools/Themes/quality_pool_textstyle.dart';
import 'package:quality_pools/Themes/quality_pools_colors.dart';

class NotesContainer extends StatefulWidget {
  final String date;
  final String noteText;
  final VoidCallback onDelete;
  final ValueChanged<String> onEdit;
  final bool isPhotoAdded;
  final Uint8List? imageData; // New parameter to hold the image data

  NotesContainer({
    required this.date,
    required this.noteText,
    required this.onDelete,
    required this.onEdit,
    required this.isPhotoAdded,
    this.imageData, // Accept image data
  });

  @override
  _NotesContainerState createState() => _NotesContainerState();
}

class _NotesContainerState extends State<NotesContainer> {
  bool isEditing = false;
  late TextEditingController editController;

  @override
  void initState() {
    super.initState();
    editController = TextEditingController(text: widget.noteText);
  }

  @override
  void dispose() {
    editController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Container(
        width: MyUtility(context).width - 20,
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0XFF1A8CF0), Color(0XFF095BB2)],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade400,
                              blurRadius: 1,
                              offset: Offset(0, 4),
                            ),
                          ],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding:
                            EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
                        child: Text(
                          widget.date,
                          style: QualityPoolTextstyle(context).whiteStyleBody,
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            width: MyUtility(context).width * 0.1,
                            height: MyUtility(context).width * 0.1,
                            child: IconButton(
                              icon: Icon(
                                isEditing
                                    ? Icons.check
                                    : Icons.mode_edit_outline_outlined,
                                color: MyColors().lightBlue,
                              ),
                              onPressed: () {
                                if (isEditing) {
                                  widget.onEdit(editController.text);
                                }
                                setState(() {
                                  isEditing = !isEditing;
                                });
                              },
                            ),
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade400,
                                  blurRadius: 1,
                                  offset: Offset(0, 4),
                                ),
                              ],
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          SizedBox(width: 10),
                          Container(
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade400,
                                  blurRadius: 1,
                                  offset: Offset(0, 4),
                                ),
                              ],
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            width: MyUtility(context).width * 0.1,
                            height: MyUtility(context).width * 0.1,
                            child: IconButton(
                              icon: const Icon(
                                Icons.delete_outline_outlined,
                                color: Colors.red,
                              ),
                              onPressed: widget.onDelete,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 8.0),
                  isEditing
                      ? TextField(
                          controller: editController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Edit your note...',
                          ),
                          maxLines: null,
                          style: QualityPoolTextstyle(context).blackbodyText,
                        )
                      : Text(
                          widget.noteText,
                          style: QualityPoolTextstyle(context).blackbodyText,
                        ),
                ],
              ),
            ),
            if (widget.isPhotoAdded && widget.imageData != null)
              Column(
                children: [
                  SizedBox(height: 10),
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                    child: Image.memory(
                      widget.imageData!,
                      height: MyUtility(context).height * 0.3,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
