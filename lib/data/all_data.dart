import 'package:bloc/bloc.dart';

class DataCubit extends Cubit<List<PersonalData>> {
  DataCubit() : super([]);

  void addData(data) => {state.add(data)};
}

class PersonalData {
  String firstName;
  String lastName;
  String gender;

  PersonalData(this.firstName, this.lastName, this.gender);
}
