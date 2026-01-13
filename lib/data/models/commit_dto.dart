import '../../domain/entities/commit.dart';

class CommitDto {
  final String message;

  CommitDto(this.message);

  factory CommitDto.fromJson(Map<String, dynamic> json) {
    return CommitDto(json['commit']['message']);
  }

  Commit toEntity() => Commit(message);
}
