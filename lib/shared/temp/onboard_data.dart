import 'package:todo/feature/onboarding/domain/onboard.dart';
import 'package:todo/shared/resources/app_images.dart';
import 'package:todo/shared/resources/app_strings.dart';

class OnboardData {
OnboardData._();

static List<Onboard> onboardData = [
  Onboard(
    title: AppStrings.onboardingOneTitle,
    subTitle: AppStrings.onboardingOneSubTitle,
    image: AppImages.onboardingOne,
  ),
  Onboard(
    title: AppStrings.onboardingTwoTitle,
    subTitle: AppStrings.onboardingTwoSubTitle,
    image: AppImages.onboardingTwo,
  ),
  Onboard(
    title: AppStrings.onboardingThreeTitle,
    subTitle: AppStrings.onboardingThreeSubTitle,
    image: AppImages.onboardingThree,
  ),
];

}