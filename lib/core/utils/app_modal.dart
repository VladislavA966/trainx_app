import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trainx_app/core/recources/app_colors.dart';
import 'package:trainx_app/core/utils/params_filter_type.dart';
import 'package:trainx_app/features/widgets/app_picker_strategy/picker_config.dart';
import 'package:trainx_app/generated/l10n.dart';
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

  void showCustomPicker(
    BuildContext context, {
    required PickerConfig config,
    VoidCallback? onCancel,
  }) {
    final initialValues = config.getInitialValues();
    showMaterialModal(
      context,
      builder: (context) => CommonCupertinoPickerSkeleton(
        title: config.title,
        onReady: () => config.onReady(initialValues),
        onCancel: onCancel,
        children: config.buildPickers(
          onItemChanged: (index, value) => initialValues[index] = value,
        ),
      ),
    );
  }
}

class CommonCupertinoPickerSkeleton extends StatefulWidget {
  final List<AppCupertinoPicker> children;
  final String? title;
  final VoidCallback? onReady;
  final VoidCallback? onCancel;
  const CommonCupertinoPickerSkeleton({
    required this.children,
    this.title,
    super.key,
    this.onReady,
    this.onCancel,
  });

  @override
  State<CommonCupertinoPickerSkeleton> createState() =>
      _CommonCupertinoPickerSkeletonState();
}

class _CommonCupertinoPickerSkeletonState
    extends State<CommonCupertinoPickerSkeleton> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Dimensions.unit1_5,
        vertical: Dimensions.unit,
      ),
      child: SizedBox(
        height: 260,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: Dimensions.unit),
            Row(
              children: [
                Expanded(
                  child: Text(
                    widget.title ?? '',
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
            Row(children: widget.children),
            Row(
              children: [
                TextButton(
                  onPressed: widget.onCancel ?? context.pop,
                  child: Text(
                    S.of(context).common_cancel,
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: AppColors.greyLight,
                    ),
                  ),
                ),
                const Spacer(),
                TextButton(
                  child: Text(
                    S.of(context).common_ready,
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                  onPressed: () {
                    widget.onReady?.call();
                    context.pop();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class AppCupertinoPicker extends StatelessWidget {
  final int selectedValue;
  final Function(int value)? onSelectedItemChanged;
  final int count;
  final String? unit;

  const AppCupertinoPicker({
    required this.onSelectedItemChanged,
    required this.count,
    required this.unit,
    this.selectedValue = 0,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Expanded(
      child: SizedBox(
        height: 150,
        child: CupertinoPicker(
          scrollController:
              FixedExtentScrollController(initialItem: selectedValue),
          itemExtent: 32,
          looping: true,
          onSelectedItemChanged: onSelectedItemChanged,
          children: List.generate(
            count,
            (i) => Text(
              '${i.toString().padLeft(2, '0')} $unit',
              style:
                  theme.textTheme.titleLarge?.copyWith(color: AppColors.white),
            ),
          ),
        ),
      ),
    );
  }
}
