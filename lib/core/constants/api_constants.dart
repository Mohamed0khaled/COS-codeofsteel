/// API Constants
/// 
/// IMPORTANT: API keys should be moved to environment variables
/// before production deployment. This file currently serves as
/// a reference for the migration process.
/// 
/// TODO: Replace with flutter_dotenv or --dart-define in CI/CD

class ApiConstants {
  ApiConstants._();

  // Hugging Face API
  // WARNING: These should be moved to secure environment variables
  static const String huggingFaceBaseUrl = 'https://api-inference.huggingface.co/models';
  static const String huggingFaceModel = 'Qwen/Qwen2.5-Coder-32B-Instruct';
  
  // Timeouts
  static const Duration connectTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);
  
  // API Headers
  static const String contentTypeJson = 'application/json';
}
