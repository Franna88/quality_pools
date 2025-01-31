import 'package:flutter/material.dart';
import 'package:quality_pools/Themes/quality_pool_textstyle.dart';

class ChartReadingFilters extends StatefulWidget {
  ChartReadingFilters({super.key});

  @override
  _ChartReadingFiltersState createState() => _ChartReadingFiltersState();
}

class _ChartReadingFiltersState extends State<ChartReadingFilters> {
  final Map<String, String> readingDetails = {
    'FCI': 'Free Chlorine',
    'TCI': 'Total Chlorine',
    'Alk': 'Alkalinity',
    'pH': 'Potential Hydrogen',
    'TH': 'Total Hardness',
    'CyA': 'Cyanuric Acid',
  };

  String? selectedReading;

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
                        _applyFilter(entry.key);
                      },
                      child: FilterButton(
                        readingType: entry.key,
                        isSelected: selectedReading == entry.key,
                      ),
                    ))
                .toList(),
          ),
        ),
      ),
    );
  }

  void _applyFilter(String selectedKey) {
    setState(() {
      selectedReading = selectedKey;
    });
    // You can perform additional filtering logic here based on the selected reading type.
  }
}

class FilterButton extends StatelessWidget {
  final String readingType;
  final bool isSelected;

  const FilterButton({
    Key? key,
    required this.readingType,
    this.isSelected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width * 0.22;

    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Container(
        height: size,
        width: size,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0XFF1A8CF0),
              Color(0XFF095BB2),
            ],
          ),
          borderRadius: BorderRadius.circular(10),
          border: isSelected
              ? Border.all(
                  color: Colors.lightGreenAccent,
                  width: 3) // Highlight the selected container with light green
              : null,
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: Text(
              readingType,
              style: QualityPoolTextstyle(context).readingType,
            ),
          ),
        ),
      ),
    );
  }
}
