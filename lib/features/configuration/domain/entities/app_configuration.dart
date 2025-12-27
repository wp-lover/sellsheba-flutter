// features/configuration/domain/entities/app_configuration.dart
class AppConfiguration {
  final String baseUrl;

  const AppConfiguration({required this.baseUrl});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppConfiguration &&
          runtimeType == other.runtimeType &&
          baseUrl == other.baseUrl;

  @override
  int get hashCode => baseUrl.hashCode;
}
