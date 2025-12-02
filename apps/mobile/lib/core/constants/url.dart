abstract class UrlConstants {
  static const randomImageUrl = 'https://picsum.photos';

  static const apiProtocol = 'http://';
  static const apiDomain = '10.86.19.105';
  static const apiPort = ':3000';
  static const apiBaseUrl = '$apiProtocol$apiDomain$apiPort/api';

  static const wsProtocol = 'ws://';
  static const String wsDomain = apiDomain;
  static const String wsPort = apiPort;
  static const wsBaseUrl = '$wsProtocol$wsDomain$apiPort/ws';

  static const placeholderImageUrl =
      '$apiProtocol$apiDomain$apiPort/no-image.svg';
}
