import 'package:packages/packages.dart' show Equatable;

@Equatable(stringify: true) // stringify for above use case
final class ServerException implements Exception {
  const ServerException();
}

@Equatable(stringify: true) // stringify for above use case
final class CacheException implements Exception {
  const CacheException();
}

@Equatable(stringify: true) // stringify for above use case
final class AuthException implements Exception {
  const AuthException();
}

@Equatable(stringify: true) // stringify for above use case
final class EmptyException implements Exception {
  const EmptyException();
}

@Equatable(stringify: true) // stringify for above use case
final class DuplicateEmailException implements Exception {
  const DuplicateEmailException();
}
