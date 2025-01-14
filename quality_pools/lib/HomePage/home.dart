import 'package:flutter/material.dart';
import 'package:quality_pools/CommonComponants/reusable_containers.dart';
import 'package:quality_pools/CommonComponants/reusable_navbar.dart';

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('-QP-'),
          actions: [
            ReusableNavbar(
              optionText: '',
            ),
          ],
        ),
        body: Center(
          child: ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: 3, // Number of boxes
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.symmetric(vertical: 10.0),
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 4.0,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: ReusableContainers(
                  titleText: "Container $index",
                  ppm: "PPM",
                  number: index + 1,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
