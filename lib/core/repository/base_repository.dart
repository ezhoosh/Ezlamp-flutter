import 'package:easy_lamp/core/network/i_api_request_manager.dart';

class BaseRepository {
  final IHttpClient httpClient;

  BaseRepository(this.httpClient);
}
