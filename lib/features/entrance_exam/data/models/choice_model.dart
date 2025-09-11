import 'package:equatable/equatable.dart';

class Choice extends Equatable {
  final int id;
  final String text;
  final int order;

  const Choice({
    required this.id,
    required this.text,
    required this.order,
  });

  @override
  List<Object> get props => [id, text, order];
}