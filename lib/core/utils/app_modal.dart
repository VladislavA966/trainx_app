import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
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
}
