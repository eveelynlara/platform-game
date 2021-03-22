#include "src/scene-manager/Scene.angelscript"
#include "src/scene-manager/SceneManager.angelscript"

#include "src/game-state/MainMenuScene.angelscript"
#include "src/game-state/GameScene.angelscript"

#include "src/utils/Button.angelscript"
#include "src/utils/FrameTimer.angelscript"
#include "src/utils/isPointInRect.angelscript"
#include "src/utils/MathUtils.angelscript"

#include "src/character/Character.angelscript"
#include "src/character/CharacterController.angelscript"
#include "src/character/DummyController.angelscript"
#include "src/character/MainCharacterController.angelscript"
#include "src/character/NPCFollowPlayerController.angelscript"
#include "src/character/NPCPatrolController.angelscript"
#include "src/character/Fireball.angelscript"

#include "src/gameplay/CameraController.angelscript"
#include "src/gameplay/CharacterCameraController.angelscript"
#include "src/gameplay/CharactersManager.angelscript"
#include "src/gameplay/FireballsManager.angelscript"
#include "src/gameplay/MoveBackground.angelscript"
#include "src/gameplay/StaticCameraController.angelscript"
#include "src/gameplay/Spawner.angelscript"

void main()
{
	SetFixedHeight(480.0f);

	g_sceneManager.setCurrentScene(MainMenuScene());
}
