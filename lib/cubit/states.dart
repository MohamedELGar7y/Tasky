import 'package:tasky/Models/ProfileModel.dart';
import 'package:tasky/Models/RefreshTokenModel.dart';

import '../Models/GetOneModel.dart';
import '../Models/SignInModel.dart';
import '../Models/SignUpModel.dart';

abstract class AppStates {}

class HomeLayoutInitialState extends AppStates {}

class SignUpPasswordVisibilityState extends AppStates {}

class ChangeIndexState extends AppStates {}

class SignInPasswordVisibilityState extends AppStates {}

class SignUpLoadingState extends AppStates {}

class SignUpSuccessState extends AppStates {
  final SignUpModel signUpModel;
  SignUpSuccessState(this.signUpModel);
}

class SignUpErrorState extends AppStates {
  final String error;
  SignUpErrorState(this.error);
}

class SignInLoadingState extends AppStates {}

class SignInSuccessState extends AppStates {
  final SignInModel signInModel;
  SignInSuccessState(this.signInModel);
}

class SignInErrorState extends AppStates {
  final String error;
  SignInErrorState(this.error);
}

class GetProfileLoadingState extends AppStates {}

class GetProfileSuccessState extends AppStates {
  final ProfileModel profileModel;
  GetProfileSuccessState(this.profileModel);
}

class GetProfileErrorState extends AppStates {
  final String error;
  GetProfileErrorState(this.error);
}

class RefreshTokenLoadingState extends AppStates {}

class RefreshTokenSuccessState extends AppStates {
  final RefreshTokenModel refreshTokenModel;
  RefreshTokenSuccessState(this.refreshTokenModel);
}

class RefreshTokenErrorState extends AppStates {
  final String error;
  RefreshTokenErrorState(this.error);
}

class GetHomeLoadingState extends AppStates {}

class GetHomeSuccessState extends AppStates {}

class GetHomeErrorState extends AppStates {
  final String error;
  GetHomeErrorState(this.error);
}

class UploadLoadingState extends AppStates {}

class UploadSuccessState extends AppStates {}

class UploadErrorState extends AppStates {
  final String error;
  UploadErrorState(this.error);
}

class CreateTodoLoadingState extends AppStates {}

class CreateTodoSuccessState extends AppStates {}

class CreateTodoErrorState extends AppStates {
  final String error;
  CreateTodoErrorState(this.error);
}

class GetTodoLoadingState extends AppStates {}

class GetTodoSuccessState extends AppStates {
  final GetOneModel getOneModel;
  GetTodoSuccessState(this.getOneModel);
}

class GetTodoErrorState extends AppStates {
  final String error;
  GetTodoErrorState(this.error);
}

class DeleteTodoLoadingState extends AppStates {}

class DeleteTodoSuccessState extends AppStates {}

class DeleteTodoErrorState extends AppStates {
  final String error;
  DeleteTodoErrorState(this.error);
}

class UpdateTodoLoadingState extends AppStates {}

class UpdateTodoSuccessState extends AppStates {}

class UpdateTodoErrorState extends AppStates {
  final String error;
  UpdateTodoErrorState(this.error);
}
