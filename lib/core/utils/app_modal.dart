import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trainx_app/core/recources/app_colors.dart';
import 'package:trainx_app/core/utils/params_filter_type.dart';
import '../recources/dimensions.dart';

mixin AppModal {
  Future<dynamic> showMaterialModal(
    BuildContext context, {
    required Widget Function(BuildContext context) builder,
    ShapeBorder? shape,
  }) {
    return showModalBottomSheet(
      backgroundColor: Theme.of(context).secondaryHeaderColor,
      useRootNavigator: true,
      shape: shape ??
          const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(Dimensions.unit2),
            ),
          ),
      context: context,
      builder: builder,
    );
  }

  void showEnumSelectModal<T extends ParamsWorkoutType>(
    BuildContext context, {
    required List<T> values,
    required void Function(T value) onSelect,
    String? title,
  }) {
    showMaterialModal(
      context,
      builder: (context) => Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Dimensions.unit1_5,
          vertical: Dimensions.unit,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: Dimensions.unit),
            if (title != null)
              Row(
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style:
                          Theme.of(context).textTheme.headlineMedium?.copyWith(
                                color: Theme.of(context).cardColor,
                              ),
                    ),
                  ),
                  GestureDetector(
                    onTap: context.pop,
                    child: const Icon(Icons.close),
                  ),
                ],
              ),
            const SizedBox(height: Dimensions.unit1_5),
            ...values.map(
              (item) => ListTile(
                title: Text(
                  item.title(context),
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                leading: Icon(
                  item.icon(),
                  color: Theme.of(context).primaryColor,
                ),
                onTap: () {
                  context.pop();
                  onSelect(item);
                },
              ),
            ),
            SizedBox(height: Dimensions.unit2),
          ],
        ),
      ),
    );
  }

  void showListSelectModal<T>(
    BuildContext context, {
    required List<T> values,
    required String Function(T item) titleBuilder,
    IconData? Function(T item)? iconBuilder,
    required void Function(T value) onSelect,
    String? title,
  }) {
    showMaterialModal(
      context,
      builder: (context) => Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Dimensions.unit1_5,
          vertical: Dimensions.unit,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: Dimensions.unit),
            if (title != null)
              Row(
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style:
                          Theme.of(context).textTheme.headlineMedium?.copyWith(
                                color: Theme.of(context).cardColor,
                              ),
                    ),
                  ),
                  GestureDetector(
                    onTap: context.pop,
                    child: const Icon(Icons.close),
                  ),
                ],
              ),
            const SizedBox(height: Dimensions.unit1_5),
            ...values.map(
              (item) => ListTile(
                title: Text(
                  titleBuilder(item),
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                leading: iconBuilder != null
                    ? Icon(iconBuilder(item),
                        color: Theme.of(context).primaryColor)
                    : null,
                onTap: () {
                  context.pop();
                  onSelect(item);
                },
              ),
            ),
            const SizedBox(height: Dimensions.unit2),
          ],
        ),
      ),
    );
  }

  void showPacePicker(
    BuildContext context, {
    required int selectedMinutes,
    required int selectedSeconds,
    VoidCallback? onReady,
    VoidCallback? onCancel,
  }) {
    final theme = Theme.of(context);

    showMaterialModal(
      context,
      builder: (context) => Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Dimensions.unit1_5,
          vertical: Dimensions.unit,
        ),
        child: SizedBox(
          height: 250,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: Dimensions.unit),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Выберите темп',
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium
                          ?.copyWith(color: AppColors.primary),
                    ),
                  ),
                  GestureDetector(
                    onTap: context.pop,
                    child: const Icon(Icons.close, color: AppColors.greyLight),
                  ),
                ],
              ),
              const SizedBox(height: Dimensions.unit),
              Row(
                children: [
                  AppCupertinoPicker(
                    onSelectedItemChanged: (value) {},
                    children: List.generate(
                      60,
                      (i) => Text(
                        '${i.toString().padLeft(2, '0')} мин',
                        style: theme.textTheme.titleLarge
                            ?.copyWith(color: AppColors.white),
                      ),
                    ),
                  ),
                  AppCupertinoPicker(
                    onSelectedItemChanged: (value) {},
                    children: List.generate(
                      60,
                      (i) => Text(
                        '${i.toString().padLeft(2, '0')} сек',
                        style: theme.textTheme.titleLarge
                            ?.copyWith(color: AppColors.white),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  TextButton(
                    onPressed: onCancel ?? context.pop,
                    child: Text(
                      'Отмена',
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: AppColors.greyLight,
                      ),
                    ),
                  ),
                  const Spacer(),
                  TextButton(
                    child: Text(
                      'Готово',
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                    onPressed: () {
                      onReady?.call();
                      context.pop();
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AppCupertinoPicker extends StatelessWidget {
  final int selectedMinutes;
  final Function(int value)? onSelectedItemChanged;
  final List<Widget> children;

  const AppCupertinoPicker({
    super.key,
    required this.children,
    required this.onSelectedItemChanged,
    this.selectedMinutes = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        height: 150,
        child: CupertinoPicker(
          scrollController:
              FixedExtentScrollController(initialItem: selectedMinutes),
          itemExtent: 32,
          looping: true,
          onSelectedItemChanged: onSelectedItemChanged,
          children: children,
        ),
      ),
    );
  }
}
