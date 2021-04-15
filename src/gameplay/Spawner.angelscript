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
    	Character@ npc;
		const string controllerType = thisEntity.GetString("controller");
		CharacterController@ controller;

		if (controllerType == "flameDragon")
		{
		    @npc = Character("flameDragon.ent", thisEntity.GetPositionXY());
		    npc.setController(NPCFollowPlayerController(myGameScene.getMainCharacter()));
		    npc.getEntity().SetInt("team", 2);
		    npc.getEntity().SetInt("hp", 30);
		}
		else if(controllerType == "dummyDragon")
		{
			@npc = Character("flameDragon.ent", thisEntity.GetPositionXY());
			npc.setController(NPCPatrolController());
			npc.getEntity().SetInt("team", 2);
		    npc.getEntity().SetInt("hp", 30);
		}

		CharactersManager@ charactersManager = myGameScene.getCharactersManager();
		charactersManager.addCharacter(@npc);

		DeleteEntity(thisEntity);
    }
}