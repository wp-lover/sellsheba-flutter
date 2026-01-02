// core/services/site_url_manager.dart

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SiteUrlManager {
  static final SiteUrlManager _instance = SiteUrlManager._internal();
  factory SiteUrlManager() => _instance;
  SiteUrlManager._internal();

  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  static const String _key = 'site_base_url';

  String? _cachedUrl;

  /// Get the current site URL (from cache or storage)
  Future<String?> getBaseUrl() async {
    if (_cachedUrl != null) return _cachedUrl;

    final url = await _secureStorage.read(key: _key);
    if (url != null && url.isNotEmpty) {
      _cachedUrl = _normalizeUrl(url);
    }
    return _cachedUrl;
  }

  /// Save new site URL and update cache
  Future<void> setBaseUrl(String url) async {
    final normalized = _normalizeUrl(url);
    await _secureStorage.write(key: _key, value: normalized);
    _cachedUrl = normalized;
  }

  /// Clear URL (e.g., on logout or reconfiguration)
  Future<void> clear() async {
    await _secureStorage.delete(key: _key);
    _cachedUrl = null;
  }

  /// Normalize URL: add https:// and trailing slash
  String _normalizeUrl(String url) {
    String cleaned = url.trim();
    if (!cleaned.startsWith('http://') && !cleaned.startsWith('https://')) {
      cleaned = 'https://$cleaned';
    }
    if (!cleaned.endsWith('/')) {
      cleaned += '/';
    }
    return cleaned;
  }

  /// Check if configured
  Future<bool> isConfigured() async {
    return await getBaseUrl() != null;
  }
}
