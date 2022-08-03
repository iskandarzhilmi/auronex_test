import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import '../../../home/data/models/user_model.dart';

part 'detail_event.dart';
part 'detail_state.dart';

class DetailBloc extends Bloc<DetailEvent, DetailStateModel> {
  DetailBloc() : super(DetailStateModel.initial()) {
    on<DetailUpdateButtonPressed>(_onDetailUpdateButtonPressed);
    on<DetailCreateButtonPressed>(_onDetailCreateButtonPressed);
  }

  Future<void> _onDetailUpdateButtonPressed(
      DetailUpdateButtonPressed event, Emitter emit) async {
    try {
      emit(state.copyWith(
        state: DetailLoading(),
      ));

      BotToast.showLoading();

      var result = await Dio().put(
        'https://reqres.in/api/users/${event.user.id}',
        data: event.user.toJson(),
      );
      log(result.toString());
      emit(
        state.copyWith(
          state: DetailSuccess(),
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          state: DetailFailed(error: 'Save user failed'),
        ),
      );
      BotToast.showText(text: 'Save user failed');
    } finally {
      BotToast.closeAllLoading();
    }
  }

  Future<void> _onDetailCreateButtonPressed(
      DetailCreateButtonPressed event, Emitter emit) async {
    try {
      emit(state.copyWith(
        state: DetailLoading(),
      ));

      BotToast.showLoading();

      var result = await Dio().post('https://reqres.in/api/users', data: {
        'first_name': event.user.firstName,
        'last_name': event.user.lastName,
        'avatar': event.user.avatar,
      });

      log(result.toString());

      emit(
        state.copyWith(
          state: DetailSuccess(),
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          state: DetailFailed(error: 'Save user failed'),
        ),
      );
      BotToast.showText(text: 'Save user failed');
    } finally {
      BotToast.closeAllLoading();
    }
  }
}
