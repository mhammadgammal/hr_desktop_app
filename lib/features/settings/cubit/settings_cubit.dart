import 'dart:developer';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr/core/helpers/database/db_helper.dart';
import 'package:hr/core/helpers/database/table_name.dart';
import 'package:hr/features/authentication/data/model/user_model.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  var selectedTabIndex = 0;

  String profilePicPath = '';
  UserModel? user;
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

  Future<void> getUserData() async {
    final allUsers = await DbHelper.getAll(TableName.userTable);
    user = UserModel.fromJson(allUsers[0]);
    profilePicPath = user?.profilePicturePath ?? '';
    emit(CurrentUserDataLoadedState());
  }

  Future<void> updatePassword() async {
    if (currentPasswordController.text == user?.password) {
      if (newPasswordController.text == confirmPasswordController.text) {
        final tmpUser = UserModel(
          id: user!.id,
          name: user!.name,
          email: user!.email,
          password: newPasswordController.text,
          profilePicturePath: user!.profilePicturePath,
        );

        await DbHelper.updateData(TableName.userTable, tmpUser.toJson(), 'id', [
          user!.id,
        ]);
        emit(UserPasswordUpdateSuccess());
      }
    }
  }

  updateProfilePic() async {
    final tmpUser = UserModel(
      id: user!.id,
      name: user!.name,
      email: user!.email,
      password: user!.password,
      profilePicturePath: profilePicPath,
    );

    await DbHelper.updateData(TableName.userTable, tmpUser.toJson(), 'id', [
      user!.id,
    ]);
    emit(UserProfilePicSuccess());
  }
}
