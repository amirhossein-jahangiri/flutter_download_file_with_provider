import 'package:http/http.dart' as http;

// This class for get file from server (Rest Api)

class RestApiServices {
  static Future<http.StreamedResponse> getFile(String url) async {
    http.Request request = http.Request('GET', Uri.parse(url));
    http.StreamedResponse response = await http.Client().send(request);
    return response;
  }
}