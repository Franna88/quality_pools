import 'package:flutter/material.dart';
import 'package:quality_pools/CommonComponants/my_utility.dart';
import 'package:quality_pools/CommonComponants/reusable_gradient_button.dart';
import 'package:quality_pools/CommonComponants/reusable_grey_results_container.dart';
import 'package:quality_pools/MyPools/PoolNotes/pool_notes.dart';
import 'package:quality_pools/MyPools/PoolRecords/pool_records.dart';
import 'package:quality_pools/MyPools/TestPool/reusable_results_container.dart';
import 'package:quality_pools/MyPools/TestPool/test_pool.dart';

import 'package:quality_pools/PoolReadingsReusables/pool_readings.dart';
import 'package:quality_pools/Themes/quality_pool_textstyle.dart';
import 'package:quality_pools/main_page_layout.dart';

class TestResults extends StatelessWidget {
  final String poolName = 'Pool 1';
  final String poolImageUrl = 'images/pool_test_strip.png';

  const TestResults({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MainPageLayout(
      bodyContent: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                  poolName,
                  style: QualityPoolTextstyle(context).pageTitle,
                ),
                Spacer(),
                SizedBox(width: 20)
              ],
            ),
            SizedBox(height: MyUtility(context).height * 0.02),
            ClipRRect(
              borderRadius: const BorderRadius.all(
                Radius.circular(16.0),
              ),
              child: Image.network(
                poolImageUrl,
                width: double.infinity,
                height: 250,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: MyUtility(context).height * 0.02),
            PoolReadings(),
            SizedBox(height: MyUtility(context).height * 0.05),
            Text(
              'Possible fixes for the following:',
              style: QualityPoolTextstyle(context).blackStyleMedium,
              textAlign: TextAlign.start,
            ),
            SizedBox(height: MyUtility(context).height * 0.02),
            ReusableResultsContainer(
              causes: [
                'Insufficient sanitizer',
                'High pool usage',
                'Organic contaminants',
              ],
              fixes: [
                'Add liquid chlorine or granular chlorine.',
                'Shock the pool with a chlorine-based shock treatment.',
                'Check stabilizer (CyA) levels to ensure chlorine efficiency.',
              ],
              readingType: 'FCI',
              lowHigh: 'Low',
            ),
            ReusableResultsContainer(
              causes: [
                'Over-chlorination',
                'Recent shocking',
              ],
              fixes: [
                'Dilute pool water by partially draining and refilling.',
                'Use a chlorine neutralizer',
                'Allow time for chlorine to dissipate naturally under sunlight.',
              ],
              readingType: 'FCI',
              lowHigh: 'High',
            ),
            SizedBox(height: MyUtility(context).height * 0.02),
            ReusableGradientButton(
                text: 'Create a Note',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TestPool()),
                  );
                }),
            SizedBox(height: MyUtility(context).height * 0.02),
            ReusableGradientButton(
                text: 'Redo Analysis',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PoolRecords()),
                  );
                }),
            SizedBox(height: MyUtility(context).height * 0.02),
            ReusableGradientButton(
                text: 'Save Results',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PoolNotes()),
                  );
                }),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
