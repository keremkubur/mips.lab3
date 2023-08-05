import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mislab3/bloc/state_student.dart';
import '../exams.dart';
import '../student.dart';
import 'event_student.dart';

abstract class AddItemDelegate{
  void onSuccess();
  void onError(String message);
}

class StudentBloc extends Bloc<StudentEvent, StudentState> {
  List<Student>? _students;

  StudentBloc() : super(StudentInitState()) {
    on<StudentInitializedEvent>((event, emit) {
      this._students = [
        Student(
          id: "191187", password: "191187password", name: "Kerem", surname: "Kubur",
          exams: [
            ExamApplication(
                course: "Mobilni Informaciski Sistemi",
                dateTime: DateTime(2023, 8, 25, 17, 30)),
            ExamApplication(
                course: "Verojatnost i Statistika",
                dateTime: DateTime(2023, 8, 15, 17, 30))
          ],
        ),
      ];
      StudentInitState state = StudentInitState();
      state.students = this._students;
      emit(state);
    });
    on<StudentAddedEvent>((event, emit) {
      this._students!.add((event.student as Student));
      emit(StudentElementsState(students: this._students));
    });
    on<StudentDeletedEvent>((event, emit) {
      this._students!.remove(event.student);
      if (this._students!.length > 0) {
        emit(StudentElementsState(students: this._students));
      } else {
        emit(StudentEmptyState());
      }
    });
  }
}