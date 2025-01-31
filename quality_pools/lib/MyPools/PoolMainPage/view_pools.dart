import 'package:flutter/material.dart';
import 'package:quality_pools/CommonComponants/reusable_gradient_button.dart';
import 'package:quality_pools/CommonComponants/reusable_grey_results_container.dart';
import 'package:quality_pools/MyPools/PoolNotes/pool_notes.dart';
import 'package:quality_pools/MyPools/PoolRecords/pool_records.dart';

import 'package:quality_pools/PoolReadingsReusables/pool_readings.dart';
import 'package:quality_pools/Themes/quality_pool_textstyle.dart';
import 'package:quality_pools/main_page_layout.dart';

class ViewPools extends StatelessWidget {
  final String poolName;
  final String poolImageUrl;
  final String lastReadingDate = 'Mon, 2 Feb';
  final String nextReadingDate = 'Mon, 16 Feb';

  const ViewPools({
    required this.poolName,
    required this.poolImageUrl,
    super.key,
  });

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
                  poolName,
                  style: QualityPoolTextstyle(context).pageTitle,
                ),
                Spacer(),
                SizedBox(width: 20)
              ],
            ),
            SizedBox(height: 20),
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
            SizedBox(height: 20),
            PoolReadings(),
            SizedBox(height: 20),
            ReusableGreyResultsContainer(
                description: 'Last Reading Date', result: lastReadingDate),
            ReusableGreyResultsContainer(
                description: 'Next Reading Date', result: nextReadingDate),
            SizedBox(height: 50),
            ReusableGradientButton(text: 'Test Pool', onTap: () {}),
            SizedBox(height: 20),
            ReusableGradientButton(
                text: 'My Pool Records',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PoolRecords()),
                  );
                }),
            SizedBox(height: 20),
            ReusableGradientButton(
                text: 'My Pool Notes',
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
