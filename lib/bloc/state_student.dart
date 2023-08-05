import '../student.dart';

abstract class StudentState {}

class StudentInitState extends StudentElementsState {
  StudentInitState() {
    students = [];
  }
}

class StudentEmptyState extends StudentState {}

class StudentElementsState extends StudentState {
  List<Student>? students;
  StudentElementsState({this.students});
}

class StudentError extends StudentState{
  final error;
  StudentError({this.error});
}