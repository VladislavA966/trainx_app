import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trainx_app/core/recources/dimensions.dart';
import 'package:trainx_app/core/router/app_router_config.gr.dart';
import 'package:trainx_app/core/utils/validation_mixin.dart';
import 'package:trainx_app/features/auth/domain/repository/auth_repository.dart';
import 'package:trainx_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:trainx_app/features/profile/profile_screens_container.dart';
import 'package:trainx_app/features/workouts/presentation/screens/workout_types_screen.dart';

@RoutePage()
class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> with ValidationMixin {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Регистрация')),
      body: Form(
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
                inputAction: TextInputAction.next,
                keyboardType: TextInputType.emailAddress,
                validator: validateEmail,
              ),
              const SizedBox(height: Dimensions.unit2),
              AppTextFormField(
                controller: _passwordController,
                labelText: 'Пароль',
                inputAction: TextInputAction.next,
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
                validator: validatePassword,
              ),
              const SizedBox(height: Dimensions.unit2),
              AppTextFormField(
                controller: _confirmPasswordController,
                labelText: 'Подтвердите пароль',
                inputAction: TextInputAction.done,
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
                validator: (value) => validateConfirmPassword(
                  password: value,
                  confirmPassword: _confirmPasswordController.text,
                ),
              ),
              const SizedBox(height: Dimensions.unit2),
              BlocConsumer<AuthCubit, AuthState>(
                listener: _authListener,
                builder: (context, state) => _buildSignUpButton(state),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSignUpButton(AuthState state) {
    if (state.isLoading) {
      return const CircularProgressIndicator();
    } else {
      return AppButton(
        title: 'Зарегистрироваться',
        onPressed: _createAccount,
      );
    }
  }

  void _authListener(BuildContext context, AuthState state) {
    if (state is AuthError) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(state.message)));
    } else if (state is AuthLoaded) {
      context.replaceRoute(ProfileRoute());
    }
  }

  void _createAccount() {
    if (_formKey.currentState!.validate()) {
      final authParams = AuthParams(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      context.read<AuthCubit>().signUp(authParams);
    }
  }
}
