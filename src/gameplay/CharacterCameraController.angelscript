class CharacterCameraController : CameraController
{
	private vector2 m_cameraMiddlePos;
	private Character@ m_character;
	private ETHEntity@ m_camMin;
	private ETHEntity@ m_camMax;
	vector2 camPos;
	vector2 camMin;
	vector2 camMax;
	
	CharacterCameraController(Character@ character)
	{
		@m_character = @character;
		@m_camMin = SeekEntity("cam_min.ent");
		@m_camMax = SeekEntity("cam_max.ent");

	}
	
	void update() override
	{
		// find screen middle point
		m_cameraMiddlePos = m_character.getPosition();
		
		camPos = m_cameraMiddlePos - (GetScreenSize()/2.0f);
		camMin = m_camMin.GetPositionXY();
		camMax = m_camMax.GetPositionX() - GetScreenSize().x;
		
		
		//limiting the camera
		SetCameraPos(clamp(camPos, camMin, camMax + vector2(15, 0)));		
	} 

	vector2 getCameraMiddlePos() override
	{
		return m_cameraMiddlePos;
	}
	
	float clamp(const float val, const float minVal, const float maxVal)
	{
		return (val < minVal) ? minVal : ((val > maxVal) ? maxVal : val);
	}
	
	vector2 clamp(const vector2 val, const vector2 minVal, const vector2 maxVal)
	{
		return vector2(clamp(val.x, minVal.x, maxVal.x), clamp(val.y, minVal.y, maxVal.y));
	}
	
}
