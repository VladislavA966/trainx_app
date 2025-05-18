import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trainx_app/core/recources/dimensions.dart';
import 'package:trainx_app/core/router/app_router_config.gr.dart';
import 'package:trainx_app/core/utils/validation_mixin.dart';
import 'package:trainx_app/features/auth/domain/repository/auth_repository.dart';
import 'package:trainx_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:trainx_app/features/workouts/presentation/screens/workout_types_screen.dart';

import 'package:trainx_app/features/widgets/export.dart';

@RoutePage()
class LogInScreen extends StatefulWidget {
  const LogInScreen({
    super.key,
  });

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> with ValidationMixin {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Вход'),
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Dimensions.unit,
              vertical: Dimensions.unit2,
            ),
            child: Column(
              children: [
                const SizedBox(height: Dimensions.unit3),
                AppTextFormField(
                  controller: _emailController,
                  labelText: 'Email',
                  validator: validateEmail,
                  keyboardType: TextInputType.emailAddress,
                  inputAction: TextInputAction.next,
                ),
                const SizedBox(height: Dimensions.unit2),
                AppTextFormField(
                  controller: _passwordController,
                  labelText: 'Пароль',
                  obscureText: true,
                ),
                const SizedBox(height: Dimensions.unit2),
                BlocConsumer<AuthCubit, AuthState>(
                  listener: _authListener,
                  builder: (context, state) {
                    if (state.isLoading) {
                      return const CircularProgressIndicator();
                    }
                    return AppButton(
                      title: 'Войти',
                      onPressed: _signIn,
                    );
                  },
                ),
                const SizedBox(height: Dimensions.unit),
                Text(
                  'Нет аккаунта?',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                TextButton(
                  onPressed: () {
                    context.pushRoute(SignInRoute());
                  },
                  child: Text('Зарегистрироваться'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _signIn() {
    if (_formKey.currentState!.validate()) {
      final authParams = AuthParams(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      context.read<AuthCubit>().signIn(authParams);
    }
  }

  void _authListener(BuildContext context, AuthState state) {
    if (state is AuthError) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        showCloseIcon: true,
        content: Text(state.message),
        backgroundColor: Colors.red,
      ));
    } else if (state is AuthLoaded) {
      context.pop(3);
    }
  }
}
