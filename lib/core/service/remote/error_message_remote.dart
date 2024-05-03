import 'package:equatable/equatable.dart';

class ErrorMessageModel extends Equatable {
  final String msg;

  const ErrorMessageModel({
    required this.msg,
  });

  factory ErrorMessageModel.fromJson(Map<String, dynamic> json) {
    return ErrorMessageModel(
      msg: json["message"] as String,
    );
  }

  @override
  List<Object?> get props => [
    msg,
  ];
}
