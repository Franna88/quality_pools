import 'package:flutter/material.dart';
import 'package:quality_pools/CommonComponants/my_utility.dart';
import 'package:quality_pools/Themes/quality_pool_textstyle.dart';
import 'package:quality_pools/Themes/quality_pools_colors.dart';

class DeletePoolPopup extends StatelessWidget {
  const DeletePoolPopup({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MyUtility(context).height * 0.3,
      width: MyUtility(context).width * 0.5,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'Remove Pool?',
                style: QualityPoolTextstyle(context).pageTitle,
              ),
              Text(
                'Are you sure you want to remove this Pool?',
                style: QualityPoolTextstyle(context).blackbodyText,
                textAlign: TextAlign.center,
              ),
              Container(
                width: MyUtility(context).width * 0.6,
                decoration: BoxDecoration(
                  color: MyColors().red,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: FilledButton(
                  style: FilledButton.styleFrom(
                    backgroundColor: Colors
                        .transparent, // Set transparent to avoid overriding the container color
                    minimumSize: const Size(200, 45),
                  ),
                  onPressed: () {},
                  child: Text(
                    'Remove',
                    style: const TextStyle(
                        fontFamily: 'Judson', color: Colors.black),
                  ),
                ),
              ),
              Container(
                width: MyUtility(context).width * 0.6,
                decoration: BoxDecoration(
                  color: MyColors().lightBlue,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: FilledButton(
                  style: FilledButton.styleFrom(
                    backgroundColor: Colors
                        .transparent, // Set transparent to avoid overriding the container color
                    minimumSize: const Size(200, 45),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Cancel',
                    style: const TextStyle(
                        fontFamily: 'Judson', color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
