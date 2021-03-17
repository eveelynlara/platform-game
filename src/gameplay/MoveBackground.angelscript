class BackgroundManager
{
	ETHEntity@ m_entity;
	
	BackgroundManager(const string &in entityName, const vector2 pos)
	{
		AddEntity(entityName, vector3(pos, -10.0f), 0.0f /*rotation*/, m_entity, "background", 1.0f /*scale*/);
	}

	void update()
	{
		m_entity.SetPositionXY(GetCameraPos() + GetScreenSize()/2);
	}
}