import 'package:equatable/equatable.dart';
import 'dart:ui' show Locale;
import '../../domain/entities/locale_entity.dart';

/// Base state for Localization
abstract class LocaleState extends Equatable {
  const LocaleState();
  
  @override
  List<Object?> get props => [];
}

/// Locale loaded successfully
class LocaleLoaded extends LocaleState {
  final LocaleEntity localeEntity;

  const LocaleLoaded({required this.localeEntity});

  /// Convenience getter for languageCode
  String get languageCode => localeEntity.languageCode;

  /// Convenience getter for locale
  Locale get locale => localeEntity.locale;

  /// Convenience getter for isRTL
  bool get isRTL => localeEntity.isRTL;

  /// Convenience getter for isArabic
  bool get isArabic => localeEntity.isArabic;

  @override
  List<Object?> get props => [localeEntity];
}

/// Locale error state
class LocaleError extends LocaleState {
  final String message;

  const LocaleError({required this.message});

  @override
  List<Object?> get props => [message];
}
