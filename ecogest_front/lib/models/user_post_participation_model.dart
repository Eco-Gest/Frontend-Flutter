class UserPostParticipationModel {
  final int? id;
  final int? postId;
  final int? participantId;
  final bool? isCompleted;
  final String? createdAt;
  final String? updatedAt;

  const UserPostParticipationModel({
    required this.id,
    required this.postId,
    required this.participantId,
    required this.isCompleted,
    this.createdAt,
    this.updatedAt,
  });

  factory UserPostParticipationModel.fromJson(Map<String, dynamic> json) => UserPostParticipationModel(
        id: json['id'] != null ? int.parse(json['id'].toString()) : null,
        postId: json['post_id'] != null ? int.parse(json['post_id'].toString()) : null,
        participantId: json['participant_id'] != null ? int.parse(json['participant_id'].toString()) : null,
        isCompleted: json['is_completed']?.toString()== "true"? true : false,
        createdAt: json['create_at']?.toString(),
        updatedAt: json['updated_at']?.toString(),
      );
  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'post_id': postId,
      'participant_id': participantId,
      'is_completed': isCompleted,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
