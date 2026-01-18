import 'package:iserve/src/src.dart';

class LocalStorageService {
  static String username = "";
  static String profileImage = "";
  static String email = "";
  static int uid = 0;
  static bool isCoach = false;

  static final LocalStorageService _instance = LocalStorageService._internal();
  factory LocalStorageService() => _instance;
  LocalStorageService._internal();

  static const SharedPreferences _storage = SharedPreferences;

  /// Save entire LoginResponse (after login)
  static Future<void> saveLoginResponse(LoginResponse response) async {
    final jsonString = jsonEncode(response.toJson());
    await _storage.write(key: AppConstants.userDetailKey, value: jsonString);
  }

  /// Get entire LoginResponse object
  static Future<LoginResponse?> getLoginResponse() async {
    final jsonString = await _storage.read(key: AppConstants.userDetailKey);
    if (jsonString == null) return null;
    final jsonMap = jsonDecode(jsonString) as Map<String, dynamic>;
    return LoginResponse.fromJson(jsonMap);
  }

  static void getUserInfo(LoginData data) {
    final user = data.user;
    username = user?.name ?? "";
    profileImage = user?.profileImage ?? "";
    email = user?.email ?? "";
    isCoach = data.coach ?? false;
    uid = user?.id ?? 0;
  }

  /// Extract token directly from stored LoginResponse
  static Future<String?> getToken() async {
    final loginResponse = await getLoginResponse();
    return loginResponse?.data?.token;
  }

  /// Clear user data (e.g. logout)
  static Future<void> clearUser() async {
    username = "";
    profileImage = "";
    email = "";
    isCoach = false;
    uid = -1;
    await _storage.delete(key: AppConstants.userDetailKey);
  }
}
