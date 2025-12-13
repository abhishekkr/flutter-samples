import 'package:flame/components.dart';

// WORLD
const double worldGravity = 800.0;
const String bgSpriteFile = 'flappy-bird-background-day.png';
final Vector2 bgPosition = Vector2(0, 0);

//GROUND
const String groundSpriteFile = 'flappy-bird-ground.png';
const double groundHeight = 200;
const double groundScrollSpeed = 100;
const double groundOverlap = 150;
final Vector2 groundOriginalSize = Vector2(169, 55);

//PILLAR
const String pillarAboveSpriteFile = "flappy-bird-pillar-above.png";
const String pillarBelowSpriteFile = "flappy-bird-pillar-below.png";
const double pillarInterval = 3;
const double pillarGap = 150;
const double pillarMinHeight = 50;
const double pillarWidth = 60;

//PLAYER
const String playerSpriteFile = 'flappy-bird-player.png';
final Vector2 playerSpriteSize = Vector2(70, 45);
final Vector2 playerStartPosition = Vector2(100, 100);

// SCORE
int gameScore = 0;
final Vector2 scoreSize = Vector2(25, 25);
