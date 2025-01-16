import 'package:flutter/material.dart';
import 'package:quality_pools/CommonComponants/reusable_gradient_button.dart';
import 'package:quality_pools/HomePage/homepage_recent_readings.dart';
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
            style: QualityPoolTextstyle(context).blackSubheaderText,
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
                Container(
                  width: MediaQuery.of(context).size.width *
                      0.1, // Adjusted width to 1%
                  height: MediaQuery.of(context).size.height *
                      0.05, // Adjusted height to 7%
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 3,
                        offset: Offset(0, 3), // Shadow position
                      ),
                    ],
                  ),
                  child: Center(
                    child: IconButton(
                      icon: Icon(Icons.arrow_back_ios,
                          size: 18, color: Colors.grey.shade600),
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
                ),

                // Grey Line Break
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Container(
                    width: 5,
                    height: MediaQuery.of(context).size.height *
                        0.05, // Adjusted height to 7%
                    color: Colors.grey.shade600,
                  ),
                ),

                // Right Arrow
                Container(
                  width: MediaQuery.of(context).size.width *
                      0.1, // Adjusted width to 1%
                  height: MediaQuery.of(context).size.height *
                      0.05, // Adjusted height to 7%
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 3,
                        offset: Offset(0, 3), // Shadow position
                      ),
                    ],
                  ),
                  child: Center(
                    child: IconButton(
                      icon: Icon(Icons.arrow_forward_ios,
                          size: 18, color: Colors.grey.shade600),
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
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          ReusableGradientButton(text: 'Test Pool', onTap: () {}),
          const SizedBox(height: 10),
          ReusableGradientButton(text: 'My Pool Records', onTap: () {}),
        ],
      ),
    );
  }
}
