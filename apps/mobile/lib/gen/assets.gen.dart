// dart format width=80

/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: deprecated_member_use,directives_ordering,implicit_dynamic_list_literal,unnecessary_import

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart' as _svg;
import 'package:vector_graphics/vector_graphics.dart' as _vg;

class $AssetsIconsGen {
  const $AssetsIconsGen();

  /// File path: assets/icons/brand.svg
  SvgGenImage get brand => const SvgGenImage('assets/icons/brand.svg');

  /// List of all assets
  List<SvgGenImage> get values => [brand];
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// Directory path: assets/images/bg
  $AssetsImagesBgGen get bg => const $AssetsImagesBgGen();

  /// File path: assets/images/brand.svg
  SvgGenImage get brand => const SvgGenImage('assets/images/brand.svg');

  /// Directory path: assets/images/character
  $AssetsImagesCharacterGen get character => const $AssetsImagesCharacterGen();

  /// Directory path: assets/images/hero
  $AssetsImagesHeroGen get hero => const $AssetsImagesHeroGen();

  /// List of all assets
  List<SvgGenImage> get values => [brand];
}

class $AssetsImagesBgGen {
  const $AssetsImagesBgGen();

  /// File path: assets/images/bg/sign-in.svg
  SvgGenImage get signIn => const SvgGenImage('assets/images/bg/sign-in.svg');

  /// List of all assets
  List<SvgGenImage> get values => [signIn];
}

class $AssetsImagesCharacterGen {
  const $AssetsImagesCharacterGen();

  /// File path: assets/images/character/driver.svg
  SvgGenImage get driver =>
      const SvgGenImage('assets/images/character/driver.svg');

  /// File path: assets/images/character/merchant.svg
  SvgGenImage get merchant =>
      const SvgGenImage('assets/images/character/merchant.svg');

  /// File path: assets/images/character/user.svg
  SvgGenImage get user => const SvgGenImage('assets/images/character/user.svg');

  /// List of all assets
  List<SvgGenImage> get values => [driver, merchant, user];
}

class $AssetsImagesHeroGen {
  const $AssetsImagesHeroGen();

  /// File path: assets/images/hero/sign-up-driver-1.png
  AssetGenImage get signUpDriver1 =>
      const AssetGenImage('assets/images/hero/sign-up-driver-1.png');

  /// File path: assets/images/hero/sign-up-driver-2.png
  AssetGenImage get signUpDriver2 =>
      const AssetGenImage('assets/images/hero/sign-up-driver-2.png');

  /// File path: assets/images/hero/sign-up-driver-3.png
  AssetGenImage get signUpDriver3 =>
      const AssetGenImage('assets/images/hero/sign-up-driver-3.png');

  /// File path: assets/images/hero/sign-up-driver-4.png
  AssetGenImage get signUpDriver4 =>
      const AssetGenImage('assets/images/hero/sign-up-driver-4.png');

  /// File path: assets/images/hero/sign-up-merchant-1.png
  AssetGenImage get signUpMerchant1 =>
      const AssetGenImage('assets/images/hero/sign-up-merchant-1.png');

  /// File path: assets/images/hero/sign-up-merchant-2.png
  AssetGenImage get signUpMerchant2 =>
      const AssetGenImage('assets/images/hero/sign-up-merchant-2.png');

  /// File path: assets/images/hero/sign-up-merchant-3.png
  AssetGenImage get signUpMerchant3 =>
      const AssetGenImage('assets/images/hero/sign-up-merchant-3.png');

  /// File path: assets/images/hero/sign-up-merchant-4.png
  AssetGenImage get signUpMerchant4 =>
      const AssetGenImage('assets/images/hero/sign-up-merchant-4.png');

  /// File path: assets/images/hero/sign-up-user.svg
  SvgGenImage get signUpUser =>
      const SvgGenImage('assets/images/hero/sign-up-user.svg');

  /// List of all assets
  List<dynamic> get values => [
    signUpDriver1,
    signUpDriver2,
    signUpDriver3,
    signUpDriver4,
    signUpMerchant1,
    signUpMerchant2,
    signUpMerchant3,
    signUpMerchant4,
    signUpUser,
  ];
}

class Assets {
  const Assets._();

  static const $AssetsIconsGen icons = $AssetsIconsGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
    this.animation,
  });

  final String _assetName;

  final Size? size;
  final Set<String> flavors;
  final AssetGenImageAnimation? animation;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = true,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.medium,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({AssetBundle? bundle, String? package}) {
    return AssetImage(_assetName, bundle: bundle, package: package);
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

class AssetGenImageAnimation {
  const AssetGenImageAnimation({
    required this.isAnimation,
    required this.duration,
    required this.frames,
  });

  final bool isAnimation;
  final Duration duration;
  final int frames;
}

class SvgGenImage {
  const SvgGenImage(this._assetName, {this.size, this.flavors = const {}})
    : _isVecFormat = false;

  const SvgGenImage.vec(this._assetName, {this.size, this.flavors = const {}})
    : _isVecFormat = true;

  final String _assetName;
  final Size? size;
  final Set<String> flavors;
  final bool _isVecFormat;

  _svg.SvgPicture svg({
    Key? key,
    bool matchTextDirection = false,
    AssetBundle? bundle,
    String? package,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    AlignmentGeometry alignment = Alignment.center,
    bool allowDrawingOutsideViewBox = false,
    WidgetBuilder? placeholderBuilder,
    String? semanticsLabel,
    bool excludeFromSemantics = false,
    _svg.SvgTheme? theme,
    _svg.ColorMapper? colorMapper,
    ColorFilter? colorFilter,
    Clip clipBehavior = Clip.hardEdge,
    @deprecated Color? color,
    @deprecated BlendMode colorBlendMode = BlendMode.srcIn,
    @deprecated bool cacheColorFilter = false,
  }) {
    final _svg.BytesLoader loader;
    if (_isVecFormat) {
      loader = _vg.AssetBytesLoader(
        _assetName,
        assetBundle: bundle,
        packageName: package,
      );
    } else {
      loader = _svg.SvgAssetLoader(
        _assetName,
        assetBundle: bundle,
        packageName: package,
        theme: theme,
        colorMapper: colorMapper,
      );
    }
    return _svg.SvgPicture(
      loader,
      key: key,
      matchTextDirection: matchTextDirection,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
      placeholderBuilder: placeholderBuilder,
      semanticsLabel: semanticsLabel,
      excludeFromSemantics: excludeFromSemantics,
      colorFilter:
          colorFilter ??
          (color == null ? null : ColorFilter.mode(color, colorBlendMode)),
      clipBehavior: clipBehavior,
      cacheColorFilter: cacheColorFilter,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
