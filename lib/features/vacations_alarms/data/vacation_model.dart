class VacationModel {
  final int id;
  final int empId;
  final String startDate;
  final String endDate;

  VacationModel({
    required this.id,
    required this.empId,
    required this.startDate,
    required this.endDate,
  });

  factory VacationModel.fromJson(Map<String, dynamic> json) => VacationModel(
    id: json['id'],
    empId: json['emp_id'],
    startDate: json['start_date'],
    endDate: json['end_date'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'emp_id': empId,
    'start_date': startDate,
    'end_date': endDate,
  };
}
