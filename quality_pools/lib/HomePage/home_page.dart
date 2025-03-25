import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:quality_pools/CommonComponants/my_utility.dart';
import 'package:quality_pools/CommonComponants/reusable_gradient_button.dart';
import 'package:quality_pools/HomePage/homepage_recent_readings.dart';
import 'package:quality_pools/MyPools/PoolRecords/pool_records.dart';
import 'package:quality_pools/MyPools/TestPool/test_pool.dart';
import 'package:quality_pools/Themes/quality_pools_colors.dart';
import 'package:quality_pools/main_page_layout.dart';
import 'package:quality_pools/Themes/quality_pool_textstyle.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final pools = [
      {'name': 'Pool 1', 'date': 'MON, 2 Feb'},
      {'name': 'Pool 2', 'date': 'TUE, 3 Feb'},
      {'name': 'Pool 3', 'date': 'WED, 4 Feb'},
    ];

    final PageController pageController = PageController();

    return MainPageLayout(
      bodyContent: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Most Recent Readings',
            style: QualityPoolTextstyle(context).pageTitle,
          ),
          const SizedBox(height: 10),
          Expanded(
            child: PageView.builder(
              controller: pageController,
              itemCount: pools.length,
              itemBuilder: (context, index) {
                final pool = pools[index];
                return HomePageRecentReadings(
                  poolName: pool['name']!,
                  date: pool['date']!,
                );
              },
            ),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Left Arrow
                Center(
                  child: IconButton(
                    icon: Icon(Icons.keyboard_double_arrow_left,
                        size: 50, color: MyColors().darkBlue),
                    onPressed: () {
                      if (pageController.hasClients) {
                        pageController.previousPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      }
                    },
                  ),
                ),

                // Grey Line Break
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Container(
                    width: 6,
                    height: MediaQuery.of(context).size.height *
                        0.05, // Adjusted height to 7%
                    color: Colors.grey.shade200,
                  ),
                ),

                // Right Arrow
                Center(
                  child: IconButton(
                    icon: Icon(Icons.keyboard_double_arrow_right,
                        size: 50, color: MyColors().darkBlue),
                    onPressed: () {
                      if (pageController.hasClients) {
                        pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          // Container(
          //   width: MyUtility(context).width,
          //   height: MyUtility(context).width * 0.2,
          //   child: Center(
          //     child: Lottie.network(
          //         'https://lottie.host/2c72ae92-f834-4c00-bba1-19352a6dc03a/EX6egWXuPl.lottie'),
          //   ),
          // ),
          const SizedBox(height: 20),
          ReusableGradientButton(
              text: 'Test Pool',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => TestPool(
                            poolId: 'pool_1', // Example pool ID
                            poolName: 'Pool 1', // Example pool name
                          )),
                );
              }),
          const SizedBox(height: 10),
          ReusableGradientButton(
              text: 'My Pool Records',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PoolRecords()),
                );
              }),
        ],
      ),
    );
  }
}
