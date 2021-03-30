namespace utils 
{
	float clamp(const float val, const float minVal, const float maxVal)
	{
		return (val < minVal) ? minVal : ((val > maxVal) ? maxVal : val);
	}
	
	float dot(const ::vector2 &in a, const ::vector2 &in b)
	{
		return ((a.x * b.x) + (a.y * b.y));
	}
	
	vector2 clamp(const vector2 val, const vector2 minVal, const vector2 maxVal)
	{
		return vector2(clamp(val.x, minVal.x, maxVal.x), clamp(val.y, minVal.y, maxVal.y));
	}
	
	bool isWorldSpacePointInScreen(vector2 worldSpacePos)
	{
		if(worldSpacePos.x < GetCameraPos().x + GetScreenSize().x && worldSpacePos.x > GetCameraPos().x)
		{
			if(worldSpacePos.y > GetCameraPos().y && worldSpacePos.y < GetCameraPos().y + GetScreenSize().y)
			{
				return true;
			}
		}		
		return false;
	}

	bool isWorldSpacePointInScreenWithTolerance(vector2 posWithTolerance, vector2 tolerance)
	{
		if(posWithTolerance.x < GetCameraPos().x || posWithTolerance.y < GetCameraPos().y)
		{
			posWithTolerance += tolerance;
		}
		else if(posWithTolerance.x > (GetCameraPos().x + GetScreenSize().x) || posWithTolerance.y > (GetCameraPos().y + GetScreenSize().y))
		{
			posWithTolerance -= tolerance;
		}
		return  isWorldSpacePointInScreen(posWithTolerance);
	}
}
