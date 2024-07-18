import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:md_customer/helper/elevatedButton.dart';
import 'package:md_customer/helper/material_state_color.dart';
import 'package:md_customer/helper/textField.dart';
import 'package:md_customer/register/cubit/register_cubit.dart';

import '../../helper/colors.dart';

class Register extends StatelessWidget {
  const Register({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController rePasswordController = TextEditingController();
    RegisterCubit bloc = BlocProvider.of<RegisterCubit>(context);
    if (bloc == null) {
      print("Block Null");
    }
    return Scaffold(
      backgroundColor: Color(0XFF12131F),
      body: SingleChildScrollView(
          child: SafeArea(
        child: Padding(
            padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: BlocListener<RegisterCubit, RegisterState>(
                listenWhen: (previous, current) =>
                    current is RegisterActionState,
                listener: (context, state) {
                  if (state is RegistrationSucessful) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(state.message)));
                  } else if (state is RegisterConnectionFailed) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(state.message)));
                  } else if (state is RegisterUnknownError) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(state.message)));
                  } else if (state is RegisterNotFound) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(state.message)));
                  }
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    Text(
                      "Create Account",
                      style: TextStyle(
                          fontSize: 30,
                          color: textWhiteColor,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 30,
                    ),

                    // BlocConsumer<RegisterCubit, RegisterState>(
                    //     buildWhen: (previous, current) =>
                    //         current is! RegisterActionState,
                    //     listenWhen: (previous, current) =>
                    //         current is RegisterActionState,
                    //     builder: (context, state) {
                    //       if (state is RegisterValidationError) {
                    //         return Column(
                    //           children: [],
                    //         );
                    //       }
                    //     },
                    //     listener: (context, state) {}),

                    // -----------Full Name-----------------
                    // BlocBuilder<RegisterCubit, RegisterState>(
                    //     buildWhen: (previous, current) =>
                    //         current is RegisterValidationError,
                    //     builder: (context, state) {
                    //       if (state is RegisterValidationError) {
                    //         // if (state is! RegisterNameFieldError) {
                    //         //   return getInputFormInputText(
                    //         //       controller: nameController,
                    //         //       hintText: "Full Name",
                    //         //       icon: Icons.person,
                    //         //       type: TextInputType.name);
                    //         // } else {
                    //         //   return getInputFormInputText(
                    //         //       controller: nameController,
                    //         //       hintText: "Full Name",ff
                    //         //       icon: Icons.person,
                    //         //       type: TextInputType.name,
                    //         //       errorText: state.errorMessage);
                    //         // }
                    //         return Column(
                    //           children: [
                    //             state.nameError == null
                    //                 ? getInputFormInputText(
                    //                     controller: nameController,
                    //                     hintText: "Full Name",
                    //                     icon: Icons.person,
                    //                     type: TextInputType.name)
                    //                 : getInputFormInputText(
                    //                     controller: nameController,
                    //                     hintText: "Full Name",
                    //                     icon: Icons.person,
                    //                     type: TextInputType.name,
                    //                     errorText: state.nameError),
                    //             state.phoneError == null
                    //                 ? getInputFormInputText(
                    //                     controller: phoneController,
                    //                     hintText: "Phone",
                    //                     icon: Icons.phone,
                    //                     type: TextInputType.number)
                    //                 : getInputFormInputText(
                    //                     controller: phoneController,
                    //                     hintText: "Phone",
                    //                     icon: Icons.phone,
                    //                     type: TextInputType.phone,
                    //                     errorText: state.phoneError)
                    //           ],
                    //         );
                    //       } else {
                    //         return Container();
                    //       }
                    //     }),

// -----------Full Name-----------------
                    BlocBuilder<RegisterCubit, RegisterState>(
                        buildWhen: (previous, current) =>
                            current is RegisterNameFieldError,
                        builder: (context, state) {
                          if (state is RegisterNameFieldError &&
                              state.errorMessage != null) {
                            return getInputFormInputText(
                                controller: nameController,
                                hintText: "Full Name",
                                icon: Icons.person,
                                errorText: state.errorMessage,
                                inputFormatter: getTextOnlyFormatter(),
                                type: TextInputType.name);
                          } else {
                            return getInputFormInputText(
                                inputFormatter: getTextOnlyFormatter(),
                                controller: nameController,
                                hintText: "Full Name",
                                icon: Icons.person,
                                type: TextInputType.name);
                          }
                        }),
                    SizedBox(
                      height: 8,
                    ),
                    // -----------Phone Number-----------------
                    BlocBuilder<RegisterCubit, RegisterState>(
                        buildWhen: (previous, current) =>
                            current is RegisterPhoneFieldError,
                        builder: (context, state) {
                          if (state is RegisterPhoneFieldError &&
                              state.errorMessage != null) {
                            return getInputFormInputText(
                                inputFormatter: getDigitOnlyFormatter(),
                                controller: phoneController,
                                hintText: "Phone",
                                icon: Icons.phone,
                                errorText: state.errorMessage,
                                type: TextInputType.phone);
                          } else {
                            return getInputFormInputText(
                                inputFormatter: getDigitOnlyFormatter(),
                                controller: phoneController,
                                hintText: "Phone",
                                icon: Icons.phone,
                                type: TextInputType.phone);
                          }
                        }),
                    SizedBox(
                      height: 8,
                    ),
                    // -----------Email-----------------
                    BlocBuilder<RegisterCubit, RegisterState>(
                        buildWhen: (previous, current) =>
                            current is RegisterEmailFieldError,
                        builder: (context, state) {
                          if (state is RegisterEmailFieldError &&
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
                    BlocBuilder<RegisterCubit, RegisterState>(
                        buildWhen: (previous, current) =>
                            current is RegisterPasswordFieldError,
                        builder: (context, state) {
                          if (state is RegisterPasswordFieldError &&
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
                      height: 8,
                    ),

                    // -----------RePassword-----------------
                    BlocBuilder<RegisterCubit, RegisterState>(
                        buildWhen: (previous, current) =>
                            current is RegisterConfirmPasswordFieldError,
                        builder: (context, state) {
                          if (state is RegisterConfirmPasswordFieldError &&
                              state.errorMessage != null) {
                            return getInputFormInputText(
                              inputFormatter: getAllCharFormatter(),
                              controller: rePasswordController,
                              hintText: "Confirm Password",
                              icon: Icons.password,
                              errorText: state.errorMessage,
                              type: TextInputType.visiblePassword,
                              isPassword: true,
                            );
                          } else {
                            return getInputFormInputText(
                                inputFormatter: getAllCharFormatter(),
                                controller: rePasswordController,
                                hintText: "Confirm Password",
                                icon: Icons.password,
                                type: TextInputType.visiblePassword,
                                isPassword: true);
                          }
                        }),

                    SizedBox(
                      height: 50,
                    ),

                    BlocBuilder<RegisterCubit, RegisterState>(
                        builder: (context, state) {
                      if (state is RegisterLoadingState) {
                        return getBlueElevatedButton(
                            text: "Sign Up",
                            onClick: () {
                              bloc.onClickRegister(
                                  nameController.text,
                                  phoneController.text,
                                  emailController.text,
                                  passwordController.text,
                                  rePasswordController.text);
                            },
                            isLoading: true);
                      } else {
                        return getBlueElevatedButton(
                            text: "Sign Up",
                            onClick: () {
                              bloc.onClickRegister(
                                  nameController.text,
                                  phoneController.text,
                                  emailController.text,
                                  passwordController.text,
                                  rePasswordController.text);
                            });
                      }
                    })
                  ],
                ))),
      )),
    );
  }
}
