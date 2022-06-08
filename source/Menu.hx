package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.input.mouse.FlxMouseEventManager;
import flixel.util.FlxColor;

class Menu extends FlxState
{
	public var menu:FlxSprite;
	public var click:FlxSprite;

	override public function create()
	{
		super.create();

		menu = new FlxSprite().loadGraphic("assets/images/menu.png", false, 320, 180, false);
		add(menu);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		if (FlxG.keys.justPressed.ENTER || FlxG.mouse.pressed)
		{
			FlxG.camera.fade(FlxColor.BLACK, 1, false, function()
			{
				FlxG.switchState(new PlayState());
			});
		}
	}
}
