import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trainx_app/features/widgets/export.dart';

@RoutePage()
class PaceSpeedScreen extends StatefulWidget {
  const PaceSpeedScreen({super.key});

  @override
  State<PaceSpeedScreen> createState() => _PaceSpeedScreenState();
}

class _PaceSpeedScreenState extends State<PaceSpeedScreen> {
  final _paceController = TextEditingController();
  final _speedController = TextEditingController();
  bool _updating = false;

  @override
  void initState() {
    super.initState();

    _paceController.addListener(() {
      if (_updating) return;
      final paceText = _paceController.text;
      if (paceText.contains(':')) {
        try {
          final paceMinutes = _paceToMinutes(paceText);
          if (paceMinutes == 0) return;
          final speed = 60 / paceMinutes;
          _updating = true;
          _speedController.text = speed.toStringAsFixed(2);
          _updating = false;
        } catch (_) {}
      }
    });

    _speedController.addListener(() {
      if (_updating) return;
      final speedText = _speedController.text;
      final speed = double.tryParse(speedText);
      if (speed != null && speed > 0) {
        final paceMinutes = 60 / speed;
        final paceString = _minutesToPace(paceMinutes);
        _updating = true;
        _paceController.text = paceString;
        _updating = false;
      }
    });
  }

  double _paceToMinutes(String pace) {
    final parts = pace.split(':');
    final minutes = int.parse(parts[0]);
    final seconds = int.parse(parts[1]);
    return minutes + (seconds / 60.0);
  }

  String _minutesToPace(double minutes) {
    final wholeMinutes = minutes.floor();
    final seconds = ((minutes - wholeMinutes) * 60).round();
    return '${wholeMinutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    _paceController.dispose();
    _speedController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Pace/Speed Calculator')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            AppTextFormField(
              controller: _paceController,
              labelText: 'Темп (мин:сек на км)',
              keyboardType: TextInputType.number,
              inputFormatter: [
                MinutesSecondsFormatter(),
              ],
            ),
            SizedBox(height: 16),
            AppTextFormField(
              controller: _speedController,
              keyboardType: TextInputType.number,
              labelText: 'Скорость (км/ч)',
              inputFormatter: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class MinutesSecondsFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final digitsOnly = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');

    if (digitsOnly.isEmpty) {
      return newValue.copyWith(text: '');
    }

    final limited =
        digitsOnly.length > 4 ? digitsOnly.substring(0, 4) : digitsOnly;

    int minutes = 0;
    int seconds = 0;

    if (limited.length <= 2) {
      seconds = int.parse(limited);
    } else {
      minutes = int.parse(limited.substring(0, limited.length - 2));
      seconds = int.parse(limited.substring(limited.length - 2));
    }

    if (seconds >= 60) {
      minutes += seconds ~/ 60;
      seconds %= 60;
    }

    final formatted = '$minutes:${seconds.toString().padLeft(2, '0')}';

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}
