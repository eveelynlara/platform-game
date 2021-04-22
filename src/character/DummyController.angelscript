class DummyController : CharacterController
{
	void update(Character@ thisCharacter) override
	{
		ETHInput@ input = GetInputHandle();
	}

	float getMovementSpeed() const override
	{
		return 0.0f;
	}

	float getJumpImpulse() const override
	{
		return 0.0f;
	}

	KEY_STATE fireState() const
	{
		return KS_UP;
	}

	float getDirectionChangeRequest() const override
	{
		return 0.0f;
	}
}
