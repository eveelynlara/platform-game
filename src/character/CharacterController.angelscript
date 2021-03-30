interface CharacterController
{
	void update(Character@ thisCharacter);
	float getMovementSpeed() const;
	float getJumpImpulse() const;
	KEY_STATE fireState() const;
}
