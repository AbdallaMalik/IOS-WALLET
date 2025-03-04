import 'package:flutter_dotenv/flutter_dotenv.dart';

final appName = dotenv.env['APP_NAME'] ?? "";
final baseApiUrl = dotenv.env['BASE_API_URL'] ?? "";
final baseUrlAdmin = "$baseApiUrl/api/admin";
