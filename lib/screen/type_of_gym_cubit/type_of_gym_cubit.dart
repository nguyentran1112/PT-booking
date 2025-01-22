import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fitness/services/gym_of_type_service.dart';
part 'type_of_gym_state.dart';

class TypeOfGymCubit extends Cubit<TypeOfGymState> {
  TypeOfGymCubit() : super(TypeOfGymState());
  loadTypeOfGym() async {
    emit(state.copyWith(status: TypeOfGymStatus.loading));
    try {
      final typeOfGym = await GymOfTypeService().getGymTypes();
      emit(state.copyWith(
        typeOfGym: typeOfGym,
        status: TypeOfGymStatus.success,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: TypeOfGymStatus.failure,
        message: 'Error fetching gym types: $e',
      ));
    }
  }
}
