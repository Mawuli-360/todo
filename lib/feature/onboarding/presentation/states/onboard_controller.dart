import 'package:hive/hive.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:todo/feature/onboarding/presentation/states/onboard_state.dart';
import 'package:todo/feature/todo/domain/model/onboarding_model.dart';
part 'onboard_controller.g.dart';

const String onboardBox = "onboard";

@riverpod
class OnboardController extends _$OnboardController {
  @override
  OnboardState build() {
    checkOnboardingStatus();
    return OnboardState.initial();
  }

  void onScreenChanged(int value) {
    state = state.copyWith(index: value);
  }

  Future<bool> checkOnboardingStatus() async {
    final box = await Hive.openBox(onboardBox);

    bool onboardingCompleted =
        box.isNotEmpty ? box.getAt(0).onboardingCompleted : false;
    // state = state.copyWith(isOnboardCompleted: onboardingCompleted);
    return onboardingCompleted;
  }

  void completeOnboarding() async {
    final box = await Hive.openBox(onboardBox);
    if (box.isNotEmpty) {
      box.putAt(0, OnboardingModel(onboardingCompleted: true));
    } else {
      box.add(OnboardingModel(onboardingCompleted: true));
    }
  }
}
