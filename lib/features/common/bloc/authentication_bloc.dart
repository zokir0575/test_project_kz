import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:test_task_kz/core/usecases/usecase.dart';
import 'package:test_task_kz/core/utils/my_functions.dart';
import 'package:test_task_kz/core/utils/shared_preferences.dart';
import 'package:test_task_kz/features/login/data/model/user_model.dart';
import 'package:test_task_kz/features/profile/domain/usecase/auth_status.dart';
import 'package:test_task_kz/features/profile/domain/usecase/profile_usecase.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthStatusUseCase _statusUseCase;
  final ProfileUseCase _getUserDataUseCase;
  late StreamSubscription<AuthStatus> statusSubscription;
  AuthenticationBloc(
      {required AuthStatusUseCase statusUseCase, required ProfileUseCase getUserDataUseCase})
      : _statusUseCase = statusUseCase,
        _getUserDataUseCase = getUserDataUseCase,
        super(const AuthenticationState.unauthenticated()) {
    statusSubscription = _statusUseCase.call(NoParams()).listen((event) {
      add(AuthenticationStatusChanged(status: event));
    });
    on<AuthenticationStatusChanged>((event, emit) async {
      switch (event.status) {
        case AuthStatus.authenticated:
          final userData = await _getUserDataUseCase.call(NoParams());
          if (userData.isRight) {
            emit(AuthenticationState.authenticated(userData.right));
          } else {
            await StorageRepository.deleteString('token');
            emit(const AuthenticationState.unauthenticated());
          }
          break;
        case AuthStatus.unAuthenticated:
          await StorageRepository.deleteString('token');
          emit(const AuthenticationState.unauthenticated());
          break;
      }
    });
  }
  @override
  Future<void> close() {
    statusSubscription.cancel();
    return super.close();
  }
}
