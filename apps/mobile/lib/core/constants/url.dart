abstract class UrlConstants {
  static const randomImageUrl = 'https://picsum.photos';

  static const apiProtocol = 'https://';
  static const apiDomain = 'server.akademove.com';
  static const apiPort = '';
  static const apiBaseUrl = '$apiProtocol$apiDomain$apiPort/api';

  static const wsProtocol = 'wss://';
  static const String wsDomain = apiDomain;
  static const String wsPort = apiPort;
  static const wsBaseUrl = '$wsProtocol$wsDomain$apiPort/ws';

  static const placeholderImageUrl =
      '$apiProtocol$apiDomain$apiPort/no-image.svg';
}
