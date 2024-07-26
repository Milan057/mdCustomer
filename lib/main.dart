import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:md_customer/login/cubit/login_cubit.dart';
import 'package:md_customer/login/repository/login_repository.dart';
import 'package:http/http.dart' as http;
import 'package:md_customer/login/views/login.dart';

import 'http/timeoutClient.dart';

void main() {
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(create: (context) => LoginCubit(LoginRepository())),
    ],
    child: MaterialApp(
      home: Login(),
      theme: ThemeData(fontFamily: "Poppins"),
      debugShowCheckedModeBanner: false,
    ),
  ));
}
