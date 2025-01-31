import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import the intl package
import 'package:quality_pools/CommonComponants/my_utility.dart';
import 'package:quality_pools/CommonComponants/reusable_gradient_button.dart';
import 'package:quality_pools/CommonComponants/reusable_grey_results_container.dart';
import 'package:quality_pools/MyPools/PoolRecords/line_chart.dart';
import 'package:quality_pools/MyPools/PoolNotes/notes_container.dart';
import 'package:quality_pools/MyPools/PoolRecords/chart_reading_filters.dart';
import 'package:quality_pools/MyPools/PoolNotes/post_note_popup.dart';

import 'package:quality_pools/PoolReadingsReusables/pool_readings.dart';
import 'package:quality_pools/Themes/quality_pool_textstyle.dart';
import 'package:quality_pools/Themes/quality_pools_colors.dart';
import 'package:quality_pools/main_page_layout.dart';

class PoolRecords extends StatefulWidget {
  final String readingType = 'ph';
  const PoolRecords({
    super.key,
  });

  @override
  _PoolRecordsState createState() => _PoolRecordsState();
}

class _PoolRecordsState extends State<PoolRecords> {
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
                  'Pool Records',
                  style: QualityPoolTextstyle(context).pageTitle,
                ),
                Spacer(),
                SizedBox(width: 20)
              ],
            ),
            SizedBox(height: 20),
            ChartReadingFilters(),
            LineChartWidget(),
            ReusableGreyResultsContainer(
                description: 'Current pH Level', result: '7.2'),
            ReusableGreyResultsContainer(
                description: 'Average pH Level', result: '7'),
          ],
        ),
      ),
    );
  }
}
