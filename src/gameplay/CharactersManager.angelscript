class CharactersManager
{
	private Character@[] m_character;
	private CharacterController@ characterController;
	
	void addCharacter(Character@ newCharacter)
	{
		m_character.insertLast(@newCharacter);
	}
	
	void update()
	{
		for(uint i = 0; i < m_character.length(); i++)
		{
			m_character[i].update();
		}
	}
}
