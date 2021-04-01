class Fireball
{
	private ETHEntity@ m_entity;
	private FrameTimer m_frameTimer;
	private uint m_frameColumn = 0;

	Fireball(const string &in entityName, const vector2 &in originPos, const float lastDirectionX, const float speed = 10.0f)
	{	
		AddEntity(entityName, vector3(originPos.x + (lastDirectionX * 24.0f), originPos.y, -2.0f), 0.0f /*rotation*/, m_entity, "Fireball", 1.0f /*scale*/);

		//initial speed of the fireball	
		ETHPhysicsController@ physicsControllerBall = m_entity.GetPhysicsController();
		physicsControllerBall.SetLinearVelocity(vector2(lastDirectionX * speed, physicsControllerBall.GetLinearVelocity().y));
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

bool applyDamage(ETHEntity@ damagedEntity, const int team, const int damage)
{
	if(damagedEntity.CheckCustomData("hp") == DT_INT)
	{
		if(damagedEntity.GetInt("team") != team)
		{
			damagedEntity.AddToInt("hp", -damage);

			#if TESTING
				print(damagedEntity.GetInt("hp"));
				//print(damagedEntity.GetEntityName());
			#endif

			return true;
		}
	}
	return false;
}

void ETHBeginContactCallback_Fireball(
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

	if(applyDamage(other, thisEntity.GetInt("team"), thisEntity.GetInt("damage", 10)))
	{
		thisEntity.SetUInt("dead", 1);
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
}

void ETHCallback_Fireball(ETHEntity@ thisEntity)
{
	if(thisEntity.GetUInt("touchedVertical") != 0)
	{
		DeleteEntity(thisEntity);
	}

	else if(thisEntity.GetUInt("dead") != 0)
	{
		DeleteEntity(thisEntity);
	}
}
