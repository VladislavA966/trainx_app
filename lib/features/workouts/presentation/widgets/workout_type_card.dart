import 'package:flutter/material.dart';
import 'package:trainx_app/core/recources/dimensions.dart';

class WorkOutTypeCard extends StatelessWidget {
  final String title;
  final String imagePath;
  final VoidCallback onTap;

  const WorkOutTypeCard({
    super.key,
    required this.title,
    required this.imagePath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 200,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.unit2),
        ),
        clipBehavior: Clip.hardEdge,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              imagePath,
              fit: BoxFit.cover,
              color: Colors.black.withOpacity(.2),
              colorBlendMode: BlendMode.darken,
            ),
            Padding(
              padding: const EdgeInsets.all(Dimensions.unit2),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  title,
                  style: Theme.of(context).appBarTheme.titleTextStyle,
                ),
              ),
            ),
            const Positioned(
              right: Dimensions.unit2,
              bottom: Dimensions.unit2,
              child: Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
                size: Dimensions.unit2_5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
