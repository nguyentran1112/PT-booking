// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'type_of_gym_cubit.dart';

enum TypeOfGymStatus { initial, loading, success, failure }

class TypeOfGymState extends Equatable {
  const TypeOfGymState({
    this.typeOfGym = const <String>[],
    this.status = TypeOfGymStatus.initial,
    this.message = '',
  });
  final List<String> typeOfGym;
  final TypeOfGymStatus status;
  final String message;
  @override
  List<Object> get props => [
        typeOfGym,
        status,
        message,
      ];

  TypeOfGymState copyWith({
    List<String>? typeOfGym,
    TypeOfGymStatus? status,
    String? message,
  }) {
    return TypeOfGymState(
      typeOfGym: typeOfGym ?? this.typeOfGym,
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }
}
