import 'package:flutter/material.dart';

class ReusableContainers extends StatelessWidget {
  final String titleText;
  final int number;
  final String ppm;

  const ReusableContainers({
    Key? key,
    required this.titleText,
    required this.number,
    required this.ppm,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center, 
        crossAxisAlignment: CrossAxisAlignment.center, 
        children: [
          Container(
            width: 100, 
            height: 100,
            decoration: BoxDecoration(
              color: Colors.blue, 
              borderRadius: BorderRadius.circular(10), 
              boxShadow: [
                BoxShadow(
                  color: Colors.black26, 
                  blurRadius: 4.0, 
                  offset: Offset(2, 2), 
                ),
              ],
            ),
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                titleText,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Text(
                '$number PPM',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[700],
                ),
              ),
            ],
          ),
          ),
          const SizedBox(width: 10), // Add spacing between container and text
          
        ],
      ),
    );
  }
}
