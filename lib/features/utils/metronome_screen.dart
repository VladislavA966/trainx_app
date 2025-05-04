import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class MetronomeScreen extends StatefulWidget {
  const MetronomeScreen({super.key});

  @override
  State<MetronomeScreen> createState() => _MetronomeScreenState();
}

class _MetronomeScreenState extends State<MetronomeScreen> {
  int bpm = 150;
  Timer? _timer;

  final isPlaying = ValueNotifier<bool>(false);
  final _audioPlayer = AudioPlayer();

  void _start() {
    final interval = Duration(milliseconds: (60000 / bpm).round());
    _timer = Timer.periodic(interval, (_) {
      _audioPlayer.play(AssetSource('sounds/metronome_click_sound.mp3'));
    });

    isPlaying.value = true;
  }

  void _stop() {
    _timer?.cancel();
    isPlaying.value = false;
  }

  void _toggle() {
    isPlaying.value ? _stop() : _start();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _audioPlayer.dispose();
    isPlaying.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Метроном')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text(
              'Частота ударов:',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 16),
            Text(
              '$bpm BPM',
              style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            Slider(
              value: bpm.toDouble(),
              min: 150,
              max: 220,
              divisions: 200,
              label: bpm.toString(),
              onChanged: (value) {
                setState(() {
                  bpm = value.round();
                  if (isPlaying.value) {
                    _stop();
                    _start();
                  }
                });
              },
            ),
            const SizedBox(height: 40),
            ValueListenableBuilder(
              valueListenable: isPlaying,
              builder: (context, value, child) {
                return ElevatedButton.icon(
                  onPressed: _toggle,
                  icon: Icon(value ? Icons.stop : Icons.play_arrow),
                  label: Text(value ? 'Стоп' : 'Старт'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 16),
                    textStyle: const TextStyle(fontSize: 18),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
