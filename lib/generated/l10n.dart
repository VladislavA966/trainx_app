// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name =
        (locale.countryCode?.isEmpty ?? false)
            ? locale.languageCode
            : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Тренировки`
  String get workouts {
    return Intl.message('Тренировки', name: 'workouts', desc: '', args: []);
  }

  /// `Упражнения`
  String get exercises {
    return Intl.message('Упражнения', name: 'exercises', desc: '', args: []);
  }

  /// `Инструменты`
  String get widgets {
    return Intl.message('Инструменты', name: 'widgets', desc: '', args: []);
  }

  /// `Профиль`
  String get profile {
    return Intl.message('Профиль', name: 'profile', desc: '', args: []);
  }

  /// `Все тренировки`
  String get allWorkouts {
    return Intl.message(
      'Все тренировки',
      name: 'allWorkouts',
      desc: '',
      args: [],
    );
  }

  /// `Фильтры`
  String get filters {
    return Intl.message('Фильтры', name: 'filters', desc: '', args: []);
  }

  /// `Плавание`
  String get swimming {
    return Intl.message('Плавание', name: 'swimming', desc: '', args: []);
  }

  /// `Велосипед`
  String get cycling {
    return Intl.message('Велосипед', name: 'cycling', desc: '', args: []);
  }

  /// `Бег`
  String get running {
    return Intl.message('Бег', name: 'running', desc: '', args: []);
  }

  /// `Детали тренировки`
  String get workoutDetails {
    return Intl.message(
      'Детали тренировки',
      name: 'workoutDetails',
      desc: '',
      args: [],
    );
  }

  /// `Выберите вид спорта`
  String get selectSportType {
    return Intl.message(
      'Выберите вид спорта',
      name: 'selectSportType',
      desc: '',
      args: [],
    );
  }

  /// `Пульсовые зоны`
  String get hrZones {
    return Intl.message('Пульсовые зоны', name: 'hrZones', desc: '', args: []);
  }

  /// `Метроном`
  String get metronome {
    return Intl.message('Метроном', name: 'metronome', desc: '', args: []);
  }

  /// `Калькулятор: дистанция/темп`
  String get calcDistPeace {
    return Intl.message(
      'Калькулятор: дистанция/темп',
      name: 'calcDistPeace',
      desc: '',
      args: [],
    );
  }

  /// `Калькулятор: темп/скорость`
  String get calcPeaceSpeed {
    return Intl.message(
      'Калькулятор: темп/скорость',
      name: 'calcPeaceSpeed',
      desc: '',
      args: [],
    );
  }

  /// `тренер`
  String get coach {
    return Intl.message('тренер', name: 'coach', desc: '', args: []);
  }

  /// `Выберите дистанцию`
  String get select_distance {
    return Intl.message(
      'Выберите дистанцию',
      name: 'select_distance',
      desc: '',
      args: [],
    );
  }

  /// `Время`
  String get common_time {
    return Intl.message('Время', name: 'common_time', desc: '', args: []);
  }

  /// `Что вы хотите ввести:`
  String get common_input_question {
    return Intl.message(
      'Что вы хотите ввести:',
      name: 'common_input_question',
      desc: '',
      args: [],
    );
  }

  /// `Темп`
  String get common_pace {
    return Intl.message('Темп', name: 'common_pace', desc: '', args: []);
  }

  /// `Введите время (чч:мм:сс)`
  String get input_time_hh_mm_ss {
    return Intl.message(
      'Введите время (чч:мм:сс)',
      name: 'input_time_hh_mm_ss',
      desc: '',
      args: [],
    );
  }

  /// `Введите темп (мин/км)`
  String get input_running_pace {
    return Intl.message(
      'Введите темп (мин/км)',
      name: 'input_running_pace',
      desc: '',
      args: [],
    );
  }

  /// `Расчитать`
  String get common_calculate {
    return Intl.message(
      'Расчитать',
      name: 'common_calculate',
      desc: '',
      args: [],
    );
  }

  /// `Отмена`
  String get common_cancel {
    return Intl.message('Отмена', name: 'common_cancel', desc: '', args: []);
  }

  /// `Готово`
  String get common_ready {
    return Intl.message('Готово', name: 'common_ready', desc: '', args: []);
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ru'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
