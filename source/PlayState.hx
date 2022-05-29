package;

import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxPoint;
import flixel.math.FlxRandom;
import flixel.text.FlxText;
import flixel.util.FlxColor;

class PlayState extends FlxState
{
	var playGround:FlxSprite;

	public static var mainUI:UI;

	public static var score:Int;

	public static var scoreT:FlxText;

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

	public var player:FlxSprite;

	public var coins:FlxTypedGroup<FlxSprite>;

	public var folder:String;

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

		score = 100000;

		firstLevel = true;

		FlxG.watch.addQuick("score", score);

		_levelOneRobots = ["robot11.png", "robot12.png", "robot13.png", "robot14.png"];
		_levelTwoRobots = ["robot21.png", "robot22.png", "robot23.png", "robot24.png"];
		_levelThirdRobots = ["robot31.png", "robot32.png", "robot33.png", "robot34.png"];
		_levelFourthRobots = ["robot41.png", "robot42.png", "robot43.png", "robot44.png"];

		levelOneRobots = new FlxTypedGroup<Robot>();
		levelTwoRobots = new FlxTypedGroup<Robot>();
		levelThirdRobots = new FlxTypedGroup<Robot>();
		levelFourthRobots = new FlxTypedGroup<Robot>();

		curSpeed = 0;
		curPrice = 0;

		for (robot in _levelOneRobots)
		{
			curSpeed += 5;
			curPrice += 100;
			var shitRobot:Robot = new Robot(curSpeed, robot, curPrice, 1);
			var shitRobot2:Robot = new Robot(curSpeed, robot, curPrice, 1);

			levelOneRobots.add(shitRobot);
			levelOneRobots.add(shitRobot2);
		}

		FlxG.random.shuffle(levelOneRobots.members);

		for (robot in _levelTwoRobots)
		{
			curSpeed += 5;
			curPrice += 100;
			var shitRobot:Robot = new Robot(curSpeed, robot, curPrice, 2);
			var shitRobot2:Robot = new Robot(curSpeed, robot, curPrice, 2);
			levelTwoRobots.add(shitRobot);
			levelTwoRobots.add(shitRobot2);
		}

		FlxG.random.shuffle(levelTwoRobots.members);

		for (i in 0...2)
		{
			for (robot in _levelThirdRobots)
			{
				curSpeed += 5;
				curPrice += 100;
				var shitRobot:Robot = new Robot(curSpeed, robot, curPrice, 3);
				levelThirdRobots.add(shitRobot);
			}
		}

		FlxG.random.shuffle(levelThirdRobots.members);

		for (i in 0...2)
		{
			for (robot in _levelFourthRobots)
			{
				curSpeed += 5;
				curPrice += 100;
				var shitRobot:Robot = new Robot(curSpeed, robot, curPrice, 4);
				levelFourthRobots.add(shitRobot);
			}
		}

		FlxG.random.shuffle(levelFourthRobots.members);

		levelOneRobots.forEach(function(r:Robot)
		{
			trace(r.pathh);
		}); // FlxG.debugger.visible = true;

		getPG();
	}

	function getPG()
	{
		playGround = new FlxSprite(0, 0).loadGraphic("assets/images/playGround.png", false, 320, 180, false);

		test = new FlxSprite(27, 25).makeGraphic(18, 18, FlxColor.WHITE, false);

		extra = new FlxSprite(27, 75).makeGraphic(18, 18, FlxColor.RED, false);

		scoreT = new FlxText(90, 6, 0, "Score: 100000", 12, false);

		add(playGround);

		add(test);
		add(extra);
		mainUI = new UI();

		add(UI.allBoughtRobots);

		add(scoreT);

		// (UI.allUnits);
		add(mainUI); // Next One
	}

	public static function incr(p:Int, s:FlxText)
	{
		s.text = 'Score $p';
	}

	function mainLoop()
	{
		if (firstLevel)
		{
			FlxG.watch.addQuick("curSpeed", curSpeed);
			FlxG.watch.addQuick("curPrice", curPrice);

			levelFolder = "level1";
			robotMode = "Normal";
			bgcolor = "Purple";
			levelRobots = levelOneRobots;
			parentLevel = 1;

			if (currobotCount == levelRobots.length)
			{
				// playGround.visible = false;
				// UI.allBoughtRobots.visible = false;
				// extra.visible = false;
				// test.visible = false;
				// mainUI.visible = false;

				// rectArea = new FlxSprite(-231, -16).makeGraphic(5000, 320);
				// rectArea.immovable = true;

				// add(rectArea);

				// player = new FlxSprite(8, 135).makeGraphic(12, 12, FlxColor.PURPLE, false);
				// player.drag.y = 1400;
				// player.acceleration.y = 100;

				// add(player);

				// var curX:Int = 0;
				// var curY:Int = 0;

				// for (i in 0...100)
				// {
				// 	var randomShit:Int = new FlxRandom().getObject([122, 72]);
				// 	curX += 20;
				// 	var coin = new FlxSprite(curX, randomShit).makeGraphic(16, 15, FlxColor.YELLOW, false);
				// 	coins.add(coin);
				// }

				// add(coins);

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

			if (currobotCount == levelRobots.length)
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

			if (currobotCount == levelRobots.length)
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

			if (currobotCount == levelRobots.length)
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

		folder = levelFolder;

		trace(score + " " + parentLevel);

		mainLoop();

		var jump = FlxG.keys.anyPressed([UP, SPACE, W]);
		if (jump)
		{
			player.velocity.y = -600 / 1.5;
		}
	}
}
