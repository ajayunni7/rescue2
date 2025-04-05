class UserModel {
  final String id;
  final String name;
  final String phone;
  final String bloodGroup;
  final String gender;
  final int age;

  UserModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.bloodGroup,
    required this.gender,
    required this.age,
  });

  // Convert a UserModel object to JSON
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "phone": phone,
      "blood_group": bloodGroup,
      "gender": gender,
      "age": age,
    };
  }

  // Convert JSON from Supabase to a UserModel object
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json["id"] ?? "",
      name: json["name"] ?? "",
      phone: json["phone"] ?? "",
      bloodGroup: json["blood_group"] ?? "",
      gender: json["gender"] ?? "",
      age: json["age"] ?? 0,
    );
  }
}
