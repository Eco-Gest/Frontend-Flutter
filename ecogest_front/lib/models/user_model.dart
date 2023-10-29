class UserModel {
  final int? id;
  final String? email;
  final String? username;
  final int? badgeId;
  final String? badgeTitle;
  final String? image;
  final String? birthdate;
  final String? biography;
  final String? position;
  final bool? isPrivate;
  final String? createdAt;
  final String? updatedAt;

  const UserModel({
    this.id,
    this.email,
    this.username,
    this.badgeId,
    this.badgeTitle,
    this.image,
    this.birthdate,
    this.biography,
    this.position,
    this.isPrivate,
    this.createdAt,
    this.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json['id'] != null ? int.parse(json['id'].toString()) : null,
        email: json['email']?.toString(),
        username: json['username']?.toString(),
        badgeId: json['badge_id'] != null
            ? int.parse(json['badge_id'].toString())
            : null,
        badgeTitle: json['badge']?['title']?.toString(),
        image: json['image']?.toString(),
        birthdate: json['birthdate']?.toString(),
        biography: json['biography']?.toString(),
        position: json['position']?.toString(),
        isPrivate: json['is_private']?.toString() == "true" ? true : false,
        createdAt: json['create_at']?.toString(),
        updatedAt: json['updated_at']?.toString(),
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["username"] = username;
    data["image"] = image;
    data["birthdate"] = birthdate;
    data["biography"] = biography;
    data["position"] = position;
    data["is_private"] = isPrivate;
    return data;
  }
}
