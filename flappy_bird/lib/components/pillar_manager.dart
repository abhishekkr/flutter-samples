import 'dart:math';

import 'package:flame/components.dart';
import 'package:flappy_bird/components/pillar.dart';
import 'package:flappy_bird/flapppy_bird_game.dart';
import 'package:flappy_bird/globalvars.dart';

class PillarManager extends Component with HasGameReference<FlapppyBirdGame> {
  double pillarSpawnTimer = 0;

  @override
  void update(double dt) {
    pillarSpawnTimer += dt;
    if (pillarSpawnTimer > pillarInterval) {
      pillarSpawnTimer = 0;
      spawnPillar();
    }
    super.update(dt);
  }

  void spawnPillar() {
    final double pillarMaxHeight =
        game.size.y - groundHeight - pillarGap - pillarMinHeight;

    final double bottomPillarHeight =
        pillarMinHeight +
        (Random().nextDouble() * (pillarMaxHeight - pillarMinHeight));
    final Vector2 bottomPillarPos = Vector2(
      game.size.x,
      game.size.y - groundHeight - bottomPillarHeight,
    );
    final Vector2 bottomPillarSize = Vector2(pillarWidth, bottomPillarHeight);

    final double topPillarHeight =
        game.size.y - groundHeight - pillarGap - bottomPillarHeight;
    final Vector2 topPillarPos = Vector2(game.size.x, 0);
    final Vector2 topPillarSize = Vector2(pillarWidth, topPillarHeight);

    final bottomPillar = Pillar(
      bottomPillarPos,
      bottomPillarSize,
      isTopPillar: false,
    );
    final topPillar = Pillar(topPillarPos, topPillarSize, isTopPillar: true);

    game.add(bottomPillar);
    game.add(topPillar);
  }
}
