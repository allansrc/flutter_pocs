import 'package:clean_bloc/core/error/exception.dart';
import 'package:clean_bloc/core/error/failures.dart';
import 'package:clean_bloc/core/platform/network_info.dart';
import 'package:clean_bloc/features/number_trivia/data/datasources/number_trivia_data_source.dart';
import 'package:clean_bloc/features/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'package:clean_bloc/features/number_trivia/data/models/number_trivia_models.dart';
import 'package:clean_bloc/features/number_trivia/data/repositories/number_trivia_repository_impl.dart';
import 'package:clean_bloc/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockRemoteDataSource extends Mock implements NumberTriviaRemoteDataSource {}

class MockLocalDataSource extends Mock implements NumberTriviaLocalDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  NumberTriviaRepositoryImpl repository;
  MockRemoteDataSource mockRemoteDataSource;
  MockLocalDataSource mockLocalDataSource;
  MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockNetworkInfo = MockNetworkInfo();
    mockLocalDataSource = MockLocalDataSource();
    mockRemoteDataSource = MockRemoteDataSource();

    repository = NumberTriviaRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  final tNumber = 1;
  final tNumberTriviaModel = NumberTriviaModel(text: 'test trivia', number: tNumber);

  final NumberTrivia tNumberTrivia = tNumberTriviaModel;

  group('getConcreteNumberTrivia', () {
    test('should check network state (is user connected/online)', () async {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);

      repository.getConcreteNumberTrivia(tNumber);

      verify(mockNetworkInfo.isConnected);
    });
  });

  group('device is online', () {
    setUp(() {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
    });

    test('should return remote data when the call to remote data source is successful', () async {
      when(mockRemoteDataSource.getConcreteNumberTrivia(tNumber)).thenAnswer((_) async => tNumberTriviaModel);

      final result = await repository.getConcreteNumberTrivia(tNumber);

      verify(mockRemoteDataSource.getConcreteNumberTrivia(tNumber));
      expect(result, equals(Right(tNumberTriviaModel)));
    });

    test('should cache the data locally when the call to remote data source is successful', () async {
      when(mockRemoteDataSource.getConcreteNumberTrivia(tNumber)).thenAnswer((realInvocation) async => tNumberTriviaModel);
      await repository.getConcreteNumberTrivia(tNumber);

      verify(mockRemoteDataSource.getConcreteNumberTrivia(tNumber));
      verify(mockLocalDataSource.cacheNumberTrivia(tNumberTrivia));
    });
  });

  group('server error', () {
    test('should return server failure when the call to remote data source is unsuccessful', () async {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.getConcreteNumberTrivia(tNumber)).thenThrow(ServerException());

      final result = await repository.getConcreteNumberTrivia(tNumber);

      verify(mockRemoteDataSource.getConcreteNumberTrivia(tNumber));
      verifyZeroInteractions(mockLocalDataSource);
      expect(result, equals(Left(ServerFailure())));
    });
  });

  group('device is offline', () {
    setUp(() => when(mockNetworkInfo.isConnected).thenAnswer((_) async => false));

    test('should return last locally cached data when cached data is present', () async {
      when(mockLocalDataSource.getLastNumberTrivia()).thenAnswer((_) async => tNumberTriviaModel);

      final result = await repository.getConcreteNumberTrivia(tNumber);

      verifyZeroInteractions(mockRemoteDataSource);
      verify(mockLocalDataSource.getLastNumberTrivia());
      expect(result, equals(Right(tNumberTrivia)));
    });
  });

  group('cache exception', () {
    test('should return Cache Failure when is no cached data present', () async {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      when(mockLocalDataSource.getLastNumberTrivia()).thenThrow(CacheException());
      final result = await repository.getConcreteNumberTrivia(tNumber);

      verifyZeroInteractions(mockRemoteDataSource);
      verify(mockLocalDataSource.getLastNumberTrivia());
      expect(result, equals(Left(CacheFailure())));
    });
  });
}
