import 'package:flutter/material.dart';
import 'package:quality_pools/CommonComponants/my_utility.dart';
import 'package:quality_pools/MyPools/delete_course_popup.dart';
import 'package:quality_pools/Themes/quality_pool_textstyle.dart';
import 'package:quality_pools/Themes/quality_pools_colors.dart';

class PoolHomepageContainer extends StatelessWidget {
  final String imageUrl;
  final String poolName;
  final VoidCallback onEdit;

  const PoolHomepageContainer({
    Key? key,
    required this.imageUrl,
    required this.poolName,
    required this.onEdit,
  }) : super(key: key);

  Future<void> _openDeletCoursePopup(BuildContext context) => showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: DeletePoolPopup(),
          );
        },
      );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
        width: MyUtility(context).width * 0.9,
        height: MyUtility(context).height * 0.315,
        decoration: BoxDecoration(
          color: MyColors().lightGrey,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16.0),
            topRight: Radius.circular(16.0),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade400,
              blurRadius: 1,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16.0),
                topRight: Radius.circular(16.0),
              ),
              child: Image.network(
                imageUrl,
                width: double.infinity,
                height: MyUtility(context).height * 0.25,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(poolName,
                      style: QualityPoolTextstyle(context).blackStyleMedium),
                  Row(
                    children: [
                      Container(
                        width: MyUtility(context).width * 0.1,
                        height: MyUtility(context).width * 0.1,
                        child: IconButton(
                          icon: Icon(
                            Icons.mode_edit_outline_outlined,
                            color: MyColors().lightBlue,
                          ),
                          onPressed: onEdit,
                        ),
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade400,
                              blurRadius: 1,
                              offset: Offset(0, 4),
                            ),
                          ],
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      SizedBox(width: 10),
                      Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade400,
                              blurRadius: 1,
                              offset: Offset(0, 4),
                            ),
                          ],
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        width: MyUtility(context).width * 0.1,
                        height: MyUtility(context).width * 0.1,
                        child: IconButton(
                          icon: const Icon(
                            Icons.delete_outline_outlined,
                            color: Colors.red,
                          ),
                          onPressed: () => _openDeletCoursePopup(context),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
