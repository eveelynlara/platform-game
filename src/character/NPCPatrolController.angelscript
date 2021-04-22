class NPCPatrolController : CharacterController
{
	private float m_movementSpeed = 0.0f;
	private float m_jumpImpulse = 0.0f;

	private Character@ m_character;
	
	vector2 m_followedCharacterPos;
	vector2 m_npcCharacterPos;
	
	private bool m_touchingSinglePiece = false;

	void update(Character@ thisCharacter) override
	{
		ETHInput@ input = GetInputHandle();
		m_movementSpeed = 0.0f;
		const float npcSpeed = 3.0f;
		m_movementSpeed = -npcSpeed * 0.8f;

		if(thisCharacter.getEntity().GetUInt("reached_barrier") == 1)
		{
			m_movementSpeed *= -1;
		}
	}

	float getDirectionChangeRequest() const override
	{
		return 0.0f;
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
