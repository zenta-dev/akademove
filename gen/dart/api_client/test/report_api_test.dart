import 'package:test/test.dart';
import 'package:api_client/api_client.dart';

/// tests for ReportApi
void main() {
  final instance = ApiClient().getReportApi();

  group(ReportApi, () {
    //Future<ReportCreate200Response> reportCreate(InsertReport insertReport) async
    test('test reportCreate', () async {
      // TODO
    });

    //Future<ReportCreate200Response> reportDismiss(String id, DismissReport dismissReport) async
    test('test reportDismiss', () async {
      // TODO
    });

    //Future<ReportCreate200Response> reportGet(String id) async
    test('test reportGet', () async {
      // TODO
    });

    //Future<ReportList200Response> reportList({ String cursor, Object limit, String direction, Object page, String query, String sortBy, PaginationOrder order, PaginationMode mode }) async
    test('test reportList', () async {
      // TODO
    });

    //Future<BadgeRemove200Response> reportRemove(String id) async
    test('test reportRemove', () async {
      // TODO
    });

    //Future<ReportCreate200Response> reportResolve(String id, ResolveReport resolveReport) async
    test('test reportResolve', () async {
      // TODO
    });

    //Future<ReportCreate200Response> reportStartInvestigation(String id, StartInvestigation startInvestigation) async
    test('test reportStartInvestigation', () async {
      // TODO
    });

    //Future<ReportCreate200Response> reportUpdate(String id, UpdateReport updateReport) async
    test('test reportUpdate', () async {
      // TODO
    });
  });
}
