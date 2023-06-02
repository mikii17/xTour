import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:x_tour/admin/user/repsitory/auth_repository.dart';

import '../../auth/bloc/auth_bloc.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthBloc authBloc;
  final AuthRepository authRepository;
  LoginBloc({required this.authBloc, required this.authRepository})
      : super(LoginInitial()) {
    on<Login>(login);
  }

  FutureOr<void> login(event, emit) async {
    emit(LoginLoading());
    try {
      final Map<String, dynamic> body = {
        "username": event.username,
        "password": event.password,
      };
      final Map<String, dynamic> response = await authRepository.login(body);
      authBloc.add(LoggedIn(token: response["access_token"]));
    } on Exception catch (e) {
      emit(LoginOperationFailure(error: e));
    }
  }
}
