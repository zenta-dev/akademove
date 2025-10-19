import 'package:akademove/core/_export.dart';
import 'package:api_client/api_client.dart';

class OrderRepository extends BaseRepository {
  OrderRepository({required ApiClient apiClient}) : _apiClient = apiClient;

  final ApiClient _apiClient;
}
