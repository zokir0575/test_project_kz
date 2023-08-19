import 'package:equatable/equatable.dart';
import 'package:test_task_kz/core/exceptions/failures.dart';
import 'package:test_task_kz/core/utils/either.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

abstract class StreamUseCase<Type, Params> {
  Stream<Type> call(Params params);
}

class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}
