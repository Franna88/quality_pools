import 'package:flutter/material.dart';
import 'package:quality_pools/MyPools/view_pools.dart';
import 'package:quality_pools/Themes/quality_pool_textstyle.dart';
import 'package:quality_pools/main_page_layout.dart';

class MyPools extends StatefulWidget {
  const MyPools({super.key});

  @override
  _MyPoolsState createState() => _MyPoolsState();
}

class _MyPoolsState extends State<MyPools> {
  bool _isPoolSelected = false; // Tracks whether a pool is selected
  String? _selectedPool; // Holds the name of the selected pool

  final List<String> pools = ['Pool 1', 'Pool 2', 'Pool 3']; // List of pools

  void _selectPool(String pool) {
    setState(() {
      _selectedPool = pool;
      _isPoolSelected = true; // Switch to pool details view
    });
  }

  void _goBackToList() {
    setState(() {
      _selectedPool = null;
      _isPoolSelected = false; // Switch back to pool list
    });
  }

  @override
  Widget build(BuildContext context) {
    return MainPageLayout(
      bodyContent: _isPoolSelected
          ? PoolDetailsView(pool: _selectedPool!, goBack: _goBackToList)
          : PoolListView(pools: pools, selectPool: _selectPool),
    );
  }
}

class PoolListView extends StatelessWidget {
  final List<String> pools;
  final Function(String) selectPool;

  const PoolListView(
      {required this.pools, required this.selectPool, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'My Pools',
          style: QualityPoolTextstyle(context).blackbodyText,
        ),
        SizedBox(height: 20),
        // List of pools
        Expanded(
          child: ListView.builder(
            itemCount: pools.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(
                  pools[index],
                  style: QualityPoolTextstyle(context).blackbodyText,
                ),
                onTap: () => selectPool(pools[index]), // Select pool
              );
            },
          ),
        ),
      ],
    );
  }
}
