import 'package:clean_bloc/core/platform/network_info.dart';
import 'package:clean_bloc/features/number_trivia/data/datasources/number_trivia_data_source.dart';
import 'package:clean_bloc/features/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'package:clean_bloc/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:clean_bloc/core/error/failures.dart';
import 'package:clean_bloc/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

class NumberTriviaRepositoryImpl implements NumberTriviaRepository {
  final NumberTriviaRemoteDataSource remoteDataSource;
  final NumberTriviaLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  NumberTriviaRepositoryImpl({
    @required this.remoteDataSource,
    @required this.localDataSource,
    @required this.networkInfo,
  });
  @override
  Future<Either<Failure, NumberTrivia>> getConcreteNumberTrivia(int number) {
    // TODO: implement getConcreteNumberTrivia
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, NumberTrivia>> getRandomNumberTriva() {
    // TODO: implement getRandomNumberTriva
    throw UnimplementedError();
  }
}
