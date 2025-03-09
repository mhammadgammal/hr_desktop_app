class ContractModel {
  final int id;
  final int employeeId;
  final String startDate;
  final String endDate;
  final int overtimeYearly;
  final int overtimeMonthly;
  final int overtimePrice;

  const ContractModel({
    required this.id,
    required this.employeeId,
    required this.startDate,
    required this.endDate,
    required this.overtimeYearly,
    required this.overtimeMonthly,
    required this.overtimePrice,
  });

  factory ContractModel.fromJson(Map<String, dynamic> json) => ContractModel(
    id: json['id'],
    employeeId: json['emp_id'],
    startDate: json['start_date'],
    endDate: json['end_date'],
    overtimeYearly: json['overtime_yearly'],
    overtimeMonthly: json['overtime_monthly'],
    overtimePrice: json['overtime_price'],
  );

  Map<String, dynamic> toJson() => {
    'emp_id': employeeId,
    'start_date': startDate,
    'end_date': endDate,
    'overtime_yearly': overtimeYearly,
    'overtime_monthly': overtimeMonthly,
    'overtime_price': overtimePrice,
  };
}
