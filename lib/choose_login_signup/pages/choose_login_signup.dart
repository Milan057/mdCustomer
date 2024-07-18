import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:md_customer/choose_login_signup/cubit/choose_login_signup_cubit.dart';
import 'package:md_customer/helper/colors.dart';

import 'package:md_customer/helper/material_state_color.dart';
import 'package:md_customer/register/views/register.dart';

import '../../login/views/login.dart';

class ChooseLoginOrSignup extends StatelessWidget {
  const ChooseLoginOrSignup({super.key});

  @override
  Widget build(BuildContext context) {
    var bloc = BlocProvider.of<ChooseLoginOrSignupCubit>(context);
    return Scaffold(
      backgroundColor: Color(0XFF12131F),
      body: BlocListener<ChooseLoginOrSignupCubit, ChooseLoginOrSignupState>(
        listener: (context, state) {
          if (state is ChoosedNavigateToRegister) {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => Register()),
            );
          } else if (state is ChoosedNavigateToSignin) {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => const Login()));
          }
        },
        child: SafeArea(
            child: Padding(
          padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "Namaste!",
                  style: TextStyle(
                      fontSize: 50,
                      color: textWhiteColor,
                      fontWeight: FontWeight.w500),
                ),
                Row(
                  children: [
                    Text(
                      "Let's Simplify your travel!",
                      style: TextStyle(
                          fontSize: 20,
                          color: textSlightWhiteColor,
                          fontWeight: FontWeight.w300),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Icon(Icons.directions_bus_rounded,
                        size: 25, color: iconColorExciting)
                  ],
                ),
                SizedBox(
                  height: 100,
                ),
                Container(
                  height: 50,
                  clipBehavior: Clip.hardEdge,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(15)),
                  child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateColor.resolveWith(
                              (states) => getColorBlue(states))),
                      onPressed: () {
                        bloc.onClickSignIn();
                      },
                      child: Text(
                        "Sign in",
                        style: TextStyle(fontSize: 16),
                      )),
                ),
                Divider(
                  color: Colors.grey,
                ),
                Container(
                  height: 50,
                  clipBehavior: Clip.hardEdge,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(15)),
                  child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateColor.resolveWith(
                              (states) => getColorWhite(states))),
                      onPressed: () {
                        bloc.onClickCreateAnAccount();
                      },
                      child: Text(
                        "Create an Account",
                        style:
                            TextStyle(fontSize: 16, color: Color(0XFF4158d2)),
                      )),
                ),
                SizedBox(
                  height: 50,
                )
              ]),
        )),
      ),
    );
  }
}
