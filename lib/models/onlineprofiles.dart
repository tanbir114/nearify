class Profiles {
  const Profiles({
    required this.id,
    required this.username,
    required this.img,
    required this.tags,
  });

  final int id;
  final String username;
  final String img;
  final List<String> tags;
}