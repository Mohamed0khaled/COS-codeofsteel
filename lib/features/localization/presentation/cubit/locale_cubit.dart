import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/locale_entity.dart';
import '../../domain/usecases/get_locale.dart';
import '../../domain/usecases/save_locale.dart';
import '../../domain/usecases/toggle_locale.dart';
import 'locale_state.dart';

class LocaleCubit extends Cubit<LocaleState> {
  final GetLocale getLocale;
  final SaveLocale saveLocale;
  final ToggleLocale toggleLocaleUseCase;

  LocaleCubit({
    required this.getLocale,
    required this.saveLocale,
    required this.toggleLocaleUseCase,
  }) : super(LocaleLoaded(localeEntity: LocaleEntity.defaults()));

  /// Load locale from storage
  void loadLocale() {
    final result = getLocale();
    result.fold(
      (failure) => emit(LocaleError(message: failure.message)),
      (locale) => emit(LocaleLoaded(localeEntity: locale)),
    );
  }

  /// Toggle between Arabic and English
  Future<void> toggleLocale() async {
    final result = await toggleLocaleUseCase();
    result.fold(
      (failure) => emit(LocaleError(message: failure.message)),
      (locale) => emit(LocaleLoaded(localeEntity: locale)),
    );
  }

  /// Set specific language
  Future<void> setLanguage(String languageCode) async {
    final result = await saveLocale(languageCode);
    result.fold(
      (failure) => emit(LocaleError(message: failure.message)),
      (_) => emit(LocaleLoaded(localeEntity: LocaleEntity.fromLanguageCode(languageCode))),
    );
  }

  /// Set Arabic language
  Future<void> setArabic() async {
    await setLanguage('ar');
  }

  /// Set English language
  Future<void> setEnglish() async {
    await setLanguage('en');
  }
}
