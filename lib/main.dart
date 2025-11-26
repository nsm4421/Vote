import 'package:app_theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:vote/core/di/dependency_injection.dart';
import 'package:vote/core/extension/build_context_extension.dart';
import 'package:vote/core/l10n/app_localizations.dart';

import 'app/router/app_router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  runApp(const _AppView());
}

class _AppView extends StatelessWidget {
  const _AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      onGenerateTitle: (context) => context.l10n.appTitle,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      routerConfig: AppRouter.appRouter,
    );
  }
}
