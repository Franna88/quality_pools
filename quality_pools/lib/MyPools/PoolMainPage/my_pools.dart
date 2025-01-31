import 'package:flutter/material.dart';
import 'package:quality_pools/CommonComponants/reusable_gradient_button.dart';
import 'package:quality_pools/MyPools/PoolMainPage/pool_listing_containers.dart';
import 'package:quality_pools/MyPools/PoolMainPage/view_pools.dart';
import 'package:quality_pools/Themes/quality_pool_textstyle.dart';
import 'package:quality_pools/main_page_layout.dart';

class MyPools extends StatefulWidget {
  const MyPools({super.key});

  @override
  _MyPoolsState createState() => _MyPoolsState();
}

class _MyPoolsState extends State<MyPools> {
  final List<String> pools = ['Pool 1', 'Pool 2', 'Pool 3']; // List of pools

  void _selectPool(String pool, String imageUrl) {
    // Navigate to the ViewPools page and pass the pool name and image URL
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ViewPools(
          poolName: pool,
          poolImageUrl: imageUrl,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MainPageLayout(
      bodyContent: PoolListView(
        pools: pools,
        selectPool: _selectPool,
      ),
    );
  }
}

class PoolListView extends StatelessWidget {
  final List<String> pools;
  final Function(String, String) selectPool;

  const PoolListView({
    required this.pools,
    required this.selectPool,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'My Pools',
              style: QualityPoolTextstyle(context).pageTitle,
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: pools.length,
                itemBuilder: (context, index) {
                  return PoolListingContainers(
                    imageUrl:
                        'images/poolImage.png', // Replace with your pool image URL
                    poolName: pools[index],
                    onEdit: () => selectPool(
                        pools[index], 'images/poolImage.png'), // Pass image URL
                  );
                },
              ),
            ),
          ],
        ),
        Positioned(
          bottom: 20, // Adjust the bottom distance as needed
          left: 0,
          right: 0,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ReusableGradientButton(
              text: 'Add New Pool',
              onTap: () {},
            ),
          ),
        ),
      ],
    );
  }
}
