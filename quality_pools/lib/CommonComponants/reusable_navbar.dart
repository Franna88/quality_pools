import 'package:flutter/material.dart';
import 'package:quality_pools/CommonComponants/reusable_textfields.dart';


class ReusableNavbar extends StatefulWidget {
   final String optionText;
 

 const ReusableNavbar({
  Key? key,
  required this.optionText,
 }):super(key: key);



  @override
  _ReusableNavbarState createState() => _ReusableNavbarState();
}

class _ReusableNavbarState extends State<ReusableNavbar> {
  String? selectedOption; // Holds the current selection

  final List<String> menuOptions = ['Home', 'My Pools', 'Settings', 'Logout'];

  @override
  Widget build(BuildContext context) {

    return DropdownButton<String>(
      value: selectedOption, // Current selected value
      hint: Text('Menu', style: TextStyle(color: const Color.fromARGB(255, 18, 13, 13))), // Default text
      dropdownColor: Colors.blue, // Dropdown background color
      icon: Icon(Icons.arrow_drop_down, color: const Color.fromARGB(255, 21, 20, 20)), // Dropdown icon
      underline: SizedBox(), // Removes the default underline
      items: menuOptions.map((String option) {
        return DropdownMenuItem<String>(
          value: option,
          child: Text(option),
        );
      }).toList(),
      onChanged: (String? newValue) {
        setState(() {
          selectedOption = newValue;
        });
        if (newValue != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Selected: $newValue')),
          );
          // Navigate to a new screen based on the selection
          // Example: Navigator.pushNamed(context, '/${newValue.toLowerCase()}');
        }
      },
    );
  }
}