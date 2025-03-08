import 'package:hr/core/di/di.dart';
import 'package:hr/core/helpers/cache/shared_preferences/cache_helper.dart';

import 'helpers/cache/cache_keys.dart';

bool isDark = sl<CacheHelper>().getBool(key: CacheKeys.isDark) ?? false;
