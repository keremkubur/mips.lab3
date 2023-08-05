import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mislab3/bloc/state_list.dart';
import '../exams.dart';
import 'event_list.dart';

class ListBloc extends Bloc<ListEvent, ListState> {
  List<ExamApplication>? _elems;

  ListBloc() : super(ListInitState()) {
    on<ListInitializedEvent>((event, emit) {
      this._elems = [
        ExamApplication(
            course: "Mobilni Informaciski Sistemi",
            dateTime: DateTime(2023, 8, 25, 17, 30)),
        ExamApplication(
            course: "Verojatnost i Statistika",
            dateTime: DateTime(2023, 8, 15, 17, 30)),
        ExamApplication(
            course: "Kalkulus",
            dateTime: DateTime(2023, 9, 2, 17, 30))
      ];
      ListInitState state = ListInitState();
      state.elems = this._elems;
      emit(state);
    });
    on<ListElementAddedEvent>((event, emit){
      this._elems!.add((event.elem as ExamApplication));
      emit(ListElementsState(elems: this._elems));
    });
    on<ListElementDeletedEvent>((event, emit){
      this._elems!.remove(event.elem);
      if(this._elems!.length > 0){
        emit(ListElementsState(elems: this._elems));
      }
      else{
        emit(ListEmptyState());
      }
    });
  }
}