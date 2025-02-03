import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import the intl package
import 'package:quality_pools/CommonComponants/my_utility.dart';
import 'package:quality_pools/CommonComponants/reusable_gradient_button.dart';
import 'package:quality_pools/MyPools/PoolNotes/notes_container.dart';
import 'package:quality_pools/MyPools/PoolNotes/post_note_popup.dart';
import 'package:quality_pools/Themes/quality_pool_textstyle.dart';
import 'package:quality_pools/main_page_layout.dart';

class PoolNotes extends StatefulWidget {
  const PoolNotes({
    super.key,
  });

  @override
  _PoolNotesState createState() => _PoolNotesState();
}

class _PoolNotesState extends State<PoolNotes> {
  String? selectedMonth;
  List<Map<String, dynamic>> notes =
      []; // Change the type of the list to hold dynamic data

  TextEditingController noteController = TextEditingController();

  bool isPhotoAdded = false; // Track if photo is added

  // Function to add a new note
  void addNote({Uint8List? imageData}) {
    if (noteController.text.isNotEmpty) {
      String formattedDate = DateFormat('d MMM yyyy').format(DateTime.now());
      String monthYear = DateFormat('MMMM yyyy').format(DateTime.now());

      setState(() {
        notes.add({
          'date': formattedDate,
          'monthYear': monthYear,
          'noteText': noteController.text,
          'imageData': imageData, // Store the imageData (Uint8List?)
        });
        noteController.clear();
      });
    }
  }

  // Function to show the note entry dialog
  void showNewNoteDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return PostNotePopup(
          noteController: noteController,
          onPostNote: (Uint8List? imageData) {
            addNote(imageData: imageData); // Pass imageData as a named argument
            Navigator.pop(context);
          },
          onCancel: () {
            Navigator.pop(context);
          },
          onImageAdded: (bool value) {
            setState(() {
              isPhotoAdded = value;
            });
          },
        );
      },
    );
  }

  // Function to filter notes by selected month
  List<Map<String, dynamic>> getFilteredNotes() {
    if (selectedMonth == null || selectedMonth!.isEmpty) {
      return notes;
    } else {
      return notes.where((note) {
        String noteMonth = note['monthYear']!;
        return noteMonth.startsWith(selectedMonth!);
      }).toList();
    }
  }

  // Function to delete a note
  void deleteNote(int index) {
    setState(() {
      notes.removeAt(index); // Remove the note at the given index
    });
  }

  void editNoteText(int index, String newText) {
    setState(() {
      notes[index]['noteText'] = newText; // Update the note text
    });
  }

  @override
  Widget build(BuildContext context) {
    return MainPageLayout(
      bodyContent: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                SizedBox(
                  width: 20,
                  child: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(Icons.arrow_back_ios),
                  ),
                ),
                Spacer(),
                Text(
                  'My Pool Notes',
                  style: QualityPoolTextstyle(context).pageTitle,
                ),
                Spacer(),
                SizedBox(width: 20)
              ],
            ),
            SizedBox(height: 20),

            // New Note button
            ReusableGradientButton(
              text: 'New Note',
              onTap: showNewNoteDialog, // Show the dialog when tapped
            ),
            SizedBox(height: 20),

            // Dropdown for month picker
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: MyUtility(context).width * 0.4,
                  height: MyUtility(context).height * 0.05,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.black,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: DropdownButton<String>(
                        value: selectedMonth,
                        hint: Text('Select Month'),
                        onChanged: (String? newMonth) {
                          setState(() {
                            selectedMonth = newMonth;
                          });
                        },
                        isExpanded: true,
                        items: <String>[
                          'January',
                          'February',
                          'March',
                          'April',
                          'May',
                          'June',
                          'July',
                          'August',
                          'September',
                          'October',
                          'November',
                          'December'
                        ].map<DropdownMenuItem<String>>((String month) {
                          return DropdownMenuItem<String>(
                            value: month,
                            child: Text(month),
                          );
                        }).toList(),
                        style: TextStyle(color: Colors.black),
                        icon: Icon(Icons.arrow_drop_down),
                        underline: Container(),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // Displaying the list of filtered notes
            SizedBox(height: 20),
            Column(
              children: getFilteredNotes().asMap().entries.map((entry) {
                int index = entry.key;
                Map<String, dynamic> note = entry.value;

                return NotesContainer(
                  date: note['date']!,
                  noteText: note['noteText']!,
                  isPhotoAdded:
                      note['imageData'] != null, // Check if there's image data
                  imageData: note['imageData'], // Pass Uint8List directly
                  onDelete: () => deleteNote(index),
                  onEdit: (newText) => editNoteText(index, newText),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
