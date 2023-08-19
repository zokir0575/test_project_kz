import 'package:bloc/bloc.dart';
import 'package:formz/formz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:test_task_kz/core/exceptions/failures.dart';
import 'package:test_task_kz/core/singletons/service_locator.dart';
import 'package:test_task_kz/features/login/data/model/login_model.dart';
import 'package:test_task_kz/features/login/data/model/user_model.dart';
import 'package:test_task_kz/features/login/data/repository/login_repository_impl.dart';
import 'package:test_task_kz/features/login/domain/usecase/login_usecase.dart';

part 'login_bloc.freezed.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUseCase loginUseCase =
      LoginUseCase(repository: serviceLocator<LoginRepositoryImpl>());

  LoginBloc() : super(LoginState()) {
    on<_Login>((event, emit) async {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
      final result = await loginUseCase.call(event.userModel);
      if (result.isRight) {
        event.onSuccess!();
        emit(state.copyWith(status: FormzStatus.submissionSuccess));
      } else {
        if (result.left is DioFailure) {
          event.onError!('Error');
        } else if (result.left is ParsingFailure) {
          event.onError!((result.left as ParsingFailure).errorMessage);
        } else if (result.left is ServerFailure) {
          event.onError!((result.left as ServerFailure).errorMessage);
        }
        emit(state.copyWith(status: FormzStatus.submissionFailure));
      }
    });
  }
}
