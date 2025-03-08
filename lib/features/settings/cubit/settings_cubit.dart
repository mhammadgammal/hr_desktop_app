import 'dart:developer';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  var selectedTabIndex = 0;

  String profilePicPath = '';

  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool isDarkMode = false;

  SettingsCubit() : super(SettingsInitial());

  static SettingsCubit get(context) => BlocProvider.of<SettingsCubit>(context);

  void changeTab(int index) {
    selectedTabIndex = index;
    emit(ChangeTabState(index));
  }

  Future<FilePickerResult?> _openPicker() async =>
      await FilePicker.platform.pickFiles();

  Future<void> pickProfilePic() async {
    final result = await _openPicker();
    if (result != null) {
      profilePicPath = result.files.single.path!;
      log('SettingsCubit: pickProfilePic: $profilePicPath');
      emit(EditProfilePicPickedState());
    }
  }
}
