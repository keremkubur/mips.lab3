import 'exams.dart';

class Student{
  String id;
  String password;
  String name;
  String surname;
  List<ExamApplication> exams;

  Student({required this.id, required this.password, required this.name,required this.surname,required this.exams,});
}