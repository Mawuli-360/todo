import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:todo/feature/onboarding/presentation/states/onboard_state.dart';
part 'onboard_controller.g.dart';

@riverpod
class OnboardController extends _$OnboardController {
  @override
  OnboardState build() => OnboardState.initial();

  void onScreenChanged(int value) {
    state = state.copyWith(index: value);
    print(state.index);
  }
}
