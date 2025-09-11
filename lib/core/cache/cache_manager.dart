// lib/core/cache/cache_manager.dart

abstract class CacheManager {
  Future<bool> isCacheValid(DateTime? lastCacheTime, {Duration? maxAge});
  Duration get defaultCacheExpiry;
  Future<void> clearAllCache();
}

class CacheManagerImpl implements CacheManager {
  @override
  Duration get defaultCacheExpiry => const Duration(hours: 24); // 24 hours

  @override
  Future<bool> isCacheValid(DateTime? lastCacheTime, {Duration? maxAge}) async {
    if (lastCacheTime == null) return false;

    final expiry = maxAge ?? defaultCacheExpiry;
    final now = DateTime.now();
    final difference = now.difference(lastCacheTime);

    final isValid = difference <= expiry;
    print('Cache validity check: ${isValid ? 'Valid' : 'Expired'} - Age: ${difference.inHours}h');

    return isValid;
  }

  @override
  Future<void> clearAllCache() async {
    // TODO
    // Implementation depends on your caching strategy
    // This could clear all Hive boxes or specific cache directories
    print('Clearing all cache...');
  }
}