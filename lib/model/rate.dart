class Rate {
  final dynamic id;
  final dynamic user_id;
  final dynamic rating;
  final dynamic material_id;
  final String remark;
  final dynamic channel_id;
  final dynamic created_at;
  final dynamic updated_at;

  Rate({
    required this.id,
    required this.channel_id,
    required this.material_id,
    required this.rating,
    required this.remark,
    required this.user_id,
    required this.created_at,
    required this.updated_at,
  });
  factory Rate.fromJson(dynamic json) {
    return Rate(
      id: json['id'],
      // channel_id: json['channel_id'],
      channel_id: json['channel_id'],
      material_id: json['material_id'],
      remark: json['remark'].toString(),
      rating: json['rating'],
      user_id: json['user_id'].toString(),
      created_at: json['created_at'],
      updated_at: json['updated_at'],
    );
  }
}
