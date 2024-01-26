class ProfileModel {
  String name;

  ProfileModel({required this.name});

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      name: json['name'],
    );
  }
}
