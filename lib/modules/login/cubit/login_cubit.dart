import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/modules/login/cubit/login_states.dart';
import 'package:social_app/shared/components/constants.dart';
import 'package:social_app/shared/cubit/social_cubit.dart';
import 'package:social_app/shared/network/local/cache_helper.dart';

class LoginCubit extends Cubit<LoginStates>
{
  LoginCubit() : super (LoginInitialState());
  static LoginCubit get(context)=> BlocProvider.of(context);

  void userLogin(
      {
        required String email,
        required String password,
      })
  {
    emit(LoginLoadingState());

    FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
    ).then((value) {

      print('siiiiiiiiiiiii');
      print(value.user?.uid);
      CacheHelper.saveData(key: 'uId', value: value.user?.uid);
      uId= CacheHelper.getData(key: 'uId');
      print(uId);
      emit(LoginSuccessState(value.user?.uid));


    }).catchError((error){
      print(error.toString());
      emit(LoginErrorState(error.toString()));

    });
  }


  IconData suffix= Icons.visibility_outlined;
  bool isPassword=true;
  void changePasswordVisability()
  {
    isPassword= !isPassword;
    suffix= isPassword? Icons.remove_red_eye : Icons.visibility_off_outlined;
    emit(LoginChangePasswordState());

  }

}