import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:todo/shared/temp/onboard_data.dart';





class OnboardPage extends ConsumerWidget {
  const OnboardPage({ required this.controller,required this.onPageChanged, 
    super.key,
  });

  final void Function(int)? onPageChanged;
  final PageController controller;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Expanded(
      child: PageView.builder(
        controller: controller,
        onPageChanged: onPageChanged,
        itemCount: OnboardData.onboardData.length,
        itemBuilder: (context, index) {
          return 
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image(image: OnboardData.onboardData[index].image),
              const SizedBox(height: 10),
              Text(
                OnboardData.onboardData[index].title,
                style: const TextStyle(fontSize: 24, color: Colors.black54),
              ),
              const SizedBox(height: 5),
              Text(
                OnboardData.onboardData[index].subTitle,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black38,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
