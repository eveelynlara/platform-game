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
	private enemyState enemyState;

	private float m_directionChangeRequest = 0.0f;

	private Character@ m_character;
	
	vector2 m_followedCharacterPos;
	vector2 m_npcCharacterPos;
	
	private bool m_touchingSinglePiece = false;
		
	NPCFollowPlayerController(Character@ characterFollowed)
	{
		@m_character = characterFollowed;
	}

	void update(Character@ thisCharacter) override
	{
		ETHInput@ input = GetInputHandle();
		m_followedCharacterPos = m_character.getPosition();
		m_npcCharacterPos = thisCharacter.getPosition();

		m_movementSpeed = 0.0f;
		m_jumpImpulse = 0.0f;

		const float npcSpeed = 4.0f;
		const float jumpImpulse = 9.0f;
		
		m_directionChangeRequest = 0.0f;

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
				if (!thisCharacter.isPointingAt(m_followedCharacterPos))
				{
					m_directionChangeRequest = sign(m_followedCharacterPos.x - thisCharacter.getPositionX());
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

	float getDirectionChangeRequest() const override
	{
		return m_directionChangeRequest;
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
		return KS_UP;
	}
}
