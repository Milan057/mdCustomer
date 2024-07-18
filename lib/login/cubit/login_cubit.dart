import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:md_customer/exceptions/general_exception.dart';
import 'package:md_customer/login/model/login_model.dart';
import 'package:md_customer/login/repository/login_repository.dart';
import 'package:md_customer/register/repository/register_repository.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginRepository repository;
  LoginCubit(this.repository) : super(LoginInitialState());

  void onClickSignUp(String phone, String password) async {
    int errorCount = 0;
    if (phone.isEmpty) {
      errorCount++;
      emit(LoginPhoneFieldError(errorMessage: "Phone can't be Empty!"));
    } else if (!RegExp(r'^(98|97)\d{8}$').hasMatch(phone)) {
      errorCount++;
      emit(LoginPhoneFieldError(errorMessage: "Invalid Phone Number"));
    } else {
      emit(LoginPhoneFieldError());
    }
    if (password.isEmpty) {
      errorCount++;
      emit(LoginPasswordFieldError(errorMessage: "Password can't be Empty!"));
    } else {
      emit(LoginPasswordFieldError());
    }
    if (errorCount == 0) {
      emit(LoginLoadingState());
      try {
        LoginModel model = await repository.login(phone, password);
        emit(LoginInitialState());
        if (model.statusCode == 200) {
          FlutterSecureStorage storage = FlutterSecureStorage();
          await storage.write(key: "token", value: model.token);
          String? value = await storage.read(key: "token");
          print("Value is:" + value!);
          emit(LoginSucessfulState());
        } else if (model.statusCode == 400) {
          emit(LoginUnsucessfulState(model.message!));
        } else {
          emit(LoginExceptionState(model.message!));
        }
      } on GeneralException catch (e) {
        emit(LoginExceptionState(e.message));
      } catch (e) {
        emit(LoginExceptionState("Something Went Wrong!"));
      }
    }
  }
}

abstract class LoginState {}

abstract class LoginActionState extends LoginState {}

class LoginInitialState extends LoginState {}

class LoginPhoneFieldError extends LoginState {
  String? errorMessage;
  LoginPhoneFieldError({this.errorMessage});
}

class LoginPasswordFieldError extends LoginState {
  String? errorMessage;
  LoginPasswordFieldError({this.errorMessage});
}

class LoginLoadingState extends LoginState {}

class LoginSucessfulState extends LoginActionState {}

class LoginUnsucessfulState extends LoginActionState {
  final String message;
  LoginUnsucessfulState(this.message);
}

class LoginExceptionState extends LoginActionState {
  final String message;
  LoginExceptionState(this.message);
}
