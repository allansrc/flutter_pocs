import 'package:clean_bloc/core/error/failures.dart';
import 'package:clean_bloc/core/usecases/usecase.dart';
import 'package:clean_bloc/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:clean_bloc/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

class GetRandomNumberTrivia extends UseCase<NumberTrivia, NoParams> {
  final NumberTriviaRepository repository;

  GetRandomNumberTrivia({@required this.repository});

  @override
  Future<Either<Failure, NumberTrivia>> call(NoParams params) async {
    return await repository.getRandomNumberTriva();
  }
}
