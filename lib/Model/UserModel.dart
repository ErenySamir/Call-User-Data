class UserModel {
  final List<UserData> data;
  final int page;
  final int perPage;
  final int total;
  final int totalPages;

  UserModel({
    required this.data,
    required this.page,
    required this.perPage,
    required this.total,
    required this.totalPages,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    var list = json['data'] as List;
    List<UserData> userList = list.map((i) => UserData.fromJson(i)).toList();

    return UserModel(
      data: userList,
      page: json['page'],
      perPage: json['per_page'],
      total: json['total'],
      totalPages: json['total_pages'],
    );
  }
}

class UserData {
  final int id;
  final String email;
  final String firstName;
  final String lastName;
  final String avatar;

  UserData({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.avatar,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json['id'],
      email: json['email'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      avatar: json['avatar'],
    );
  }
}