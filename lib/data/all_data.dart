import 'package:bloc/bloc.dart';

class DataCubit extends Cubit<String> {
  DataCubit() : super('');

  void addFullName(String fullName) => emit(state + fullName);
}
