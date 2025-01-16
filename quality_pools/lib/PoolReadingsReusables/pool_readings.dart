import 'package:flutter/material.dart';
import 'package:quality_pools/PoolReadingsReusables/blue_readings_container.dart';
import 'package:quality_pools/Themes/quality_pool_textstyle.dart';

class PoolReadings extends StatelessWidget {
  // Initialize the readingTypes list with abbreviations and their full names
  final Map<String, String> readingDetails = {
    'FCI': 'Free Chlorine',
    'TCI': 'Total Chlorine',
    'Alk': 'Alkalinity',
    'pH': 'Potential Hydrogen',
    'TH': 'Total Hardness',
    'CyA': 'Cyanuric Acid',
  };

  PoolReadings({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Center(
      child: Wrap(
        spacing: screenWidth *
            0.05, // Horizontal space between items (5% of screen width)
        runSpacing: screenHeight *
            0.05, // Vertical space between rows (5% of screen height)
        children: readingDetails.entries
            .map((entry) => Flexible(
                  child: GestureDetector(
                    onTap: () {
                      _showTooltip(context, entry.key, entry.value);
                    },
                    child: BlueReadingsContainer(
                      readingType: entry.key,
                    ),
                  ),
                ))
            .toList(),
      ),
    );
  }

  // Method to show the tooltip popup
  void _showTooltip(
      BuildContext context, String abbreviation, String fullName) {
    showDialog(
      context: context,
      barrierDismissible:
          false, // Prevent closing the dialog by tapping outside
      builder: (context) {
        return FadeTooltip(
          abbreviation: abbreviation,
          fullName: fullName,
        );
      },
    );
  }
}

class FadeTooltip extends StatefulWidget {
  final String abbreviation;
  final String fullName;

  const FadeTooltip({
    required this.abbreviation,
    required this.fullName,
  });

  @override
  _FadeTooltipState createState() => _FadeTooltipState();
}

class _FadeTooltipState extends State<FadeTooltip> {
  double _opacity = 1.0;

  @override
  void initState() {
    super.initState();

    // Schedule the fade-out and close the dialog after 3 seconds
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _opacity = 0.0; // Start fading out
      });

      // Close the dialog after the fade effect is done
      Future.delayed(const Duration(seconds: 2), () {
        if (Navigator.of(context).canPop()) {
          Navigator.of(context).pop();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Center(
      child: AnimatedOpacity(
        opacity: _opacity,
        duration: const Duration(seconds: 3), // Duration of fade effect
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Display the selected BlueReadingsContainer
            BlueReadingsContainer(
              readingType: widget.abbreviation,
            ),
            SizedBox(
                height: screenHeight *
                    0.02), // Add spacing between the two containers
            // Display the blue container with the full name
            Container(
              padding: EdgeInsets.all(
                  screenWidth * 0.04), // Adjust padding to be responsive
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Text(
                widget.fullName,
                style: QualityPoolTextstyle(context).whitebodyText,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
