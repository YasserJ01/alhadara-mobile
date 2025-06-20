import 'package:equatable/equatable.dart';

class University extends Equatable {
  final int id;
  final String name;

  const University({
    required this.id,
    required this.name,
  });

  @override
  List<Object> get props => [id, name];
}
