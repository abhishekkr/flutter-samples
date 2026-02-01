import 'dart:ui' as ui;

import 'package:flame/extensions.dart';
import 'package:flame/sprite.dart';
import 'package:xml/xpath.dart';
import 'package:xml/xml.dart';

class XmlSpriteSheet {
  XmlSpriteSheet(this.image, String xml) {
    final doc = XmlDocument.parse(xml);
    for (final node in doc.xpath('//TextureAtlas/SubTexture')) {
      final name = node.getAttribute('name')!;
      final x = double.parse(node.getAttribute('x')!);
      final y = double.parse(node.getAttribute('y')!);
      final width = double.parse(node.getAttribute('width')!);
      final height = double.parse(node.getAttribute('height')!);
      _rects[name] = Rect.fromLTWH(x, y, width, height);
    }
  }

  final ui.Image image;
  final _rects = <String, Rect>{};

  Sprite getSprite(String name) {
    final rect = _rects[name];
    if (rect == null) {
      throw ArgumentError('Sprite $name not found.');
    }
    return Sprite(
      image,
      srcPosition: rect.topLeft.toVector2(),
      srcSize: rect.size.toVector2(),
    );
  }
}
