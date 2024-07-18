import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:md_customer/choose_login_signup/cubit/choose_login_signup_cubit.dart';
import 'package:md_customer/choose_login_signup/pages/choose_login_signup.dart';
import 'package:md_customer/login/cubit/login_cubit.dart';
import 'package:md_customer/login/repository/login_repository.dart';
import 'package:md_customer/register/cubit/register_cubit.dart';
import 'package:md_customer/register/repository/register_repository.dart';
import 'package:http/http.dart' as http;

import 'http/timeoutClient.dart';

void main() {
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(create: (context) => ChooseLoginOrSignupCubit()),
      BlocProvider(create: (context) => RegisterCubit(RegisterRepository())),
      BlocProvider(create: (context) => LoginCubit(LoginRepository())),
    ],
    child: MaterialApp(
      home: ChooseLoginOrSignup(),
      theme: ThemeData(fontFamily: "Poppins"),
      debugShowCheckedModeBanner: false,
    ),
  ));
}
