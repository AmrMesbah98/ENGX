import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ItemOfOneClick extends StatelessWidget {
  const ItemOfOneClick(
      {super.key,
      required this.name,
      required this.icon,
      required this.screen});

  final String name;

  final IconData icon;

  final Widget screen;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (_) {
          return screen;
        }));
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        child: Column(
          children: [
            Container(
              width: 50.h,
              height: 50.w,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[200]!, width: 2),
                  borderRadius: BorderRadius.circular(15.r),
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: <Color>[Colors.white, Colors.grey[200]!]),
                  color: Colors.grey[100]),
              child: Icon(
                icon,
                color: Colors.blue[400],
              ),
            ),
            SizedBox(height: 6.h),
            SizedBox(
              width: 75.w,
              child: Center(
                child: Text(
                  name,
                  style: TextStyle(
                    fontSize: 13.sp,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
