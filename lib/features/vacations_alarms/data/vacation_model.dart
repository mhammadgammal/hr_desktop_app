class VacationModel {
  final int id;
  final int empId;
  final String empFirstName;
  final String empLastName;
  final String empPicPath;
  final String startDate;
  final String endDate;

  VacationModel({
    required this.id,
    required this.empId,
    required this.empFirstName,
    required this.empLastName,
    required this.empPicPath,
    required this.startDate,
    required this.endDate,
  });

  factory VacationModel.fromJson(Map<String, Object?> json) => VacationModel(
    id: json['id'] as int,
    empId: json['emp_id'] as int,
    empFirstName: json['first_name'] as String,
    empLastName: json['last_name'] as String,
    empPicPath: json['image_path'] as String,
    startDate: json['start_date'] as String,
    endDate: json['end_date'] as String,
  );

  Map<String, dynamic> toJson() => {
    'emp_id': empId,
    'start_date': startDate,
    'end_date': endDate,
  };
}
