import 'package:clean_bloc/core/usecases/usecase.dart';
import 'package:clean_bloc/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:clean_bloc/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:clean_bloc/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockNumberTriviaRepository extends Mock implements NumberTriviaRepository {}

void main() {
  GetRandomNumberTrivia usecase;
  MockNumberTriviaRepository mockNumberTriviaRepository;

  setUp(() {
    mockNumberTriviaRepository = MockNumberTriviaRepository();
    usecase = GetRandomNumberTrivia(repository: mockNumberTriviaRepository);
  });

  final tNumberTrivvia = NumberTrivia(text: 'test', number: 1);

  test('should get trivia from the repository', () async {
    when(mockNumberTriviaRepository.getRandomNumberTriva()).thenAnswer((_) async => Right(tNumberTrivvia));

    final result = await usecase(NoParams());

    expect(result, Right(tNumberTrivvia));
    verify(mockNumberTriviaRepository.getRandomNumberTriva());
    verifyNoMoreInteractions(mockNumberTriviaRepository);
  });
}
