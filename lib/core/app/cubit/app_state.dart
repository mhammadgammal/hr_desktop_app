part of 'app_cubit.dart';

sealed class AppState extends Equatable {
  const AppState();

  @override
  List<Object?> get props => [];
}

final class AppInitial extends AppState {}

final class AppLanguageChanged extends AppState {
  final Locale locale;

  const AppLanguageChanged(this.locale);

  @override
  List<Object?> get props => [locale];
}

final class AppThemeChanged extends AppState {
  final bool isDarkMode;

  const AppThemeChanged(this.isDarkMode);

  @override
  List<Object?> get props => [isDarkMode];
}
