import 'package:flutter/material.dart';
import 'package:quality_pools/CommonComponants/my_utility.dart';
import 'package:quality_pools/Themes/quality_pool_textstyle.dart';
import 'package:quality_pools/Themes/quality_pools_colors.dart';

class ReusableGreyResultsContainer extends StatelessWidget {
  final String description;
  final String result;
  const ReusableGreyResultsContainer(
      {super.key, required this.description, required this.result});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade400,
              blurRadius: 1,
              offset: Offset(0, 4),
            ),
          ],
        ),
        width: MyUtility(context).width * 0.9,
        height: MyUtility(context).height * 0.06,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(description,
                  style: QualityPoolTextstyle(context).blackbodyText),
              const Spacer(),
              Text(result,
                  style: QualityPoolTextstyle(context).blackbodyText.copyWith(
                      color: MyColors().lightBlue,
                      fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }
}
