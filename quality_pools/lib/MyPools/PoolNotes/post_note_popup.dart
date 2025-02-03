import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quality_pools/CommonComponants/common_button.dart';
import 'package:quality_pools/CommonComponants/my_utility.dart';
import 'package:quality_pools/Themes/quality_pool_textstyle.dart';
import 'package:quality_pools/Themes/quality_pools_colors.dart';

class PostNotePopup extends StatefulWidget {
  final TextEditingController noteController;
  final ValueChanged<Uint8List?> onPostNote;

  final VoidCallback onCancel;
  final ValueChanged<bool> onImageAdded;

  const PostNotePopup({
    Key? key,
    required this.noteController,
    required this.onPostNote,
    required this.onCancel,
    required this.onImageAdded,
  }) : super(key: key);

  @override
  _PostNotePopupState createState() => _PostNotePopupState();
}

class _PostNotePopupState extends State<PostNotePopup> {
  bool isPhotoAdded = false;
  Uint8List? _imageData;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final imageBytes = await pickedFile.readAsBytes();
      setState(() {
        _imageData = imageBytes;
        isPhotoAdded = true;
      });
      widget.onImageAdded(true);
    }
  }

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
        width: MyUtility(context).width,
        child: SingleChildScrollView(
          // Use SingleChildScrollView for flexible height
          child: Column(
            children: [
              if (isPhotoAdded && _imageData != null)
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: MyColors().lightBlue, width: 2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.memory(
                      _imageData!,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              Stack(
                children: [
                  TextField(
                    controller: widget.noteController,
                    decoration: const InputDecoration(
                      hintText: 'Enter your note here...',
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 10,
                  ),
                  Positioned(
                    top: 5,
                    right: 10,
                    child: IconButton(
                      onPressed: _pickImage,
                      icon: Icon(
                        Icons.camera_alt,
                        color: MyColors().lightBlue,
                        size: 30,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(top: 50.0),
          child: Row(
            children: [
              _buildActionButton('Cancel', MyColors().red, widget.onCancel),
              const Spacer(),
              _buildActionButton('Post Note', MyColors().lightBlue, () {
                widget.onPostNote(_imageData);
              }),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton(String text, Color color, VoidCallback onPressed) {
    return SizedBox(
      width: MyUtility(context).width * 0.3,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
          ),
          padding: const EdgeInsets.symmetric(vertical: 14),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: const TextStyle(
            fontFamily: 'Judson',
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
