import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'app_theme_provider.g.dart';

@riverpod
class ThemeChange extends _$ThemeChange {
  @override
  bool build() {
    return false;
  }

  void setThemeChanger() {
    state = !state;
  }
}
