void ETHCallback_spawner(ETHEntity@ thisEntity)
{
	Character@ m_npcFollower;

    if (utils::isWorldSpacePointInScreenWithTolerance(thisEntity.GetPositionXY(), vector2(128.0f, 64.0f)))
    {      
    	@m_npcFollower = Character("flameDragon.ent", thisEntity.GetPositionXY());
    	
        DeleteEntity(thisEntity);
    }
}