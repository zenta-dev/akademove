import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SvgTiledBackground extends StatelessWidget {
  const SvgTiledBackground({
    required this.asset,
    super.key,
    this.tileSize = 100,
    this.colorFilter,
  });
  final String asset;
  final double tileSize;
  final ColorFilter? colorFilter;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final rows = (size.height / tileSize).ceil();
    final cols = (size.width / tileSize).ceil();

    return Stack(
      children: [
        for (int row = 0; row < rows; row++)
          for (int col = 0; col < cols; col++)
            Positioned(
              left: col * tileSize,
              top: row * tileSize,
              child: SvgPicture.asset(
                asset,
                width: tileSize,
                height: tileSize,
                fit: BoxFit.cover,
                colorFilter: colorFilter,
              ),
            ),
      ],
    );
  }
}
