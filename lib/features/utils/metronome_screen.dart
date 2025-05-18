import 'package:audioplayers/audioplayers.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

@RoutePage()
class MetronomeScreen extends StatefulWidget {
  const MetronomeScreen({super.key});

  @override
  State<MetronomeScreen> createState() => _MetronomeScreenState();
}

class _MetronomeScreenState extends State<MetronomeScreen>
    with SingleTickerProviderStateMixin {
  final bpm = ValueNotifier<int>(150);
  final isPlaying = ValueNotifier<bool>(false);

  late final AudioPlayer _audioPlayer;
  late final Ticker _ticker;

  int _intervalMs = 400;
  int _lastTickMs = 0;

  @override
  void initState() {
    super.initState();

    _intervalMs = (60000 / bpm.value).round();

    _audioPlayer = AudioPlayer()
      ..setReleaseMode(ReleaseMode.stop)
      ..setSource(AssetSource('sounds/metronome_click_sound.mp3'));

    _ticker = Ticker(_onTick);

    bpm.addListener(() {
      _intervalMs = (60000 / bpm.value).round();
      if (isPlaying.value) {
        _stop();
        _start();
      }
    });
  }

  void _onTick(Duration elapsed) {
    final now = elapsed.inMilliseconds;
    if (now - _lastTickMs >= _intervalMs) {
      _lastTickMs = now;
      _audioPlayer.seek(Duration.zero);
      _audioPlayer.resume();
    }
  }

  void _start() {
    _lastTickMs = 0;
    _ticker.start();
    isPlaying.value = true;
  }

  void _stop() {
    _ticker.stop();
    isPlaying.value = false;
  }

  void _toggle() {
    isPlaying.value ? _stop() : _start();
  }

  void _updateBpm(double value) {
    bpm.value = value.round();
  }

  @override
  void dispose() {
    _ticker.dispose();
    _audioPlayer.dispose();
    isPlaying.dispose();
    bpm.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Метроном')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SizedBox(height: 24),
            const Text(
              'Частота ударов:',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 16),

            /// BPM отображение + слайдер
            ValueListenableBuilder<int>(
              valueListenable: bpm,
              builder: (context, bpmValue, _) {
                return Column(
                  children: [
                    Text(
                      '$bpmValue BPM',
                      style: const TextStyle(
                          fontSize: 36, fontWeight: FontWeight.bold),
                    ),
                    Slider(
                      value: bpmValue.toDouble(),
                      min: 140,
                      max: 210,
                      divisions: 200,
                      label: bpmValue.toString(),
                      onChanged: _updateBpm,
                    ),
                  ],
                );
              },
            ),

            const Spacer(),

            /// Кнопка Старт/Стоп
            ValueListenableBuilder<bool>(
              valueListenable: isPlaying,
              builder: (context, playing, _) {
                return ElevatedButton.icon(
                  onPressed: _toggle,
                  icon: Icon(playing ? Icons.stop : Icons.play_arrow),
                  label: Text(playing ? 'Стоп' : 'Старт'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 16),
                    textStyle: const TextStyle(fontSize: 18),
                  ),
                );
              },
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
