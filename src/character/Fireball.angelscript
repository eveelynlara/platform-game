class Fireball
{
	private ETHEntity@ m_entity;
	private FrameTimer m_frameTimer;
	private uint m_frameColumn = 0;

	Fireball(const string &in entityName, const vector2 &in originPos, const float &in directionLineX, const float speed = 5.0f)
	{	
		//print(directionLineX);
		AddEntity(entityName, vector3(originPos.x + (directionLineX * 24.0f), originPos.y, -2.0f), 0.0f /*rotation*/, m_entity, "Fireball", 1.0f /*scale*/);

		//initial speed of the fireball	
		ETHPhysicsController@ physicsControllerBall = m_entity.GetPhysicsController();
		physicsControllerBall.SetLinearVelocity(vector2(directionLineX * speed, physicsControllerBall.GetLinearVelocity().y));

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

/*void ETHBeginContactCallback_Fireball(
	ETHEntity@ thisEntity,
	ETHEntity@ other,
	vector2 contactPointA,
	vector2 contactPointB,
	vector2 contactNormal)
{
	if (other.GetEntityName() != "Character")
	{
		float isVertical = utils::dot(contactNormal, vector2(1,0));
		if(abs(isVertical) > 0.1)
		{
			thisEntity.SetUInt("touchedVertical", 1);
		}
	}
	else
	{
		print(other.GetInt("team", -1));
	}
}

void ETHPreSolveContactCallback_fireball(
	ETHEntity@ thisEntity,
	ETHEntity@ other,
	vector2 contactPointA,
	vector2 contactPointB,
	vector2 contactNormal)
{
	if (thisEntity.GetInt("team") == other.GetInt("team", -1))
	{
		DisableContact();
	}
	/*else
	{
		aplicaDano();
	}
}

void ETHCallback_Fireball(ETHEntity@ thisEntity)
{
	if(thisEntity.GetUInt("touchedVertical") != 0)
	{
		DeleteEntity(thisEntity);
	}
}
*/