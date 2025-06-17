import 'package:equatable/equatable.dart';

class Studyfield extends Equatable {
  final int id;
  final String name;

  const Studyfield({
    required this.id,
    required this.name,
  });

  @override
  List<Object> get props => [id, name];
}