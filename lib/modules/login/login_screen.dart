import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/modules/home/home_screen.dart';
import 'package:social_app/modules/login/cubit/login_cubit.dart';
import 'package:social_app/modules/login/cubit/login_states.dart';
import 'package:social_app/modules/register/register_screen.dart';

import 'package:social_app/shared/components/components.dart';

class LoginScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is LoginErrorState) {
            showToast(text: state.error, state: ToastStates.ERROR);
          }

          if (state is LoginSuccessState) {
            navigateAndFinish(context, HomeScreen());

          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Login',
                          style:
                              Theme.of(context).textTheme.headline3?.copyWith(
                                    color: Colors.black,
                                  ),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        defaultFormField(
                            controller: emailController,
                            keyboardTybe: TextInputType.emailAddress,
                            prefixIcon: Icons.email_outlined,
                            label: 'Email Address',
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Email can\'t be empty';
                              }
                              return null;
                            }),
                        SizedBox(
                          height: 20.0,
                        ),
                        defaultFormField(
                            controller: passwordController,
                            keyboardTybe: TextInputType.visiblePassword,
                            isPassword: LoginCubit.get(context).isPassword,
                            prefixIcon: Icons.lock_outline,
                            suffix: LoginCubit.get(context).suffix,
                            suffixPressed: () {
                              LoginCubit.get(context)
                                  .changePasswordVisability();
                            },
                            label: 'Password',
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Password is too short';
                              }
                              return null;
                            },
                            onSubmit: (value) {
                              if (formKey.currentState!.validate()) {
                                // ShopLoginCubit.get(context).userLogin(
                                //   email: emailController.text,
                                //   password: passwordController.text,
                                // );
                              }
                            }),
                        SizedBox(
                          height: 30.0,
                        ),
                        ConditionalBuilder(
                          condition: state is! LoginLoadingState,
                          builder: (context) => defaultButton(
                            function: () {
                              if (formKey.currentState!.validate()) {
                                LoginCubit.get(context).userLogin(
                                  email: emailController.text.trim(),
                                  password: passwordController.text.trim(),
                                );
                              }
                            },
                            width: double.infinity,
                            text: 'login',
                          ),
                          fallback: (context) =>
                              Center(child: CircularProgressIndicator()),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Don\'t have an account?',
                            ),
                            TextButton(
                              onPressed: () {
                                navigateTo(context, RegisterScreen());
                              },
                              child: Text(
                                'Register now',
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
