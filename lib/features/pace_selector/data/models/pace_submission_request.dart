class PaceSubmissionRequest {
  const PaceSubmissionRequest({required this.paceSeconds});

  final int paceSeconds;

  Map<String, dynamic> toJson() => {'pace_seconds': paceSeconds};
}
