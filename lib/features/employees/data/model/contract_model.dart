class ContractModel {
  final int id;
  final int employeeId;
  final String startDate;
  final String endDate;
  final int overtimeYearly;
  final int overtimeMonthly;
  final int overtimePrice;
  final String contractPicturePath;

  const ContractModel({
    required this.id,
    required this.employeeId,
    required this.startDate,
    required this.endDate,
    required this.overtimeYearly,
    required this.overtimeMonthly,
    required this.overtimePrice,
    required this.contractPicturePath,
  });

  factory ContractModel.fromJson(Map<String, dynamic> json) => ContractModel(
    id: json['id'],
    employeeId: json['emp_id'],
    startDate: json['start_date'],
    endDate: json['end_date'],
    overtimeYearly: json['overtime_yearly'],
    overtimeMonthly: json['overtime_monthly'],
    overtimePrice: json['overtime_price'],
    contractPicturePath: json['contract_pic_path'],
  );

  Map<String, dynamic> toJson() => {
    'emp_id': employeeId,
    'start_date': startDate,
    'end_date': endDate,
    'overtime_yearly': overtimeYearly,
    'overtime_monthly': overtimeMonthly,
    'overtime_price': overtimePrice,
    'contract_pic_path': contractPicturePath,
  };
}
