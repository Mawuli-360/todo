class OnboardState {
  final int index;
  OnboardState({
    this.index = 0,
  });

  OnboardState.initial({
    this.index = 0,
  });

  OnboardState copyWith({
    int? index,
  }) {
    return OnboardState(
      index: index ?? this.index,
    );
  }
}
