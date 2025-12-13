// Different Enemies' Data as Enum Types
enum EnemyType {
  angrypig(
    'angrypig-walk-36x30.png',
    'angrypig-hit-36x30.png',
    0,
    15,
    0,
    4,
    275,
    36,
    30,
    1.0,
  ),
  bat(
    'bat-flying-46x30.png',
    'bat-hit-46x30.png',
    0,
    5,
    0,
    4,
    205,
    46,
    30,
    0.6,
  ),
  chameleon(
    'chameleon-run-84x38.png',
    'chameleon-hit-84x38.png',
    0,
    7,
    0,
    4,
    195,
    84,
    38,
    0.9,
  ),
  rhino(
    'rhino-run-52x34.png',
    'rhino-hit-52x34.png',
    0,
    5,
    0,
    3,
    175,
    52,
    34,
    1.2,
  );

  final String runSpriteImage;
  final String hitSpriteImage;
  final int runSpriteRow;
  final int runSpriteColumns;
  final int hitSpriteRow;
  final int hitSpriteColumns;
  final int xSpeed;
  final double textureX;
  final double textureY;
  final double scaleFactor;

  const EnemyType(
    this.runSpriteImage,
    this.hitSpriteImage,
    this.runSpriteRow,
    this.runSpriteColumns,
    this.hitSpriteRow,
    this.hitSpriteColumns,
    this.xSpeed,
    this.textureX,
    this.textureY,
    this.scaleFactor,
  );
}
