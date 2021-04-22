class MainCharacterController : CharacterController
{
	private float m_movementSpeed = 0.0f;
	private float m_jumpImpulse = 0.0f;
	private float m_lastMovementDir;
	private ETHInput@ input = GetInputHandle();

	void update(Character@ thisCharacter)
	{
		m_movementSpeed = 0.0f;
		m_jumpImpulse = 0.0f;

		const float mainCharSpeed = 4.0f;
		const float jumpImpulse = 9.0f;

		// find current move direction based on keyboard keys
		if (input.KeyDown(K_LEFT))
		{
			m_movementSpeed = -mainCharSpeed;
			m_lastMovementDir = -1;
		}

		if (input.KeyDown(K_RIGHT))
		{
			m_movementSpeed = mainCharSpeed;
			m_lastMovementDir = 1;
		}

		if (input.GetKeyState(K_UP) == KS_HIT)
		{
			m_jumpImpulse =-jumpImpulse;
		}
	}

	float getDirectionChangeRequest() const override
	{
		return 0.0f;
	}

	KEY_STATE fireState() const
	{
		return input.GetKeyState(K_SPACE);
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
