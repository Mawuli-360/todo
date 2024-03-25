import 'package:hive/hive.dart';
part 'onboarding_model.g.dart';

@HiveType(typeId: 0)
class OnboardingModel {
  @HiveField(0)
  bool onboardingCompleted;

  OnboardingModel({required this.onboardingCompleted});
}
