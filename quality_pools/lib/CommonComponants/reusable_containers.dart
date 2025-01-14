import 'package:flutter/material.dart';
//002a6a
class ReusableContainers  extends StatelessWidget{
  final String titleText;
  final int number;
  final String ppm;

  const ReusableContainers({
    Key? key,
    required this.titleText,
    required this.number,
    required this.ppm,

  }):super(key:key);

  @override
  Widget build(BuildContext context){
    return Center(
          child: Row(
            children: [
              Container(
                  width: 100, // Set the width of the container
                  height: 100, // Set the height of the container
                  decoration: BoxDecoration(
                    color: Colors.blue, // Background color
                    borderRadius: BorderRadius.circular(10), // Rounded corners
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26, // Shadow color
                        blurRadius: 4.0, // Shadow blur
                        offset: Offset(2, 2)
                )
              ],
                ),
                child: Row(children: [
                  Text(titleText),
                  Text(ppm),
                ],),
              ),
            ],
          )
      );
    

    
  }

}