class Fireball
{
	private ETHEntity@ m_entity;
	private FrameTimer m_frameTimer;
	private uint m_frameColumn = 0;

	Fireball(const string &in entityName, vector2 pos)
	{
		AddEntity(entityName, vector3(pos, -2.0f), 0.0f /*rotation*/, m_entity, "Fireball", 1.0f /*scale*/);
	}

	void update()
	{
		updateFrame();
		m_entity.SetFrame(m_frameColumn);
	}

	private void updateFrame()
	{
		m_frameTimer.update(0, 3, 55);
		m_frameColumn = m_frameTimer.getCurrentFrame();
	}
}