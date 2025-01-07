import 'package:flutter/material.dart';
import 'package:quality_pools/Themes/quality_pool_textstyle.dart';

class QualityPoolHeader extends StatelessWidget {
  const QualityPoolHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          children: [
            TextSpan(
              text: 'QUALITY\n',
              style: QualityPoolTextstyle(context).header1,
            ),
            TextSpan(
              text: '-POOLS-',
              style: QualityPoolTextstyle(context).header2,
            ),
          ],
        ),
      ),
    );
  }
}
