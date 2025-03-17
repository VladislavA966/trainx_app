import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:trainx_app/core/router/app_router_config.dart';
import 'package:trainx_app/core/theme/app_theme.dart';

import 'generated/l10n.dart';

class TrainXApp extends StatelessWidget {
  const TrainXApp({super.key});

  @override
  Widget build(BuildContext context) {
    final appRouter = AppRouter();
    return MaterialApp.router(
      theme: AppTheme.lightTheme,
      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      routerConfig: appRouter.config(),
    );
  }
}
