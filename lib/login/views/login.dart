import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:md_customer/helper/elevatedButton.dart';
import 'package:md_customer/helper/textField.dart';
import 'package:md_customer/login/cubit/login_cubit.dart';

import '../../helper/colors.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    LoginCubit bloc = BlocProvider.of<LoginCubit>(context);
    return Scaffold(
      backgroundColor: Color(0XFF12131F),
      body: SingleChildScrollView(
          child: SafeArea(
        child: Padding(
            padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: BlocListener<LoginCubit, LoginState>(
                listenWhen: (previous, current) => current is LoginActionState,
                listener: (context, state) {
                  if (state is LoginSucessfulState) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Login Sucessful!")));
                  } else if (state is LoginExceptionState) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(state.message)));
                  } else if (state is LoginUnsucessfulState) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(state.message)));
                  }
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      height: 100,
                    ),
                    Text(
                      "Sign In",
                      style: TextStyle(
                          fontSize: 30,
                          color: textWhiteColor,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    // -----------Email-----------------
                    BlocBuilder<LoginCubit, LoginState>(
                        buildWhen: (previous, current) =>
                            current is LoginEmailFieldError,
                        builder: (context, state) {
                          if (state is LoginEmailFieldError &&
                              state.errorMessage != null) {
                            return getInputFormInputText(
                                inputFormatter: getAllCharFormatter(),
                                controller: emailController,
                                hintText: "Email",
                                icon: Icons.email,
                                errorText: state.errorMessage,
                                type: TextInputType.emailAddress);
                          } else {
                            return getInputFormInputText(
                                inputFormatter: getAllCharFormatter(),
                                controller: emailController,
                                hintText: "Email",
                                icon: Icons.email,
                                type: TextInputType.emailAddress);
                          }
                        }),
                    SizedBox(
                      height: 8,
                    ),
                    // -----------Password-----------------
                    BlocBuilder<LoginCubit, LoginState>(
                        buildWhen: (previous, current) =>
                            current is LoginPasswordFieldError,
                        builder: (context, state) {
                          if (state is LoginPasswordFieldError &&
                              state.errorMessage != null) {
                            return getInputFormInputText(
                                inputFormatter: getAllCharFormatter(),
                                controller: passwordController,
                                hintText: "Password",
                                icon: Icons.password,
                                errorText: state.errorMessage,
                                type: TextInputType.visiblePassword,
                                isPassword: true);
                          } else {
                            return getInputFormInputText(
                              inputFormatter: getAllCharFormatter(),
                              controller: passwordController,
                              hintText: "Password",
                              icon: Icons.password,
                              type: TextInputType.visiblePassword,
                              isPassword: true,
                            );
                          }
                        }),
                    SizedBox(
                      height: 50,
                    ),

                    BlocBuilder<LoginCubit, LoginState>(
                        builder: (context, state) {
                      if (state is LoginLoadingState) {
                        return getBlueElevatedButton(
                            text: "Sign In",
                            onClick: () {
                              bloc.onClickSignUp(
                                emailController.text,
                                passwordController.text,
                              );
                            },
                            isLoading: true);
                      } else {
                        return getBlueElevatedButton(
                            text: "Sign In",
                            onClick: () {
                              bloc.onClickSignUp(
                                emailController.text,
                                passwordController.text,
                              );
                            });
                      }
                    })
                  ],
                ))),
      )),
    );
  }
}
