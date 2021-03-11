void ETHCallback_spawner(ETHEntity@ thisEntity)
{
	GameScene@ myGameScene = cast<GameScene>(g_sceneManager.getCurrentScene());
	if (myGameScene is null)
	{
		print("Erro: aparentemente a cena atual não é GameScene. Talvez seja MainMenuScene?");
		return;
	}

	if (utils::isWorldSpacePointInScreenWithTolerance(thisEntity.GetPositionXY(), vector2(128.0f, 64.0f)))
    {      
    	Character@ npcFollower = Character("flameDragon.ent", thisEntity.GetPositionXY());
		CharactersManager@ charactersManager = myGameScene.getCharactersManager();
		charactersManager.addCharacter(@npcFollower);
		npcFollower.setController(NPCFollowPlayerController(myGameScene.getMainCharacter()));

        DeleteEntity(thisEntity);
    }
}