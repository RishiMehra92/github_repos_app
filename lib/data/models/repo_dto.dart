import '../../domain/entities/repo.dart';

class RepoDto {
  final String name;
  final String description;

  RepoDto({required this.name, required this.description});

  factory RepoDto.fromJson(Map<String, dynamic> json) {
    return RepoDto(name: json['name'], description: json['description'] ?? '');
  }

  Repo toEntity() => Repo(name: name, description: description);
}
