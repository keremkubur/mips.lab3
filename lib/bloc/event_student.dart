import '../student.dart';

abstract class StudentEvent{}

class StudentInitializedEvent extends StudentEvent {}

class StudentAddedEvent extends StudentEvent {
  final Student? student;
  StudentAddedEvent({this.student});
}

class StudentDeletedEvent extends StudentEvent {
  final Student? student;
  StudentDeletedEvent({this.student});
}