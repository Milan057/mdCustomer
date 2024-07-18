import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:md_customer/exceptions/general_exception.dart';
import 'package:md_customer/register/model/register_model.dart';
import 'package:md_customer/register/repository/register_repository.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterRepository repository;
  RegisterCubit(this.repository) : super(RegisterInitialState());

  onClickRegister(String name, String phone, String email, String password,
      String rePassword) async {
    // RegisterValidationError validationError = RegisterValidationError();
    // int errorCount = 0;
    // if (name.isEmpty) {
    //   validationError.nameError = "Name can't be Empty";
    //   errorCount++;
    // }
    // if (phone.isEmpty) {
    //   validationError.phoneError = "Phone can't be Empty";
    //   errorCount++;
    // }
    // // if (email.isEmpty) {
    // //   validationError.emailError = "Email can't be Empty";
    // //   errorCount++;
    // // }
    // // if (password.isEmpty) {
    // //   validationError.passwordError = "Password can't be Empty";
    // //   errorCount++;
    // // }
    // print(errorCount);
    // if (errorCount != 0) {
    //   emit(validationError);
    // } else {
    //   print("Loading State");
    //   emit(RegisterValidationError());
    //   emit(RegisterLoadingState());
    // }

    // if (phone.isEmpty) {
    //   emit(RegisterPhoneFieldError("Phone can't be Empty!"));
    // }
    // if (email.isEmpty) {
    //   emit(RegisterEmailFieldError("Email can't be Empty"));
    // }
    // if (password.isEmpty) {
    //   emit(RegisterPasswordFieldError("Password can't be Empty"));
    // }
    int errorCount = 0;
    if (name.isEmpty) {
      errorCount++;
      emit(RegisterNameFieldError(errorMessage: "Name can't be Empty"));
    } else {
      emit(RegisterNameFieldError());
    }
    if (phone.isEmpty) {
      errorCount++;
      emit(RegisterPhoneFieldError(errorMessage: "Phone can't be Empty"));
    } else if (!RegExp(r'^(98|97)\d{8}$').hasMatch(phone)) {
      errorCount++;
      emit(RegisterPhoneFieldError(errorMessage: "Invalid Phone Number"));
    } else {
      emit(RegisterPhoneFieldError());
    }

    if (email.isEmpty) {
      errorCount++;
      emit(RegisterEmailFieldError(errorMessage: "Email can't be Empty"));
    } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email)) {
      errorCount++;
      emit(RegisterEmailFieldError(errorMessage: "Invalid Email"));
    } else {
      emit(RegisterEmailFieldError());
    }

    if (password.isEmpty) {
      errorCount++;
      emit(RegisterPasswordFieldError(errorMessage: "Password can't be Empty"));
    } else if (!RegExp(
            r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#$%^&*(),.?":{}|<>]).{6,}$')
        .hasMatch(password)) {
      errorCount++;
      emit(RegisterPasswordFieldError(
          errorMessage:
              "Password should contain at least 6 character with at least one upper, lower and special character"));
    } else {
      emit(RegisterPasswordFieldError());
    }

    if (rePassword.isEmpty) {
      errorCount++;
      emit(RegisterConfirmPasswordFieldError(
          errorMessage: "Password can't be Empty"));
    } else if (rePassword.compareTo(password) != 0) {
      errorCount++;
      emit(RegisterConfirmPasswordFieldError(
          errorMessage: "Password and Confirm Password should match"));
    } else {
      emit(RegisterConfirmPasswordFieldError());
    }

    if (errorCount == 0) {
      emit(RegisterLoadingState());
      try {
        RegisterModel model =
            await repository.register(name, phone, email, password);
        emit(RegisterInitialState());
        if (model.statusCode == 201) {
          emit(RegistrationSucessful("User Created Sucessfully!"));
        } else if (model.statusCode == 409) {
          if (model.responseType!.compareTo("EMILALREADYEXISTS") == 0) {
            emit(RegisterEmailFieldError(errorMessage: "Email Already Exists"));
          }
          if (model.responseType!.compareTo("PHONEALREADYEXISTS") == 0) {
            emit(RegisterPhoneFieldError(errorMessage: "Phone Already Exists"));
          }
        } else if (model.statusCode == 404) {
          emit(RegisterNotFound("Page Not Found!"));
        } else if (model.statusCode == 500) {
          emit(RegisterUnknownError(model.message!));
        }
      } on GeneralException catch (e) {
        emit(RegisterConnectionFailed(e.message));
      } catch (e) {
        emit(RegisterUnknownError("Client: Something Went Wrong!"));
      }
    }
  }
}

abstract class RegisterState {}

abstract class RegisterActionState extends RegisterState {}

class RegisterConnectionFailed extends RegisterActionState {
  String message;
  RegisterConnectionFailed(this.message);
}

class RegisterUnknownError extends RegisterActionState {
  String message;
  RegisterUnknownError(this.message);
}

class RegisterNotFound extends RegisterActionState {
  String message;
  RegisterNotFound(this.message);
}

class RegistrationSucessful extends RegisterActionState {
  String message;
  RegistrationSucessful(this.message);
}

class RegisterInitialState extends RegisterState {}

class RegisterLoadingState extends RegisterState {}

class RegisterNameFieldError extends RegisterState {
  String? errorMessage;
  RegisterNameFieldError({this.errorMessage});
}

class RegisterPhoneFieldError extends RegisterState {
  String? errorMessage;
  RegisterPhoneFieldError({this.errorMessage});
}

class RegisterEmailFieldError extends RegisterState {
  String? errorMessage;
  RegisterEmailFieldError({this.errorMessage});
}

class RegisterPasswordFieldError extends RegisterState {
  String? errorMessage;
  RegisterPasswordFieldError({this.errorMessage});
}

class RegisterConfirmPasswordFieldError extends RegisterState {
  String? errorMessage;
  RegisterConfirmPasswordFieldError({this.errorMessage});
}

class RegisterValidationError extends RegisterState {
  String? emailError;
  String? phoneError;
  String? nameError;
  String? passwordError;
}
