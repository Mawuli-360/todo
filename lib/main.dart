import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sizer/sizer.dart';

import 'package:todo/feature/onboarding/presentation/onboarding_screen.dart';
import 'package:todo/feature/onboarding/presentation/states/onboard_controller.dart';
import 'package:todo/feature/todo/domain/model/onboarding_model.dart';
import 'package:todo/feature/todo/domain/model/todo_model.dart';
import 'package:todo/feature/todo/presentation/view/todo_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter((await getApplicationDocumentsDirectory()).path);
  Hive.registerAdapter(TodoModelAdapter());
  Hive.registerAdapter(OnboardingModelAdapter());
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  final container = ProviderContainer(overrides: []);

  final isOnboardCompleted = container.read(onboardControllerProvider.notifier);

  runApp(UncontrolledProviderScope(
    container: container,
    child: Todo(
      isOnboardCompleted: await isOnboardCompleted.checkOnboardingStatus(),
    ),
  ));
}

class Todo extends ConsumerWidget {
  final bool isOnboardCompleted;

  const Todo({
    super.key,
    required this.isOnboardCompleted,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Sizer(builder: (context, orientation, deviceType) {
      return MaterialApp(
        // theme: AppTheme.lightTheme,
        // darkTheme: AppTheme.darkTheme,
        // themeMode: appThemeState ? ThemeMode.dark : ThemeMode.light,
        debugShowCheckedModeBanner: false,
        initialRoute: isOnboardCompleted ? '/home' : '/onboarding',
        routes: {
          '/onboarding': (context) => const OnboardingScreen(),
          '/home': (context) => const TodoScreen(),
        },
      );
    });
  }
}
