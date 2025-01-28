import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import the intl package
import 'package:quality_pools/CommonComponants/my_utility.dart';
import 'package:quality_pools/CommonComponants/reusable_gradient_button.dart';
import 'package:quality_pools/MyPools/notes_container.dart';
import 'package:quality_pools/MyPools/post_note_popup.dart';
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
  List<Map<String, String>> notes = [];
  TextEditingController noteController = TextEditingController();

  // Function to add a new note
  void addNote() {
    if (noteController.text.isNotEmpty) {
      // Get current date and format it
      String formattedDate = DateFormat('d MMM yyyy').format(DateTime.now());
      String monthYear = DateFormat('MMMM yyyy')
          .format(DateTime.now()); // Extract month and year

      setState(() {
        notes.add({
          'date': formattedDate, // Use the formatted current date
          'monthYear': monthYear, // Store month and year for filtering
          'noteText': noteController.text,
        });
        noteController.clear(); // Clear the text field after adding the note
      });
    }
  }

  // Function to show the note entry dialog
  void showNewNoteDialog() {
    showDialog(
      context: context,
      barrierDismissible: false, // Prevent closing by tapping outside
      builder: (BuildContext context) {
        return PostNotePopup(
          noteController: noteController,
          onPostNote: () {
            addNote(); // Post the note
            Navigator.pop(context); // Close the dialog
          },
          onCancel: () {
            Navigator.pop(context); // Close the dialog without adding a note
          },
        );
      },
    );
  }

  // Function to filter notes by selected month
  List<Map<String, String>> getFilteredNotes() {
    if (selectedMonth == null || selectedMonth!.isEmpty) {
      return notes; // If no month is selected, return all notes
    } else {
      return notes.where((note) {
        String noteMonth = note['monthYear']!;
        return noteMonth.startsWith(selectedMonth!); // Filter by selected month
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
            ...getFilteredNotes()
                .asMap()
                .map((index, note) {
                  return MapEntry(
                    index,
                    NotesContainer(
                      date: note['date']!,
                      noteText: note['noteText']!,
                      onDelete: () => deleteNote(index),
                      onEdit: (newText) =>
                          editNoteText(index, newText), // Pass edit function
                    ),
                  );
                })
                .values
                .toList(),
          ],
        ),
      ),
    );
  }
}
