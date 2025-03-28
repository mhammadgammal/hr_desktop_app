import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr/core/di/di.dart';
import 'package:hr/core/helpers/cache/cache_keys.dart';
import 'package:hr/core/helpers/cache/shared_preferences/cache_helper.dart';
import 'package:hr/core/helpers/database/db_helper.dart';
import 'package:hr/core/helpers/database/table_name.dart';
import 'package:hr/features/authentication/data/model/user_model.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit() : super(SignInInitial());

  static SignInCubit get(BuildContext context) =>
      BlocProvider.of<SignInCubit>(context);

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  var rememberMe = false;

  Future<void> signIn() async {
    emit(SignInLoadingState());
    var userResponse = await DbHelper.getRecordByEmail(
      emailController.text,
      tableName: TableName.userTable,
    );

    if (userResponse != null) {
      final UserModel user = UserModel.fromJson(userResponse);
      if (user.password == passwordController.text) {
        if (rememberMe) {
          sl<CacheHelper>().putBool(CacheKeys.isLogged, true);
        }
        emit(SignInSuccessState());
      } else {
        emit(SignInFailureState('Password is incorrect'));
      }
    } else {
      emit(SignInFailureState('User not found'));
    }
  }

  Future<void> createUser() async {
    final usersMap = await DbHelper.getData(
      TableName.userTable,
      UserModel.fromJson,
    );
    if (usersMap.isEmpty) {
      final user = UserModel(
        id: -1,
        name: 'hr',
        email: 'hr@admin.com',
        password: '123456789',
        profilePicturePath: '',
      );
      DbHelper.insertData(TableName.userTable, user.toJson());
    }
  }

  void changeRememberMe(bool? value) {
    if (value != null) {
      rememberMe = value;
      emit(RememberMeStatusChangedState(rememberMe));
    }
  }
}
