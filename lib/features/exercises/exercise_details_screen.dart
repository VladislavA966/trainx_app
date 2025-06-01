import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:trainx_app/core/recources/dimensions.dart';
import 'package:trainx_app/features/ui_kit/export.dart';

//TODO: Вынести локализацию
//TODO: Полный рефакторинг

@RoutePage()
class ExerciseDetailsScreen extends StatefulWidget {
  const ExerciseDetailsScreen({super.key});

  @override
  State<ExerciseDetailsScreen> createState() => _ExerciseDetailsScreenState();
}

class _ExerciseDetailsScreenState extends State<ExerciseDetailsScreen> {
  late final YoutubePlayerController _youTubePlayerController;

  @override
  void initState() {
    super.initState();
    _youTubePlayerController = YoutubePlayerController(
      initialVideoId: '7pb-rn8F6oM',
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
        showLiveFullscreenButton: false,
      ),
    );
  }

  @override
  void dispose() {
    _youTubePlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      player: YoutubePlayer(controller: _youTubePlayerController),
      builder: (context, player) => Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: const Text('Детали упражнения'),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: Dimensions.unit,
            vertical: Dimensions.unit1_5,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              player,
              const SizedBox(height: Dimensions.unit1_5),

              /// Название
              Text(
                'Бег на дорожке 10 мин',
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: Dimensions.unit1_5),

              /// Информация
              _ExerciseInfoCard(
                level: 'Средний',
                type: 'Кардио',
                duration: '10 мин',
                equipment: 'Беговая дорожка',
              ),
              const SizedBox(height: Dimensions.unit1_5),

              /// Описание
              _SectionTitle(title: 'Описание'),
              const AppBaseCard(
                child: Text(
                  'Это упражнение направлено на развитие общей выносливости и улучшение техники бега. '
                  'Темп умеренный, следите за дыханием и положением тела.',
                ),
              ),
              const SizedBox(height: Dimensions.unit1_5),

              /// Рекомендации
              _SectionTitle(title: 'Рекомендации'),
              const AppBaseCard(
                child: Text(
                  '• Не держитесь за поручни\n'
                  '• Поддерживайте ровное дыхание\n'
                  '• Начинайте с разминки\n'
                  '• Следите за положением спины и приземлением стопы',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ExerciseInfoCard extends StatelessWidget {
  final String level;
  final String type;
  final String duration;
  final String equipment;

  const _ExerciseInfoCard({
    required this.level,
    required this.type,
    required this.duration,
    required this.equipment,
  });

  @override
  Widget build(BuildContext context) {
    return AppBaseCard(
      height: 120,
      child: Padding(
        padding: const EdgeInsets.all(Dimensions.unit0_5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _IconColumn(
              items: [
                _IconAndText(icon: Icons.timer, text: duration),
                _IconAndText(icon: Icons.fitness_center, text: equipment),
              ],
            ),
            _IconColumn(
              items: [
                _IconAndText(icon: Icons.flag, text: level),
                _IconAndText(icon: Icons.directions_run, text: type),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _IconColumn extends StatelessWidget {
  final List<_IconAndText> items;

  const _IconColumn({required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: items,
    );
  }
}

class _IconAndText extends StatelessWidget {
  final IconData icon;
  final String text;

  const _IconAndText({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 20),
        const SizedBox(width: Dimensions.unit),
        Text(
          text,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ],
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: Dimensions.unit),
      child: Text(
        title,
        style:
            Theme.of(context).textTheme.headlineLarge?.copyWith(fontSize: 18),
      ),
    );
  }
}
