import 'dart:convert';

class Report {
  final String id;
  final String userId;
  final String initialDescription;
  final String initialImage;
  final String startedAt;
  final String finalDescription;
  final String finalImage;
  final String stopedAt;
  final bool finished;
  Report({
    required this.id,
    required this.userId,
    required this.initialDescription,
    required this.initialImage,
    required this.startedAt,
    required this.finalDescription,
    required this.finalImage,
    required this.stopedAt,
    required this.finished,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'initialDescription': initialDescription,
      'initialImage': initialImage,
      'startedAt': startedAt,
      'finalDescription': finalDescription,
      'finalImage': finalImage,
      'stopedAt': stopedAt,
      'finished': finished,
    };
  }

  factory Report.fromMap(Map<String, dynamic> map) {
    return Report(
      id: map['id'] ?? '',
      userId: map['userId'] ?? '',
      initialDescription: map['initialDescription'] ?? '',
      initialImage: map['initialImage'] ?? '',
      startedAt: map['startedAt'] ?? '',
      finalDescription: map['finalDescription'] ?? '',
      finalImage: map['finalImage'] ?? '',
      stopedAt: map['stopedAt'] ?? '',
      finished: map['finished'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory Report.fromJson(String source) => Report.fromMap(json.decode(source));

  Report copyWith({
    String? id,
    String? userId,
    String? initialDescription,
    String? initialImage,
    String? startedAt,
    String? finalDescription,
    String? finalImage,
    String? stopedAt,
    bool? finished,
  }) {
    return Report(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      initialDescription: initialDescription ?? this.initialDescription,
      initialImage: initialImage ?? this.initialImage,
      startedAt: startedAt ?? this.startedAt,
      finalDescription: finalDescription ?? this.finalDescription,
      finalImage: finalImage ?? this.finalImage,
      stopedAt: stopedAt ?? this.stopedAt,
      finished: finished ?? this.finished,
    );
  }
}
