class GameScene : Scene
{
	private Button@ m_exitButton;
	
	private Character@ m_character;
	
	private CharactersManager m_charactersManager;
	private CameraController@ m_cameraController;

	private MoveBackground@ m_background;
	
	GameScene()
	{
		const string sceneName = "scenes/platforms.esc";
		super(sceneName);
	}

	void onCreated() override
{
		@m_exitButton = Button("sprites/return_button.png", vector2(0.0f, 0.0f), vector2(0.0f, 0.0f));

		const vector2 screenMiddle(GetScreenSize() * 0.5f);

		@m_background = MoveBackground("background.ent", screenMiddle);

		@m_character = Character("witch.ent", screenMiddle);
		m_character.setController(MainCharacterController());
		
		@m_cameraController = CharacterCameraController(@m_character);
		m_charactersManager.addCharacter(@m_character);
	}

	CharactersManager@ getCharactersManager()
	{
		return @m_charactersManager;
	}

	Character@ getMainCharacter()
	{
		return @m_character;
	}

	void onUpdate() override
	{
		m_charactersManager.update();
		m_cameraController.update();
		m_background.update();

		m_exitButton.putButton();
		if (m_exitButton.isPressed())
		{
			g_sceneManager.setCurrentScene(MainMenuScene());
		}
	}
}