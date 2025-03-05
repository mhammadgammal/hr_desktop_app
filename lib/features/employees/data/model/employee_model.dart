class EmployeeModel {
  late final String empId;
  late final String firstName;
  late final String lastName;
  late final String imagePath;
  late final String email;
  late final String job;
  late final String phone;
  late final String birthDate;
  late final String workHours;
  late final String workingDays;

  EmployeeModel({
    required this.empId,
    required this.firstName,
    required this.lastName,
    required this.imagePath,
    required this.email,
    required this.job,
    required this.phone,
    required this.birthDate,
    required this.workHours,
    required this.workingDays,
  });

  factory EmployeeModel.fromJson(Map<String, dynamic> json) => EmployeeModel(
    empId: json['emp_id'],
    firstName: json['first_name'],
    lastName: json['last_name'],
    imagePath: json['image_path'],
    email: json['email'],
    job: json['job'],
    phone: json['phone'],
    birthDate: json['birth_date'],
    workHours: json['work_hours'],
    workingDays: json['working_days'],
  );

  Map<String, dynamic> toJson() => {
    'emp_id': empId,
    'first_name': firstName,
    'last_name': lastName,
    'image_path': imagePath,
    'email': email,
    'job': job,
    'phone': phone,
    'birth_date': birthDate,
    'work_hours': workHours,
    'working_days': workingDays,
  };
}
