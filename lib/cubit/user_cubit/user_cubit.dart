import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happy_tech_mastering_api_with_flutter/core/api/api_consumer.dart';
import 'package:happy_tech_mastering_api_with_flutter/core/api/end_point.dart';
import 'package:happy_tech_mastering_api_with_flutter/core/database/cache/cache_helper.dart';
import 'package:happy_tech_mastering_api_with_flutter/core/error/exceptions.dart';
import 'package:happy_tech_mastering_api_with_flutter/cubit/user_cubit/user_state.dart';
import 'package:happy_tech_mastering_api_with_flutter/models/Sign_in_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit(this.api) : super(UserInitial());

  final ApiConsumer api;
  SignInModel? signInModel;

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
    profilePic =image;
    emit(UploadImageSuccess());
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
