import '../exams.dart';

abstract class ListState {}

class ListInitState extends ListElementsState {
  ListInitState() {
    elems = [];
  }
}

class ListEmptyState extends ListState {}

class ListElementsState extends ListState {
  List<ExamApplication>? elems;
  ListElementsState({this.elems});
}

class ListError extends ListState{
  final error;
  ListError({this.error});
}