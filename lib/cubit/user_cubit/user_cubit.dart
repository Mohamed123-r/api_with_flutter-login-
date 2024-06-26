import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happy_tech_mastering_api_with_flutter/core/api/api_consumer.dart';
import 'package:happy_tech_mastering_api_with_flutter/core/api/end_point.dart';
import 'package:happy_tech_mastering_api_with_flutter/core/database/cache/cache_helper.dart';
import 'package:happy_tech_mastering_api_with_flutter/core/error/exceptions.dart';
import 'package:happy_tech_mastering_api_with_flutter/cubit/user_cubit/user_state.dart';
import 'package:happy_tech_mastering_api_with_flutter/models/Sign_in_model.dart';
import 'package:happy_tech_mastering_api_with_flutter/models/Sign_up_model.dart';
import 'package:happy_tech_mastering_api_with_flutter/models/User_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit(this.api) : super(UserInitial());

  final ApiConsumer api;
  SignInModel? signInModel;
  SignUpModel? signUpModel;
  UserModel ? userModel;

  //Sign in Form key
  GlobalKey<FormState> signInFormKey = GlobalKey();

  //Sign in email
  TextEditingController signInEmail = TextEditingController();

  //Sign in password
  TextEditingController signInPassword = TextEditingController();

  //Sign Up Form key
  GlobalKey<FormState> signUpFormKey = GlobalKey();

  //Profile Pic
  XFile? profilePic;

  //Sign up name
  TextEditingController signUpName = TextEditingController();

  //Sign up phone number
  TextEditingController signUpPhoneNumber = TextEditingController();

  //Sign up email
  TextEditingController signUpEmail = TextEditingController();

  //Sign up password
  TextEditingController signUpPassword = TextEditingController();

  //Sign up confirm password
  TextEditingController confirmPassword = TextEditingController();

  uploadImagePic(XFile image) {
    profilePic = image;
    emit(UploadImageSuccess());
  }

  getUserData() async {
    emit(UserLoading());
    try {
      var response = await api.get(
        EndPoint.getUserDataEndPoint(
          CacheHelper().getData(key: ApiKeys.userId),
        ),
      );
 userModel = UserModel.fromJson(response);
      emit(UserSuccess(
        userModel!,
      ));
    } on ServerException catch (e) {
      emit(
      UserFailed(errorMessage: e.errorModel.errorMessage),
      );
    }
  }

  signUp() async {
    emit(SingUpLoading());
    try {
      var response = await api.post(
        EndPoint.signUp,
        isFormData: true,
        body: {
          ApiKeys.name: signUpName.text,
          ApiKeys.email: signUpEmail.text,
          ApiKeys.password: signUpPassword.text,
          ApiKeys.confirmPassword: confirmPassword.text,
          ApiKeys.phone: signUpPhoneNumber.text,
          ApiKeys.location:
              '{"name":"methalfa","address":"meet halfa","coordinates":[30.1572709,31.224779]}',
          ApiKeys.profilePic: await MultipartFile.fromFile(
            profilePic!.path,
            filename: profilePic!.name,
          ),
        },
      );
      signUpModel = SignUpModel.fromJson(response);
      emit(SingUpSuccess(
        signUpModel!.message!,
      ));
    } on ServerException catch (e) {
      emit(
        SingUpFailed(errorMessage: e.errorModel.errorMessage),
      );
    }
  }

  signIn() async {
    emit(SingInLoading());
    try {
      var response = await api.post(
        EndPoint.signIn,
        body: {
          ApiKeys.email: signInEmail.text,
          ApiKeys.password: signInPassword.text,
        },
      );
      emit(SingInSuccess());
      signInModel = SignInModel.fromJson(response);
      final decodedToken = JwtDecoder.decode(signInModel!.token!);
      CacheHelper().saveData(key: ApiKeys.token, value: signInModel!.token);
      CacheHelper().saveData(key: ApiKeys.userId, value: decodedToken['id']);
    } on ServerException catch (e) {
      emit(
        SingInFailed(errorMessage: e.errorModel.errorMessage),
      );
    }
  }
}
