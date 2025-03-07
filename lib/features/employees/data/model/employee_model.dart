class EmployeeModel {
  final int empId;
  final String firstName;
  final String lastName;
  final String imagePath;
  final String email;
  final String job;
  final String phone;
  final String birthDate;
  final double salary;
  final String salaryDate;
  final String workHours;
  final String workingDays;

  const EmployeeModel({
    required this.empId,
    required this.firstName,
    required this.lastName,
    required this.imagePath,
    required this.email,
    required this.job,
    required this.phone,
    required this.birthDate,
    required this.salary,
    required this.salaryDate,
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
    salary: json['salary'],
    salaryDate: json['salary_date'],
    workHours: json['work_hours'],
    workingDays: json['working_days'],
  );

  Map<String, dynamic> toJson() => {
    'first_name': firstName,
    'last_name': lastName,
    'image_path': imagePath,
    'email': email,
    'job': job,
    'phone': phone,
    'birthdate': birthDate,
    'salary': salary,
    'salary_date': salaryDate,
    'working_hours': workHours,
    'working_days': workingDays,
  };
}
