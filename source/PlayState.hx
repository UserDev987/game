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
import flixel.util.FlxTimer;

class PlayState extends FlxState
{
	var playGround:FlxSprite;

	public static var mainUI:UI;

	public static var score:Int;

	public static var scoreT:FlxText;

	var ball:Robot;

	public var coinPOP:FlxSprite;

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

	public static var robotT:FlxText;

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
		firstLevel = true;

		score = 100;

		FlxG.watch.addQuick("score", score);

		_levelOneRobots = ["robot11.png", "robot12.png", "robot13.png", "robot14.png"];
		_levelTwoRobots = ["robot21.png", "robot22.png", "robot23.png", "robot24.png"];
		_levelThirdRobots = ["robot31.png", "robot32.png", "robot33.png", "robot34.png"];
		_levelFourthRobots = ["robot41.png", "robot42.png", "robot43.png", "robot44.png"];

		levelOneRobots = new FlxTypedGroup<Robot>(); // 16
		levelTwoRobots = new FlxTypedGroup<Robot>(); // 32
		levelThirdRobots = new FlxTypedGroup<Robot>(); // 48
		levelFourthRobots = new FlxTypedGroup<Robot>(); // 65

		curSpeed = 35;
		curPrice = 5;

		for (i in 0...2)
		{
			for (robot in _levelOneRobots)
			{
				curSpeed += 2;
				curPrice *= 7;
				var shitRobot:Robot = new Robot(curSpeed, robot, curPrice, 1);

				levelOneRobots.add(shitRobot);
			}
		}

		curSpeed = 40;
		curPrice = 20;

		for (i in 0...2)
		{
			for (robot in _levelTwoRobots)
			{
				curSpeed += 2;
				curPrice *= 10;
				var shitRobot:Robot = new Robot(curSpeed, robot, curPrice, 2);

				levelTwoRobots.add(shitRobot);
			}
		}

		curSpeed = 45;
		curPrice = 40;

		for (robot in _levelThirdRobots)
		{
			curSpeed += 5;
			curPrice *= 12;
			var shitRobot:Robot = new Robot(curSpeed, robot, curPrice, 3);
			var shitRobot2:Robot = new Robot(curSpeed, robot, curPrice, 3);
			levelThirdRobots.add(shitRobot);
			levelThirdRobots.add(shitRobot2);
		}

		curSpeed = 50;
		curPrice = 80;

		for (robot in _levelFourthRobots)
		{
			curSpeed += 5;
			curPrice *= 15;
			var shitRobot:Robot = new Robot(curSpeed, robot, curPrice, 4);
			var shitRobot2:Robot = new Robot(curSpeed, robot, curPrice, 4);
			levelFourthRobots.add(shitRobot);
			levelFourthRobots.add(shitRobot2);
		}

		getPG();
	}

	function getPG()
	{
		playGround = new FlxSprite(36, 32).loadGraphic("assets/images/1/ring_1.png", false, 248, 112, false);

		add(playGround);

		test = new FlxSprite(148, 117).makeGraphic(25, 25, FlxColor.WHITE, false);
		test.alpha = 0;

		robotT = new FlxText(20, 159, 0, "Next Robot: ", 12, true);
		robotT.font = "assets/images/pix.ttf";
		robotT.antialiasing = false;

		extra = new FlxSprite(225, 117).makeGraphic(25, 25, FlxColor.RED, false);
		extra.alpha = 0;

		scoreT = new FlxText(90, 6, 0, "Score: 100", 12, true);
		scoreT.font = "assets/images/pix.ttf";
		scoreT.antialiasing = false;
		scoreT.screenCenter(X);
		scoreT.color = FlxColor.GRAY;

		coinPOP = new FlxSprite(155, 123).loadGraphic("assets/images/pop.png", true, Std.int(9.16), 9, false);
		coinPOP.animation.add("pop", [0, 1, 2, 3, 4, 5], 5, false);

		add(test);
		add(extra);
		mainUI = new UI();

		add(UI.allBoughtRobots);

		add(scoreT);

		add(robotT);

		// (UI.allUnits);
		add(mainUI); // Next One
	}

	public static function inc(p:Int, s:FlxText)
	{
		s.text = 'Score: $p';
	}

	public static function robChange(p:Int, s:FlxText)
	{
		s.text = 'Next Robot: $p';
	}

	function mainLoop()
	{
		if (firstLevel)
		{
			FlxG.watch.addQuick("curSpeed", curSpeed);
			FlxG.watch.addQuick("curPrice", curPrice);

			parentLevel = 1;
			robotMode = "Normal";
			bgcolor = "Purple";
			levelRobots = levelOneRobots;

			FlxG.camera.bgColor.setRGB(37, 150, 190);

			if (currobotCount == levelRobots.length)
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

				currobotCount == 0;
			}
		}

		if (secondLevel)
		{
			parentLevel = 2;
			robotMode = "Normal";
			bgcolor = "Yellow";
			levelRobots = levelTwoRobots;

			FlxG.camera.bgColor.setRGB(136, 148, 76);

			playGround.loadGraphic("assets/images/2/ring_2.png", false, 248, 112, false);

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
				currobotCount = 0;
			}
		}

		if (thirdLevel)
		{
			parentLevel = 3;
			robotMode = "Normal";
			bgcolor = "Green";
			levelRobots = levelThirdRobots;

			FlxG.camera.bgColor.setRGB(177, 134, 82, 255);

			playGround.loadGraphic("assets/images/3/ring_3.png", false, 248, 112, false);

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
				currobotCount = 0;
			}
		}

		if (fourthLevel)
		{
			parentLevel = 4;
			robotMode = "Normal";
			bgcolor = "Red";
			levelRobots = levelFourthRobots;

			// UI.allBoughtRobots.forEach(function(r:Robot)
			// {
			// 	r.kill();
			// });

			// var bigRobot:Robot = new Robot(100, "robotX.png", 0, 4);

			// UI.allBoughtRobots.add(bigRobot);

			FlxG.camera.bgColor.setRGB(144, 84, 77, 255);

			playGround.loadGraphic("assets/images/4/ring_4.png", false, 248, 112, false);

			if (currobotCount == levelRobots.length)
			{
				FlxG.camera.shake(0.05, 2, function()
				{
					FlxG.camera.fade(FlxColor.BLACK, 2, true, function()
					{
						trace("4");
						FlxG.switchState(new Final());
					});
				});
				fourthLevel = false;
				currobotCount = 0;
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
			robot.pop = false;
		});

		FlxG.overlap(UI.allBoughtRobots, test, function(robot:Robot, touch:FlxSprite)
		{
			robot.earnCoin();
			add(coinPOP);
			coinPOP.animation.play("pop");
		});

		folder = levelFolder;

		// trace(score + " " + parentLevel);

		mainLoop();

		var np:Int = UI.nextRobotPrice;

		robotT.text = 'Next Robot: $np';

		var jump = FlxG.keys.anyPressed([UP, SPACE, W]);
		if (jump)
		{
			player.velocity.y = -600 / 1.5;
		}
	}
}
