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
		m_movementSpeed = 0.0f;
		const float npcSpeed = 4.0f;
		m_movementSpeed = -npcSpeed * 0.8f;

		//print(thisCharacter.m_entity.GetUInt("reached_barrier"));
	}

	float getMovementSpeed() const
	{
		return m_movementSpeed;
	}

	float getJumpImpulse() const
	{
		return m_jumpImpulse;
	}	
}
