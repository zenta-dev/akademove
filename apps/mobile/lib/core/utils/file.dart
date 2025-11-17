import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

Future<File?> downloadImage(String url, {String? filename}) async {
  final uri = Uri.tryParse(url);
  if (uri == null || !uri.hasScheme || !uri.hasAuthority) {
    return null;
  }

  try {
    final response = await http.get(uri);
    if (response.statusCode != 200) {
      return null;
    }

    final dir = await getTemporaryDirectory();
    final name = filename ?? DateTime.now().millisecondsSinceEpoch.toString();
    final filePath = '${dir.path}/$name';

    final file = File(filePath);
    await file.writeAsBytes(response.bodyBytes);

    return file;
  } catch (_) {
    return null;
  }
}
