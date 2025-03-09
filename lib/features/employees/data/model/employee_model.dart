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
  final int workHours;
  final String workingDays;
  final String identityType;
  final String identityNumber;
  final String identityTypePicPath;

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
    required this.identityType,
    required this.identityNumber,
    required this.identityTypePicPath,
  });

  factory EmployeeModel.fromJson(Map<String, dynamic> json) => EmployeeModel(
    empId: json['id'],
    firstName: json['first_name'],
    lastName: json['last_name'],
    imagePath: json['image_path'],
    email: json['email'],
    job: json['job'],
    phone: json['phone'],
    birthDate: json['birthdate'],
    salary: json['salary'].toDouble(),
    salaryDate: json['salary_date'],
    workHours: json['working_hours'],
    workingDays: json['working_days'],
    identityType: json['identity_type'],
    identityNumber: json['identity_number'],
    identityTypePicPath: json['identity_type_pic_path'],
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
    "identity_type": identityType,
    "identity_number": identityNumber,
    "identity_type_pic_path": identityTypePicPath,
  };
}
