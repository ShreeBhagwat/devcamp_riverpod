class AppUser {
  final String id;
  final String email;
  final String name;
  final String? photoUrl;
  final bool? isDeleted;

  AppUser({
    required this.id,
    required this.email,
    required this.name,
    this.photoUrl,
    this.isDeleted,
  });

  factory AppUser.fromMap(Map<String, dynamic> data) {
    final String id = data['id'];
    final String email = data['email'];
    final String name = data['name'];
    final String? photoUrl = data['photoUrl'];
    final bool? isDeleted = data['isDeleted'];

    return AppUser(
      id: id,
      email: email,
      name: name,
      photoUrl: photoUrl,
      isDeleted: isDeleted,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'photoUrl': photoUrl,
      'isDeleted': isDeleted,
    };
  }
}
