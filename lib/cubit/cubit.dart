import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tasky/Models/GetOneModel.dart';
import 'package:tasky/Models/ProfileModel.dart';
import '../../shared/network/local/cache_helper.dart';
import 'package:tasky/cubit/states.dart';
import '../Models/RefreshTokenModel.dart';
import '../Models/SignInModel.dart';
import '../Models/SignUpModel.dart';
import '../Models/UploadModel.dart';
import '../Shared/network/remote/dio_helper.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(HomeLayoutInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  int indexx = 0;
  String statuss = "all";
  void changeIndex({
    required int index,
    required String status,
  }) {
    indexx = index;
    statuss = status;
    emit(ChangeIndexState());
  }

  IconData signUpSuffix = Icons.visibility_off_outlined;
  bool isPasswordSignUp = true;
  void signUpPasswordVisibility() {
    isPasswordSignUp = !isPasswordSignUp;
    signUpSuffix = isPasswordSignUp
        ? Icons.visibility_off_outlined
        : Icons.visibility_outlined;
    emit(SignUpPasswordVisibilityState());
  }

  IconData signInSuffix = Icons.visibility_off_outlined;
  bool isPasswordSignIn = true;
  void signInPasswordVisibility() {
    isPasswordSignIn = !isPasswordSignIn;
    signInSuffix = isPasswordSignIn
        ? Icons.visibility_off_outlined
        : Icons.visibility_outlined;
    emit(SignInPasswordVisibilityState());
  }

  SignUpModel? signUpModel;
  int? signUpStatusCode;
  void signUp({
    required String phone,
    required String password,
    required String displayName,
    required String experienceYears,
    required String address,
    required String level,
  }) {
    emit(SignUpLoadingState());
    DioHelper.postData(url: "auth/register", data: {
      "phone": phone,
      "password": password,
      "displayName": displayName,
      "experienceYears": experienceYears,
      "address": address,
      "level": level,
    }).then((value) {
      signUpModel = SignUpModel.fromJson(value!.data);
      signUpStatusCode = value.statusCode;
      print(value.data);
      emit(SignUpSuccessState(signUpModel!));
    }).catchError((error) {
      emit(SignUpErrorState(error.toString()));
      print(error.toString());
    });
  }

  SignInModel? signInModel;
  int? signInStatusCode;
  void signIn({
    required String phone,
    required String password,
  }) {
    emit(SignInLoadingState());
    DioHelper.postData(url: "auth/login", data: {
      "phone": phone,
      "password": password,
    }).then((value) {
      signInModel = SignInModel.fromJson(value!.data);
      print(value.data);
      signInStatusCode = value.statusCode;
      emit(SignInSuccessState(signInModel!));
    }).catchError((error) {
      emit(SignInErrorState(error.toString()));
      print(error.toString());
    });
  }

  ProfileModel? profileModel;
  void getProfile() async {
    emit(GetProfileLoadingState());
    DioHelper.getData(
      url: "auth/profile",
      token: await CacheHelper.getData(key: "token"),
    ).then((value) {
      profileModel = ProfileModel.fromJson(value!.data);
      emit(GetProfileSuccessState(profileModel!));
    }).catchError((error) {
      emit(GetProfileErrorState(error.toString()));
      print(error.toString());
    });
  }

  RefreshTokenModel? refreshTokenModel;
  void refreshToken() async {
    emit(RefreshTokenLoadingState());
    DioHelper.getData(
      url: "auth/refresh-token",
      query: {
        "token": await CacheHelper.getData(
          key: "refreshToken",
        )
      },
    ).then((value) {
      refreshTokenModel = RefreshTokenModel.fromJson(value!.data);
      emit(RefreshTokenSuccessState(refreshTokenModel!));
    }).catchError((error) {
      emit(RefreshTokenErrorState(error.toString()));
      print(error.toString());
    });
  }

  var homeData;
  void getHome() async {
    emit(GetHomeLoadingState());
    DioHelper.getData(
      url: "todos",
      token: await CacheHelper.getData(key: "token"),
    ).then((value) {
      homeData = value!.data;
      emit(GetHomeSuccessState());
    }).catchError((error) {
      emit(GetHomeErrorState(error.toString()));
      print(error.toString());
    });
  }

  UploadModel? uploadModel;
  Future<void> upload({
    XFile? image,
  }) async {
    emit(UploadLoadingState());
    Dio dio = Dio();
    String token = CacheHelper.getData(key: 'token');
    String? fileName = image != null ? image.path.split('/').last : null;
    FormData formData = FormData.fromMap({
      "image": image != null
          ? await MultipartFile.fromFile(
              image.path,
              filename: fileName,
              contentType: MediaType("image", "jpeg"),
            )
          : null,
    });
    await dio.post(
      "https://todo.iraqsapp.com/upload/image",
      data: formData,
      options: Options(headers: {
        "Authorization": "Bearer $token",
      }),
      queryParameters: {
        'Content-Type':
            'multipart/form-data; boundary=<calculated when request is sent>',
        'Content-Length': '<calculated when request is sent>',
        'Host': '<calculated when request is sent>',
      },
    ).then((value) {
      print(value.data);
      uploadModel = UploadModel.fromJson(value.data);
      emit(UploadSuccessState());
    }).catchError((error) {
      emit(UploadErrorState(error.toString()));
      print(error);
    });
  }

  void createTodo({
    String? title,
    String? desc,
    String? priority,
    String? dueDate,
  }) async {
    emit(CreateTodoLoadingState());
    DioHelper.postData(
        url: "todos",
        token: await CacheHelper.getData(key: "token"),
        data: {
          "image": uploadModel!.image!,
          "title": title,
          "desc": desc,
          "priority": priority,
          "dueDate": dueDate,
        }).then((value) {
      print(value!.data);
      emit(CreateTodoSuccessState());
    }).catchError((error) {
      emit(CreateTodoErrorState(error.toString()));
      print(error.toString());
    });
  }

  GetOneModel? getOneModel;
  void getOne({
    required String id,
  }) async {
    emit(GetTodoLoadingState());
    DioHelper.getData(
      url: "todos/$id",
      token: await CacheHelper.getData(key: "token"),
    ).then((value) {
      print(value!.data);
      getOneModel = GetOneModel.fromJson(value.data);
      emit(GetTodoSuccessState(getOneModel!));
    }).catchError((error) {
      emit(GetTodoErrorState(error.toString()));
      print(error.toString());
    });
  }

  void deleteOne({
    required String id,
  }) async {
    emit(DeleteTodoLoadingState());
    DioHelper.deleteData(
      url: "todos/$id",
      token: await CacheHelper.getData(key: "token"),
    ).then((value) {
      emit(DeleteTodoSuccessState());
    }).catchError((error) {
      emit(DeleteTodoErrorState(error.toString()));
      print(error.toString());
    });
  }

  void updateTodo({
    String? status,
    required String id,
  }) async {
    emit(UpdateTodoLoadingState());
    DioHelper.putData(
        url: "todos/$id",
        token: await CacheHelper.getData(key: "token"),
        data: {
          "status": status,
        }).then((value) {
      emit(UpdateTodoSuccessState());
    }).catchError((error) {
      emit(UpdateTodoErrorState(error.toString()));
      print(error.toString());
    });
  }
}
