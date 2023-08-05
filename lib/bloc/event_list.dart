import '../exams.dart';

abstract class ListEvent{}

class ListInitializedEvent extends ListEvent {}

class ListElementAddedEvent extends ListEvent {
  final ExamApplication? elem;
  ListElementAddedEvent({this.elem});
}

class ListElementDeletedEvent extends ListEvent {
  final ExamApplication? elem;
  ListElementDeletedEvent({this.elem});
}