import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:todo/shared/resources/app_colors.dart';
import 'package:todo/shared/resources/app_strings.dart';

class Header extends ConsumerWidget {
  const Header({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final now = DateTime.now();
    final formattedDate = DateFormat('EEEE, MMMM d').format(now);
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: SizedBox(
        height: 6.h,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Text(
              AppStrings.appName,
              style: TextStyle(fontSize: 45, fontWeight: FontWeight.bold),
            ),
            Container(
              height: double.infinity,
              margin: const EdgeInsets.only(right: 10),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      formattedDate,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.black45,
                      ),
                    ),
                    const SizedBox(width: 5),
                    const Padding(
                      padding: EdgeInsets.only(bottom: 4),
                      child: Icon(
                        Icons.calendar_month,
                        color: AppColors.purple,
                      ),
                    )
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
