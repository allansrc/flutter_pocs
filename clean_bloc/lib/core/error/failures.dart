import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final List properties = <dynamic>[];
  Failure([List properties = const <dynamic>[]]);

  @override
  List<Object> get props => [properties];
}
