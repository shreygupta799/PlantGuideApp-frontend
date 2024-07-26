class CurrentUserModel {
  String? username;
  List<String>?
      savedPlant; // Adjusted to List<String> to match the JSON structure
  String? password;
  String? fullName;

  CurrentUserModel(
      {this.username, this.savedPlant, this.password, this.fullName});

  factory CurrentUserModel.fromJson(Map<String, dynamic> json) {
    return CurrentUserModel(
      username: json['username'],
      savedPlant: json['saved_plants'] != null
          ? List<String>.from(json['saved_plants'])
          : null,
      password: json['password'],
      fullName: json['full_name'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    if (this.savedPlant != null) {
      data['saved_plants'] = this.savedPlant;
    }
    data['password'] = this.password;
    data['full_name'] = this.fullName;
    return data;
  }
}
