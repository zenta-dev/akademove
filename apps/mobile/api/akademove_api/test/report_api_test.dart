import 'package:test/test.dart';
import 'package:akademove_api/akademove_api.dart';

/// tests for ReportApi
void main() {
  final instance = AkademoveApi().getReportApi();

  group(ReportApi, () {
    //Future<CreateReportSuccessResponse> createReport({ CreateReportRequest createReportRequest }) async
    test('test createReport', () async {
      // TODO
    });

    //Future<DeleteReportSuccessResponse> deleteReport(String id) async
    test('test deleteReport', () async {
      // TODO
    });

    //Future<GetAllReportSuccessResponse> getAllReport(int page, int limit, { String cursor }) async
    test('test getAllReport', () async {
      // TODO
    });

    //Future<GetReportByIdSuccessResponse> getReportById(String id, bool fromCache) async
    test('test getReportById', () async {
      // TODO
    });

    //Future<UpdateReportSuccessResponse> updateReport(String id, { CreateReportRequest createReportRequest }) async
    test('test updateReport', () async {
      // TODO
    });
  });
}
