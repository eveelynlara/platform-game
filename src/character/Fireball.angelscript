class Fireball
{
	private ETHEntity@ m_entity;
	private FrameTimer m_frameTimer;
	private uint m_frameColumn = 0;

	Fireball(const string &in entityName, vector2 pos, float caracterVelocityX, float directionLine)
	{	
		if(directionLine == 2)
		{
			directionLine = 5;
		}
		else if(directionLine == 1)
		{
			directionLine = -5;
		}

		AddEntity(entityName, vector3(pos.x + directionLine, pos.y, -2.0f), 0.0f /*rotation*/, m_entity, "Fireball", 1.0f /*scale*/);

		//initial speed of the fireball	
		ETHPhysicsController@ physicsControllerBall = m_entity.GetPhysicsController();
		physicsControllerBall.SetLinearVelocity(vector2(caracterVelocityX + directionLine, physicsControllerBall.GetLinearVelocity().y));
	}

	void update()
	{
		updateFrame();
		m_entity.SetFrame(m_frameColumn);
	}

	private void updateFrame()
	{
		m_frameTimer.update(0, 3, 55);
		m_frameColumn = m_frameTimer.getCurrentFrame();
	}
}

void ETHBeginContactCallback_Fireball(
	ETHEntity@ thisEntity,
	ETHEntity@ other,
	vector2 contactPointA,
	vector2 contactPointB,
	vector2 contactNormal)
{
	if (other.GetEntityName() == "wide_tile.ent" || other.GetEntityName() == "tile.ent" || other.GetEntityName() == "single_piece.ent")
	{
		if(utils::dot(contactNormal, vector2(1,0)) > abs(0.5f))
		{
			thisEntity.SetUInt("touchedVertical", 1);
		}
		//print(utils::dot(contactNormal, vector2(1,0)));
	}
}

void ETHCallback_Fireball(ETHEntity@ thisEntity)
{
	/*if(thisEntity.GetUInt("touchedVertical") == 1)
	{
		DeleteEntity(thisEntity);
	}*/
}