import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/modules/register/cubit/register_states.dart';

class RegisterCubit extends Cubit<RegisterStates>
{
  RegisterCubit() : super (RegisterInitState());
  static RegisterCubit get(context)=> BlocProvider.of(context);

  void userRegister({
    required String name,
    required String email,
    required String password,
    String? image,
    required String phone,
  }) {
    emit(RegisterLoadingState());

    FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
    ).then((value) {
          createUser(
            name: name,
            email: email,
            phone: phone,
            uId: value.user?.uid,
            bio: 'Write your bio ...',
          );
          print('creaaaaaaat');
          emit(RegisterSuccessState());
    }).catchError((error){

      print(error.toString());
      emit(RegisterErrorState());
    });

  }

  void createUser({
    required String name,
    required String email,
    required dynamic uId,
    required String phone,
    required String bio,

  })
  {

    UserModel userModel=UserModel(
      name: name,
      email: email,
      phone: phone,
      uId: uId,
      bio: 'Write your bio ...',
      cover: 'https://img.freepik.com/free-photo/hesitant-puzzled-unshaven-man-shruggs-shoulders-bewilderment-feels-indecisive-has-bristle-trendy-haircut-dressed-blue-stylish-shirt-isolated-white-wall-clueless-male-poses-indoor_273609-16518.jpg?w=740&t=st=1673870443~exp=1673871043~hmac=2294d5188ffd4ee3c696d354993ec8a36690b3cd9e093a57139e3228a7b37816',
      image:'https://img.freepik.com/free-photo/close-up-young-successful-man-smiling-camera-standing-casual-outfit-against-blue-background_1258-66609.jpg?w=740&t=st=1673869154~exp=1673869754~hmac=f64f85b1aa25e7008ded9aa7cb9c319df752587a985fe39fd6c7df48e976973f',
      isEmailVerified: false,
    );
    FirebaseFirestore.instance.collection('users')
        .doc(uId)
        .set(userModel.toMap())
        .then((value)
    {
      emit(CreateUserSuccessState());
    }).catchError((error)
    {
      print(error.toString());
      emit(CreateUserErrorState());
    });
  }
  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;
  void changePasswordVisability() {
    isPassword = !isPassword;
    suffix = isPassword ? Icons.remove_red_eye : Icons.visibility_off_outlined;
    emit(ChangeRegisterPasswordState());
  }

}