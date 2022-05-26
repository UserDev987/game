package;

import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.math.FlxPoint;
import flixel.util.FlxColor;

class PlayState extends FlxState
{
	var playGround:FlxSprite;

	var mainUI:UI;

	public var score:Int;

	var ball:Robot;

	public static var currobotCount:Int;

	public static var test:FlxSprite;

	// responsible for handling level stuff
	public static var firstLevel:Bool;
	public static var secondLevel:Bool;
	public static var thirdLevel:Bool;
	public static var fourthLevel:Bool;

	// level stuff
	public static var robotMode:String;
	public static var bgcolor:String;
	public static var levelFolder:String;
	public static var currLevelDone:Bool;
	public static var levelRobots:Array<String>;

	// level robots
	public static var levelOneRobots:Array<String>; // <= loop through folder names as strings and load them
	public static var levelTwoRobots:Array<String>;
	public static var levelThirdRobots:Array<String>;
	public static var levelFourthRobots:Array<String>;
	public static var parentLevel:Int;

	override public function create()
	{
		super.create();

		// FlxG.debugger.visible = true;

		firstLevel = true;

		getPG();
	}

	function getPG()
	{
		levelOneRobots = ["robot11", "robot12"];
		levelTwoRobots = ["robot21", "robot22"];
		levelThirdRobots = ["robot31", "robot32"];
		levelFourthRobots = ["robot41", "robot42"];

		playGround = new FlxSprite(0, 0).loadGraphic("assets/images/playGround.png", false, 320, 180, false);

		var test:FlxSprite = new FlxSprite(27, 25).makeGraphic(18, 18, FlxColor.WHITE, false);

		add(playGround);

		add(test);
		mainUI = new UI();

		add(UI.allBoughtRobots);

		// (UI.allUnits);
		add(mainUI); // Next One
	}

	function mainLoop()
	{
		if (firstLevel)
		{
			robotMode = "Normal";
			bgcolor = "Purple";
			levelRobots = levelOneRobots;
			levelFolder = "level1";
			parentLevel = 1;

			if (currobotCount == 5)
			{
				FlxG.camera.shake(0.05, 2, function()
				{
					FlxG.camera.fade(FlxColor.BLACK, 2, true, function()
					{
						trace("1");
					});
				});

				firstLevel = false;
				secondLevel = true;
			}
		}

		if (secondLevel)
		{
			robotMode = "Normal";
			bgcolor = "Yellow";
			levelRobots = levelTwoRobots;
			levelFolder = "level1";
			parentLevel = 2;

			if (currobotCount == 20)
			{
				FlxG.camera.shake(0.05, 2, function()
				{
					FlxG.camera.fade(FlxColor.BLACK, 2, true, function()
					{
						trace("2");
					});
				});
			}

			secondLevel = false;
			thirdLevel = true;
		}

		if (thirdLevel)
		{
			robotMode = "Normal";
			bgcolor = "Green";
			levelRobots = levelThirdRobots;
			levelFolder = "level1";
			parentLevel = 3;

			if (currobotCount == 25)
			{
				FlxG.camera.shake(0.05, 2, function()
				{
					FlxG.camera.fade(FlxColor.BLACK, 2, true, function()
					{
						trace("3");
					});
				});
			}

			thirdLevel = false;
			fourthLevel = true;
		}

		if (fourthLevel)
		{
			robotMode = "Normal";
			bgcolor = "Red";
			levelRobots = levelFourthRobots;
			levelFolder = "level1";
			parentLevel = 4;

			if (currobotCount == 35)
			{
				FlxG.camera.shake(0.05, 2, function()
				{
					FlxG.camera.fade(FlxColor.BLACK, 2, true, function()
					{
						trace("4");
					});
				});
			}

			fourthLevel = false;
		}
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		mainLoop();

		FlxG.overlap(UI.allBoughtRobots, test, function(robot:Robot, touch:FlxSprite)
		{
			//
		});
	}
}
