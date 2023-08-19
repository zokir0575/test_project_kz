import 'package:bloc/bloc.dart';
import 'package:formz/formz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:test_task_kz/core/singletons/service_locator.dart';
import 'package:test_task_kz/core/usecases/usecase.dart';
import 'package:test_task_kz/features/login/data/model/user_model.dart';
import 'package:test_task_kz/features/profile/data/repository/profile_repository_impl.dart';
import 'package:test_task_kz/features/profile/domain/usecase/profile_usecase.dart';

part 'profile_bloc.freezed.dart';

part 'profile_event.dart';

part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileUseCase useCase =
      ProfileUseCase(repository: serviceLocator<ProfileRepositoryImpl>());

  ProfileBloc() : super(ProfileState()) {
    on<_GetProfile>((event, emit) async {
      print('progres');
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
      final result = await useCase.call(NoParams());
      if (result.isRight) {
        print('success');
        emit(state.copyWith(
            profile: result.right, status: FormzStatus.submissionSuccess));
      } else {
        print('fail');
        emit(state.copyWith(status: FormzStatus.submissionFailure));
      }
    });
  }
}
