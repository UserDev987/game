package;

import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxPoint;
import flixel.util.FlxColor;

class PlayState extends FlxState
{
	var playGround:FlxSprite;

	var mainUI:UI;

	public static var score:Int;

	var ball:Robot;

	public static var currobotCount:Int;

	public static var test:FlxSprite;

	public static var extra:FlxSprite;

	public var curSpeed:Int;
	public var curPrice:Int;

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
	public static var levelRobots:FlxTypedGroup<Robot>;

	// shit
	public var shit:FlxSprite;

	// level robots
	public static var _levelOneRobots:Array<String>; // <= loop through folder names as strings and load them
	public static var _levelTwoRobots:Array<String>;
	public static var _levelThirdRobots:Array<String>;
	public static var _levelFourthRobots:Array<String>;

	// god some mercy please
	public static var levelOneRobots:FlxTypedGroup<Robot>; // <= loop through folder names as strings and load them
	public static var levelTwoRobots:FlxTypedGroup<Robot>;
	public static var levelThirdRobots:FlxTypedGroup<Robot>;
	public static var levelFourthRobots:FlxTypedGroup<Robot>;

	public static var parentLevel:Int;

	public var rectArea:FlxSprite;

	override public function create()
	{
		super.create();

		for (x in 0...3)
		{
			for (i in 1...4)
			{
				curSpeed += 4;
				curPrice += 1000;
package;

import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxPoint;
import flixel.util.FlxColor;

class PlayState extends FlxState
{
	var playGround:FlxSprite;

	var mainUI:UI;

	public static var score:Int;

	var ball:Robot;

	public static var currobotCount:Int;

	public static var test:FlxSprite;

	public static var extra:FlxSprite;

	public var curSpeed:Int;
	public var curPrice:Int;

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
	public static var levelRobots:FlxTypedGroup<Robot>;

	// shit
	public var shit:FlxSprite;

	// level robots
	public static var _levelOneRobots:Array<String>; // <= loop through folder names as strings and load them
	public static var _levelTwoRobots:Array<String>;
	public static var _levelThirdRobots:Array<String>;
	public static var _levelFourthRobots:Array<String>;

	// god some mercy please
	public static var levelOneRobots:FlxTypedGroup<Robot>; // <= loop through folder names as strings and load them
	public static var levelTwoRobots:FlxTypedGroup<Robot>;
	public static var levelThirdRobots:FlxTypedGroup<Robot>;
	public static var levelFourthRobots:FlxTypedGroup<Robot>;

	public static var parentLevel:Int;

	public var rectArea:FlxSprite;

	override public function create()
	{
		super.create();

		firstLevel = true;
		FlxG.watch.addQuick("levelFolder", levelFolder);

		levelOneRobots = new FlxTypedGroup<Robot>();

		for (x in 0...3)
		{
			for (i in 1...5)
			{
				curSpeed += 4;
				curPrice += 1000;
				levelOneRobots.add(new Robot(curSpeed, 'robot1$i.png', curPrice));
			}
		}

		// FlxG.debugger.visible = true;

		getPG();
	}

	function getPG()
	{
		playGround = new FlxSprite(0, 0).loadGraphic("assets/images/playGround.png", false, 320, 180, false);

		test = new FlxSprite(27, 25).makeGraphic(18, 18, FlxColor.WHITE, false);

		extra = new FlxSprite(27, 75).makeGraphic(18, 18, FlxColor.RED, false);

		add(playGround);

		add(test);
		add(extra);
		mainUI = new UI();

		add(UI.allBoughtRobots);

		// (UI.allUnits);
		add(mainUI); // Next One

		_levelOneRobots = ["robot11.png", "robot12.png", "robot13.png", "robot14.png"];
		_levelTwoRobots = ["robot21.png", "robot22.png", "robot23.png", "robot24.png"];
		_levelThirdRobots = ["robot31.png", "robot32.png", "robot33.png", "robot34.png"];
		_levelFourthRobots = ["robot41.png", "robot42.png", "robot43.png", "robot44.png"];
	}

	function mainLoop()
	{
		if (firstLevel)
		{
			FlxG.watch.addQuick("curSpeed", curSpeed);
			FlxG.watch.addQuick("curPrice", curPrice);

			robotMode = "Normal";
			bgcolor = "Purple";
			levelRobots = levelOneRobots;
			levelFolder = "level1";
			parentLevel = 1;

			if (currobotCount == 5)
			{
				// playGround.visible = false;
				// UI.allBoughtRobots.visible = false;
				// extra.visible = false;
				// test.visible = false;

				rectArea = new FlxSprite(-231, -16).makeGraphic(320, 5000);

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
			levelFolder = "level2";
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

				secondLevel = false;
				thirdLevel = true;
			}
		}

		if (thirdLevel)
		{
			robotMode = "Normal";
			bgcolor = "Green";
			levelRobots = levelThirdRobots;
			levelFolder = "level3";
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

				thirdLevel = false;
				fourthLevel = true;
			}
		}

		if (fourthLevel)
		{
			robotMode = "Normal";
			bgcolor = "Red";
			levelRobots = levelFourthRobots;
			levelFolder = "level4";
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

				fourthLevel = false;
			}
		}
	}

	var robotCollided:Bool = false;

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		FlxG.overlap(UI.allBoughtRobots, extra, function(robot:Robot, extra:FlxSprite)
		{
			robot.hasEarnedCoin = false;
		});

		FlxG.overlap(UI.allBoughtRobots, test, function(robot:Robot, touch:FlxSprite)
		{
			robot.earnCoin();
		});

		mainLoop();
	}
}
				levelOneRobots.add(new Robot(curSpeed, 'robot1$i.png', curPrice));
			}
		}

		// FlxG.debugger.visible = true;

		firstLevel = true;

		getPG();
	}

	function getPG()
	{
		playGround = new FlxSprite(0, 0).loadGraphic("assets/images/playGround.png", false, 320, 180, false);

		test = new FlxSprite(27, 25).makeGraphic(18, 18, FlxColor.WHITE, false);

		extra = new FlxSprite(27, 75).makeGraphic(18, 18, FlxColor.RED, false);

		add(playGround);

		add(test);
		add(extra);
		mainUI = new UI();

		add(UI.allBoughtRobots);

		// (UI.allUnits);
		add(mainUI); // Next One

		_levelOneRobots = ["robot11.png", "robot12.png", "robot13.png", "robot14.png"];
		_levelTwoRobots = ["robot21.png", "robot22.png", "robot23.png", "robot24.png"];
		_levelThirdRobots = ["robot31.png", "robot32.png", "robot33.png", "robot34.png"];
		_levelFourthRobots = ["robot41.png", "robot42.png", "robot43.png", "robot44.png"];
	}

	function mainLoop()
	{
		if (firstLevel)
		{
			FlxG.watch.addQuick("curSpeed", curSpeed);
			FlxG.watch.addQuick("curPrice", curPrice);

			robotMode = "Normal";
			bgcolor = "Purple";
			levelRobots = levelOneRobots;
			levelFolder = "level1";
			parentLevel = 1;

			if (currobotCount == 5)
			{
				// playGround.visible = false;
				// UI.allBoughtRobots.visible = false;
				// extra.visible = false;
				// test.visible = false;

				rectArea = new FlxSprite(-231, -16).makeGraphic(320, 5000);

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
			levelFolder = "level2";
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

				secondLevel = false;
				thirdLevel = true;
			}
		}

		if (thirdLevel)
		{
			robotMode = "Normal";
			bgcolor = "Green";
			levelRobots = levelThirdRobots;
			levelFolder = "level3";
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

				thirdLevel = false;
				fourthLevel = true;
			}
		}

		if (fourthLevel)
		{
			robotMode = "Normal";
			bgcolor = "Red";
			levelRobots = levelFourthRobots;
			levelFolder = "level4";
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

				fourthLevel = false;
			}
		}
	}

	var robotCollided:Bool = false;

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		FlxG.overlap(UI.allBoughtRobots, extra, function(robot:Robot, extra:FlxSprite)
		{
			robot.hasEarnedCoin = false;
		});

		FlxG.overlap(UI.allBoughtRobots, test, function(robot:Robot, touch:FlxSprite)
		{
			robot.earnCoin();
		});

		mainLoop();
	}
}
