import 'package:trainx_app/core/utils/app_modal.dart';

abstract class PickerConfig {
  String get title;
  List<AppCupertinoPicker> buildPickers({
    required void Function(int index, int value) onItemChanged,
  });

  void onReady(List<int> selectedValues);

  List<int> getInitialValues();
}
