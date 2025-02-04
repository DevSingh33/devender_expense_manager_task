//Parent class for all types of failure
import 'package:equatable/equatable.dart';

class Failure extends Equatable {
  final String message;

  const Failure( this.message);

  @override
  List<Object?> get props => [message];
}
class DatabaseFailure extends Failure {
  const DatabaseFailure(super.message);
  
}

