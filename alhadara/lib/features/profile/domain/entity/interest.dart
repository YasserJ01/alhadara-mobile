import 'package:equatable/equatable.dart';

class Interest extends Equatable {
  final int interest;
  final String interestName;
  final String interestCategory;
  final int intensity;

  const Interest({
    required this.interest,
    required this.interestName,
    required this.interestCategory,
    required this.intensity,
  });

  @override
  List<Object> get props => [interest, interestName, interestCategory, intensity];
}
