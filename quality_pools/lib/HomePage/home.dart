import 'package:flutter/material.dart';
import 'package:quality_pools/CommonComponants/common_button.dart';
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
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16.0),
                itemCount: 1, // Number of rows
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
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          for (int i = 0; i < 6; i++) ...[
                            ReusableContainers(
                              titleText: "Container $i",
                              ppm: "PPM",
                              number: i + 1,
                            ),
                            const SizedBox(width: 10),
                          ],
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: CommonButton(
                buttonText: 'Test Pool',
                onPressed: () {
                  // Add your logic here
                },
              ),
            ),
              Padding(
              padding: const EdgeInsets.all(16.0),
              child: CommonButton(
                buttonText: 'My Pool Records',
                onPressed: () {
                  // Add your logic here
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
