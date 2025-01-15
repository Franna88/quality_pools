import 'package:flutter/material.dart';
import 'package:quality_pools/Themes/quality_pool_textstyle.dart';

class PoolDetailsView extends StatelessWidget {
  final String pool;
  final VoidCallback goBack;

  const PoolDetailsView({required this.pool, required this.goBack, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          pool, // Display selected pool name
          style: QualityPoolTextstyle(context).blackbodyText,
        ),
        SizedBox(height: 20),
        // Pool details content
        Text(
          'Details of $pool go here...',
          style: QualityPoolTextstyle(context).blackbodyText,
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: goBack, // Go back to the list of pools
          child: Text('Back to My Pools'),
        ),
      ],
    );
  }
}
