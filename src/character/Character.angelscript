class Character
{
	private ETHEntity@ m_entity;

	private FrameTimer m_frameTimer;
	private uint m_directionLine = 2;
	private float m_lastDirectionX = 1;
	private uint m_frameColumn = 0;
	private bool m_touchingGround = false;
	private int m_jumpInTheAirCount = 0;
	private int m_maxJumpsInTheAir = 10;
	private float m_movementSpeed;

	private CharacterController@ m_characterController = DummyController();
	private Fireball@ fireball;
	private FireballsManager m_fireballsManager;
	
	Character(const string &in entityName, const vector2 pos)
	{
		// add character entity and rename it to "character" for matching character-
		// specific entity callback functions
		AddEntity(entityName, vector3(pos, -2.0f), 0.0f /*rotation*/, m_entity, "Character", 1.0f /*scale*/);
	}
	
	void setController(CharacterController@ characterController)
	{
		@m_characterController = @characterController;
	}

	void update()
	{
		m_characterController.update(@this);
		m_fireballsManager.update();
	
		ETHPhysicsController@ physicsController = m_entity.GetPhysicsController();

		// never let character body sleep
		physicsController.SetAwake(true);

		checkGroundTouch();
		updateMovement(@physicsController, m_characterController.getMovementSpeed());
		updateJumpImpulse(@physicsController, m_characterController.getJumpImpulse());

		// update entity animation frame
		m_entity.SetFrame(m_frameColumn, m_directionLine);

		if (m_characterController.fireState() == KS_HIT)
		{
			@fireball = Fireball("fireball.ent", m_entity.GetInt("team"), m_entity.GetPositionXY(), m_lastDirectionX);
			m_fireballsManager.addFireball(@fireball);

			PlaySample("soundfx/explosion_small.mp3");
		}
	}

	CharacterController@ getCharacterController()
	{
		return @m_characterController;
	}

	bool isTouchingGround() const
	{
		return m_touchingGround;
	}
	
	vector2 getPosition()
	{
		return m_entity.GetPositionXY();
	}
	
	float getPositionX()
	{
		return m_entity.GetPositionX();
	}
	
	float getPositionY()
	{
		return m_entity.GetPositionY();
	}

	ETHEntity@ getEntity()
	{
		return @m_entity;
	}

	private void updateMovement(ETHPhysicsController@ physicsController, const float movementSpeed)
	{
		m_movementSpeed = movementSpeed;

		// if there's movement, update animation
		if (movementSpeed != 0.0f)
		{
			
			// apply movement horizontally, keeping current vertical velocity (let gravity work alone)
			const vector2 currentVelocity = physicsController.GetLinearVelocity();
			physicsController.SetLinearVelocity(vector2(movementSpeed, currentVelocity.y));

			// animate character by iterating the sprite sheet columns
			m_frameColumn = m_frameTimer.update(0, 3, 150);

			// find correct row in sprite sheet depending on direction
			m_directionLine = (movementSpeed > 0) ? 2 : 1;

			// find the side the character is facing
			m_lastDirectionX = (movementSpeed > 0) ? 1 : -1;
		}
		else
		{
			// if theres no horizontal movement, break character
			const vector2 currentVelocity = physicsController.GetLinearVelocity();
			physicsController.SetLinearVelocity(vector2(0.0f, currentVelocity.y));

			// idle animation frame (first column in sprite sheet)
			m_frameColumn = 0;
		}
	}

	float getCharacterMovementSpeed()
	{
		return m_movementSpeed;
	}

	float getCharacterDirectionX()
	{
		return m_lastDirectionX;
	}

	void setCharacterDirectionX(float dir)
	{
		m_lastDirectionX = dir;
		m_directionLine = (m_lastDirectionX > 0) ? 2 : 1;
	}

	// usar apenas no characters manager
	void destroy()
	{
		DeleteEntity(m_entity);
	}

	bool isDead() const
	{
		return (m_entity.GetInt("hp") < 0);
	}

	private void updateJumpImpulse(ETHPhysicsController@ physicsController, const float jumpImpulse)
	{
		const vector2 currentVelocity = physicsController.GetLinearVelocity();

		// apply jump impulse
		if (isTouchingGround())
		{			
			m_jumpInTheAirCount = 0;
			
			if (jumpImpulse != 0.0f)
			{
				// apply jump impulse leaving horizontal speed as it is
				physicsController.SetLinearVelocity(vector2(currentVelocity.x, jumpImpulse));
			}
		}
		else
		{			
			// jump animation
			if (currentVelocity.y < 0.0f)
				m_frameColumn = 2;
			else
				m_frameColumn = 1;
		}
		
		if (!isTouchingGround() && abs(jumpImpulse) > 0.0f && m_jumpInTheAirCount < m_maxJumpsInTheAir)
		{
			physicsController.SetLinearVelocity(vector2(currentVelocity.x, jumpImpulse));
			++m_jumpInTheAirCount;
		}
		
	}

	private void checkGroundTouch()
	{
		// if the last time a ground touch had been detected was over a few
		// milliseconds ago, we assume it is no longer touching the ground 
		m_touchingGround = ((GetTime() - m_entity.GetUInt("touchingGroundTime")) < 120);
	}
}

/*
	This function is called when there's contact between the character and anything else.
	It will be used to check if the character's feet touch any ground and set a flag as
	entity data for later use.
*/
void ETHPreSolveContactCallback_Character(
	ETHEntity@ body,
	ETHEntity@ other,
	vector2 contactPointA,
	vector2 contactPointB,
	vector2 contactNormal)
{
	const float charBodyHeight = body.GetCollisionBox().size.y * body.GetScale().y;
	const float halfCharBodyHeight = charBodyHeight / 2.0f;

	// if the contact is near the bottom of the character's body,
	// we can assume it's their feet so he might be touching ground
	if (contactPointA.y > body.GetPositionY() + (halfCharBodyHeight * 0.8f))
	{
		body.SetUInt("touchingGroundTime", GetTime());
	}
}

void ETHBeginContactCallback_Character(
	ETHEntity@ thisEntity,
	ETHEntity@ other,
	vector2 contactPointA,
	vector2 contactPointB,
	vector2 contactNormal)
{
	if (other.GetEntityName() == "barrier.ent")
	{
		if(thisEntity.GetUInt("reached_barrier") == 0)
		{
	    	thisEntity.SetUInt("reached_barrier", 1 /*true*/);
	    }
	    else
	    {
	    	thisEntity.SetUInt("reached_barrier", 0 /*true*/);
	    }
	}
}

void ETHConstructorCallback_Character(ETHEntity@ thisEntity)
{
	LoadSoundEffect("soundfx/explosion_small.mp3");
}


