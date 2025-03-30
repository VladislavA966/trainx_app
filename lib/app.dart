import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:trainx_app/core/di/inject.dart';
import 'package:trainx_app/core/router/app_router_config.dart';
import 'package:trainx_app/core/theme/app_theme.dart';
import 'package:trainx_app/features/auth/presentation/cubit/auth_cubit.dart';

import 'generated/l10n.dart';

class TrainXApp extends StatelessWidget {
  const TrainXApp({super.key});

  @override
  Widget build(BuildContext context) {
    final appRouter = AppRouter(inject());
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(
          value: inject<AuthCubit>()..checkUserAuth(),
        ),
      ],
      child: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
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
        },
      ),
    );
  }
}
