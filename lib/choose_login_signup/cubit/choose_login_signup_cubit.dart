import 'package:flutter_bloc/flutter_bloc.dart';

class ChooseLoginOrSignupCubit extends Cubit<ChooseLoginOrSignupState> {
  ChooseLoginOrSignupCubit() : super(ChooseLoginOrSignUpInitial());

  void onClickCreateAnAccount() {
    emit(ChoosedNavigateToRegister());
  }

  void onClickSignIn() {
    emit(ChoosedNavigateToSignin());
  }
}

abstract class ChooseLoginOrSignupState {}

class ChooseLoginOrSignUpInitial extends ChooseLoginOrSignupState {}

class ChoosedNavigateToRegister extends ChooseLoginOrSignupState {}

class ChoosedNavigateToSignin extends ChooseLoginOrSignupState {}
