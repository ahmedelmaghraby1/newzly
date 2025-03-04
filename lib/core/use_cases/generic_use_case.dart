import 'package:dartz/dartz.dart';
import 'package:newzly/core/models/errors/failure_model.dart';

abstract class UseCase<Type, Parameters> {
  Future<Either<Failure, Type>> call([Parameters parameters]);
}

class NoParameters {}
