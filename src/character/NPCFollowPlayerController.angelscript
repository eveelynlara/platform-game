enum enemyState
{
    moveTowardsCharacter,
	reachedAttackRange		
}

class NPCFollowPlayerController : CharacterController
{
	private float m_movementSpeed = 0.0f;
	private float m_jumpImpulse = 0.0f;
	private float distanceBetweenCharacters = 250.0f;
	private float npcSpeed = 4.0f;
	private float m_fireElapsedTime = 0.0f;
	private float fireRate = 1000.0f;
	private enemyState enemyState;

	private Character@ m_character;
	
	vector2 m_followedCharacterPos;
	vector2 m_npcCharacterPos;
	
	private bool m_touchingSinglePiece = false;
	
	private KEY_STATE shootState = KS_UP;

	NPCFollowPlayerController(Character@ characterFollowed)
	{
		@m_character = characterFollowed;
	}

	void update(Character@ thisCharacter) override
	{
		ETHInput@ input = GetInputHandle();
		m_followedCharacterPos = m_character.getPosition();
		m_npcCharacterPos = thisCharacter.getPosition();

		shootState = KS_UP;

		m_movementSpeed = 0.0f;
		m_jumpImpulse = 0.0f;
		
		switch(enemyState)
		{
			case moveTowardsCharacter:
			if (m_followedCharacterPos.x > m_npcCharacterPos.x + distanceBetweenCharacters)
			{
				m_movementSpeed = npcSpeed * 0.8f;
			}	
			else if (m_followedCharacterPos.x < m_npcCharacterPos.x - distanceBetweenCharacters)
			{
				m_movementSpeed = -npcSpeed * 0.8f;	
			}
			else 
			{
				enemyState = reachedAttackRange;
			}
			break;

			case reachedAttackRange:
				m_fireElapsedTime += GetLastFrameElapsedTimeF();

				//aim and attack
				thisCharacter.setCharacterDirectionX(pointTowardsCharacter());
				if (m_fireElapsedTime >= fireRate) {
					shootState = KS_HIT;
					m_fireElapsedTime -= fireRate;
				}

				//if player is out of attack range, come back to moveTowardsCharacter
				if(abs(m_followedCharacterPos.x - m_npcCharacterPos.x) > distanceBetweenCharacters)
				{
					enemyState = moveTowardsCharacter;
				}

				break;

			default:
		}
	}

	float pointTowardsCharacter()
	{
		return (m_followedCharacterPos.x > m_npcCharacterPos.x) ? 1 : -1;
	}

	float getMovementSpeed() const
	{
		return m_movementSpeed;
	}

	float getJumpImpulse() const
	{
		return m_jumpImpulse;
	}	

	KEY_STATE fireState() const
	{
		return shootState;
	}
}