class OnboardState {
  final int index;
  final bool isOnboardCompleted;
  OnboardState({required this.index, required this.isOnboardCompleted});

  OnboardState.initial({this.index = 0, this.isOnboardCompleted = false});

  OnboardState copyWith({int? index, bool? isOnboardCompleted}) {
    return OnboardState(
        index: index ?? this.index,
        isOnboardCompleted: isOnboardCompleted ?? this.isOnboardCompleted);
  }
}
