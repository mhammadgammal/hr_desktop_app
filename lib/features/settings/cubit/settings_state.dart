part of 'settings_cubit.dart';

@immutable
sealed class SettingsState {}

final class SettingsInitial extends SettingsState {}

final class EditProfilePicPickedState extends SettingsState {}

final class ChangeTabState extends SettingsState {
  final int index;

  ChangeTabState(this.index);
}
