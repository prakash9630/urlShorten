

import 'package:dio/dio.dart';

class ShortLinkRepo{
  Future<String?> shortenUrl(String urlToShorten) async {
    const String apiKey = '87cf73a455d74ec2bad83db761a14eca';
    const String endpoint = 'https://api.rebrandly.com/v1/links';

    try {
      final dio = Dio();
      final response = await dio.post(
        endpoint,
        data: {
          'destination': urlToShorten,
          'domain': {'fullName': 'rebrand.ly'}
        },
        options: Options(headers: {'apikey': apiKey}),
      );

      if (response.statusCode == 200) {
        return response.data['shortUrl'];
      } else {
        return 'Failed to shorten URL: ${response.data}';
      }
    } catch (e) {
      return 'Error: $e';
    }
  }
}