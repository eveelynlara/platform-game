class FireballsManager
{
	private Fireball@[] m_fireball;
	
	void addFireball(Fireball@ newFireball)
	{
		m_fireball.insertLast(@newFireball);
	}
	
	void update()
	{
		for(uint i = 0; i < m_fireball.length(); i++)
		{
			m_fireball[i].update();
		}
	}
}
