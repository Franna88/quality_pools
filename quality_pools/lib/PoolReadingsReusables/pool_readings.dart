import 'package:flutter/material.dart';
import 'package:quality_pools/PoolReadingsReusables/blue_readings_container.dart';
import 'package:quality_pools/Themes/quality_pool_textstyle.dart';

class PoolReadings extends StatelessWidget {
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
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade400,
            blurRadius: 1,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Center(
          child: Wrap(
            spacing: 16.0, // Fixed horizontal space between items
            runSpacing: 16.0, // Fixed vertical space between rows
            alignment: WrapAlignment.center, // Align children to the center
            children: readingDetails.entries
                .map((entry) => GestureDetector(
                      onTap: () {
                        _showTooltip(context, entry.key, entry.value);
                      },
                      child: BlueReadingsContainer(
                        readingType: entry.key,
                      ),
                    ))
                .toList(),
          ),
        ),
      ),
    );
  }

  void _showTooltip(
      BuildContext context, String abbreviation, String fullName) {
    showDialog(
      context: context,
      barrierDismissible: false,
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
                height: 16.0), // Add fixed spacing between the two containers
            // Display the blue container with the full name
            Container(
              padding: EdgeInsets.all(16.0), // Fixed padding
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
