// Openapi Generator last run: : 2025-09-15T02:20:10.717244
import 'package:openapi_generator_annotations/openapi_generator_annotations.dart';

@Openapi(
  additionalProperties: DioProperties(
    pubName: 'akademove_api',
    pubAuthor: 'Rahmat Hidayatullah',
  ),
  inputSpec: RemoteSpec(
    path: 'https://akademove-server.zenta.dev/openapi.json',
  ),
  generatorName: Generator.dio,
  runSourceGenOnOutput: true,
  outputDirectory: 'api/akademove_api',
)
// ignore: unused_element this for build only
class _AkadeMoveAPI {}

@Openapi(
  additionalProperties: DioProperties(
    pubName: 'akademove_auth',
    pubAuthor: 'Rahmat Hidayatullah',
  ),
  inputSpec: InputSpec(
    path: 'auth-oapi.json',
  ),
  generatorName: Generator.dio,
  runSourceGenOnOutput: true,
  outputDirectory: 'api/akademove_auth',
)
// ignore: unused_element this for build only
class _AkadeMoveAuth {}