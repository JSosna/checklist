class ChecklistSettings {
  final bool isBiometricsActive;

  ChecklistSettings({required this.isBiometricsActive});

  ChecklistSettings copyWith({
    bool? isBiometricsActive,
  }) =>
      ChecklistSettings(
        isBiometricsActive: isBiometricsActive ?? this.isBiometricsActive,
      );
}
