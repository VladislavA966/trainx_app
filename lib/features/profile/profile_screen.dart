import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trainx_app/core/recources/app_colors.dart';
import 'package:trainx_app/features/workouts/presentation/screens/workout_types_screen.dart';
import 'package:trainx_app/features/auth/presentation/cubit/auth_cubit.dart';

@RoutePage()
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app_outlined),
            onPressed: () {},
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "ASDASDADADASDASDASD",
              style: TextStyle(color: AppColors.white),
            ),
            AppButton(
              title: 'Log out',
              onPressed: () {
                context.read<AuthCubit>().logOut();
              },
            ),
          ],
        ),
      ),
    );
  }
}
