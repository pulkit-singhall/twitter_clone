import 'package:fpdart/fpdart.dart';
import 'failure.dart';

// this is either failure or success
// <Failure, Success>

typedef FutureEither<T> = Future<Either<Failure, T>>;
typedef FutureEitherVoid = FutureEither<void>;