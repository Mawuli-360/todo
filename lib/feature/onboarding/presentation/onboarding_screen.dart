import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/feature/onboarding/presentation/states/onboard_controller.dart';
import 'package:todo/feature/onboarding/presentation/widget/onboard_page.dart';
import 'package:todo/feature/todo/presentation/todo_screen.dart';
import 'package:todo/shared/resources/app_colors.dart';
import 'package:todo/shared/resources/app_strings.dart';
import 'package:todo/shared/temp/onboard_data.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  PageController controller = PageController();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final onboardController = ref.watch(onboardControllerProvider);

    return Scaffold(
        body: SizedBox(
      width: width,
      child: Column(
        children: [
          OnboardPage(
            onPageChanged: (value) => ref
                .read(onboardControllerProvider.notifier)
                .onScreenChanged(value),
            controller: controller,
          ),
          onboardController.index == OnboardData.onboardData.length - 1
              ? GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const TodoScreen()));
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    height: 50,
                    width: width,
                    decoration: const BoxDecoration(
                        color: AppColors.purple,
                        borderRadius: BorderRadius.all(Radius.circular(7))),
                    child: const Center(
                        child: Text(
                      AppStrings.getStarted,
                      style: TextStyle(
                          fontSize: 16,
                          letterSpacing: 2,
                          color: AppColors.white),
                    )),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const TodoScreen()));
                            },
                            child: const Text(
                              AppStrings.skip,
                              style: TextStyle(
                                  color: AppColors.grey, letterSpacing: 2),
                            )),
                        SizedBox(
                          width: width * 0.1,
                          height: height * 0.01,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: OnboardData.onboardData.length,
                              itemBuilder: (context, index) {
                                return _buildDot(width, height, index);
                              }),
                        ),
                        TextButton(
                            onPressed: () {
                              controller.nextPage(
                                  duration: const Duration(milliseconds: 600),
                                  curve: Curves.easeInOut);
                            },
                            child: const Text(
                              AppStrings.next,
                              style: TextStyle(
                                  color: AppColors.purple, letterSpacing: 2),
                            )),
                      ]),
                ),
          Container(
            height: height * 0.05,
          )
        ],
      ),
    ));
  }

  Widget _buildDot(double width, double height, int currentDot) {
    return AnimatedContainer(
      curve: Curves.easeInOut,
      margin: EdgeInsets.only(right: width * 0.02),
      width: ref.watch(onboardControllerProvider).index == currentDot
          ? width * 0.03
          : width * 0.01,
      height: 1,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: AppColors.purple,
      ),
      duration: const Duration(milliseconds: 600),
    );
  }
}
