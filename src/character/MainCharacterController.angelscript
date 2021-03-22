class MainCharacterController : CharacterController
{
	private float m_movementSpeed = 0.0f;
	private float m_jumpImpulse = 0.0f;
	private float m_side = -5.0f;
	private Fireball@ fireball;
	private FireballsManager m_fireballsManager;

	void update(Character@ thisCharacter)
	{
		m_movementSpeed = 0.0f;
		m_jumpImpulse = 0.0f;

		const float mainCharSpeed = 4.0f;
		const float jumpImpulse = 9.0f;

		ETHInput@ input = GetInputHandle();

		// find current move direction based on keyboard keys
		if (input.KeyDown(K_LEFT))
			m_movementSpeed = -mainCharSpeed;

		if (input.KeyDown(K_RIGHT))
			m_movementSpeed = mainCharSpeed;

		if (input.GetKeyState(K_UP) == KS_HIT)
			m_jumpImpulse =-jumpImpulse;

		if (input.GetKeyState(K_SPACE) == KS_HIT)
		{
			@fireball = Fireball("fireball.ent", thisCharacter.getPosition());
			m_fireballsManager.addFireball(@fireball);
		}
	}

	FireballsManager@ getFireballsManager()
	{
		return @m_fireballsManager;
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
