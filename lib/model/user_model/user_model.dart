class UserModel {
  final String? image;
  final String? name;
  final String status;

  UserModel(this.image, this.name, this.status);

  UserModel.fromJson(Map<String, dynamic> json)
      : image = json['avtar'],
        name = json['name'],
        status = json['status'];
}
