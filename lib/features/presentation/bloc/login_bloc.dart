import 'package:bloc/bloc.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginStateModel> {
  LoginBloc() : super(LoginStateModel.initial()) {
    on<LoginButtonPressed>(_onLoginButtonPressed);
    on<LogoutButtonPressed>(_onLogoutButtonPressed);
  }

  Future<void> _onLoginButtonPressed(
      LoginButtonPressed event, Emitter emit) async {
    try {
      emit(state.copyWith(
        loginState: LoginLoading(),
      ));

      BotToast.showLoading();

      var result = await Dio().post('https://reqres.in/api/login', data: {
        'email': event.username,
        'password': event.password,
      });

      emit(
        state.copyWith(
          loginState: LoginAuthenticated(),
        ),
      );
    } catch (e) {
      emit(state.copyWith(
        loginState: LoginError(error: 'Login failed'),
      ));
      BotToast.showText(text: 'Login failed');
    } finally {
      BotToast.closeAllLoading();
    }
  }

  Future<void> _onLogoutButtonPressed(
      LogoutButtonPressed event, Emitter emit) async {
    emit(state.copyWith(
      loginState: LoginUnauthenticated(),
    ));
  }
}
