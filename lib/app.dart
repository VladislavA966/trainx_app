import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:trainx_app/core/di/inject.dart';
import 'package:trainx_app/core/router/app_router_config.dart';
import 'package:trainx_app/core/theme/app_theme.dart';
import 'package:trainx_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'generated/l10n.dart';

final l10n = S.current;

class TrainXApp extends StatefulWidget {
  const TrainXApp({super.key});

  @override
  State<TrainXApp> createState() => _TrainXAppState();
}

class _TrainXAppState extends State<TrainXApp> {
  late final AppRouter _appRouter;
  late final AuthCubit _authCubit;

  @override
  void initState() {
    super.initState();
    _authCubit = inject<AuthCubit>();
    _authCubit.checkUserAuth();
    _appRouter = AppRouter(_authCubit);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: _authCubit),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.darkTheme,
        localizationsDelegates: [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        routerConfig: _appRouter.config(),
      ),
    );
  }
}
