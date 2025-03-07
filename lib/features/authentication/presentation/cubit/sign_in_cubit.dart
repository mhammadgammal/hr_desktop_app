import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

  Future<void> signIn() async {
    emit(SignInLoadingState());
    var userResponse = await DbHelper.getRecordByEmail(
      emailController.text,
      tableName: TableName.userTable,
    );
    final UserModel? user = UserModel.fromJson(userResponse);
    if (user != null) {
      if (user.password == passwordController.text) {
        emit(SignInSuccessState());
      } else {
        emit(SignInFailureState('Password is incorrect'));
      }
    } else {
      emit(SignInFailureState('User not found'));
    }
  }

  Future<void> createUser() async {
    final user = UserModel(
      id: -1,
      name: 'Mohamed Gamal',
      email: 'mohamed@gmail.com',
      password: '123456789',
      profilePicturePath: '',
    );
    DbHelper.insertData(TableName.userTable, user.toJson());
  }
}
