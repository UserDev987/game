package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.input.mouse.FlxMouseEventManager;
import flixel.math.FlxRandom;
import flixel.text.FlxText;
import flixel.util.FlxColor;

typedef Unit =
{
	var sprite:FlxSprite;
	var taken:Bool;
	var robotName:String;
}

class UI extends FlxTypedGroup<FlxSprite>
{
	public static var invButton:FlxSprite;

	public static var parentBody:FlxSprite;
	public static var addButton:FlxSprite;

	public static var allRobots:FlxTypedGroup<Robot>;

	public static var allBoughtRobots:FlxTypedGroup<Robot>;
	public static var allUnits:FlxTypedGroup<FlxSprite>;

	public static var rbt:Robot;

	public var robotTurn:Int = 0;

	public function new()
	{
		super();

		allBoughtRobots = new FlxTypedGroup<Robot>();
		allUnits = new FlxTypedGroup<FlxSprite>();
		invButton = new FlxSprite(289, 90).loadGraphic("assets/images/inventory_button_off.png", false, 20, 20);
		addButton = new FlxSprite(289, 58).loadGraphic("assets/images/shop_button_off.png", false, 20, 20);
		// this.setupUnits();
		add(invButton);
		add(addButton);
		handleMouseStuff();
	}

	function handleMouseStuff()
	{
		FlxMouseEventManager.add(invButton, function(invButton:FlxSprite)
		{
			invButton.loadGraphic("assets/images/inventory_button_on.png");
		}, null, function(invButton:FlxSprite)
		{
			invButton.loadGraphic("assets/images/inventory_button_on.png");
		}, function(invButton:FlxSprite)
		{
			invButton.loadGraphic("assets/images/inventory_button_off.png");
		}, false, true, true);

		FlxMouseEventManager.add(addButton, function(addButton:FlxSprite)
		{
			addButton.loadGraphic("assets/images/shop_button_on.png");
			addBot();
		}, null, function(mouseButton:FlxSprite)
		{
			addButton.loadGraphic("assets/images/shop_button_on.png");
		}, function(shopButton:FlxSprite)
		{
			addButton.loadGraphic("assets/images/shop_button_off.png");
		}, false, true, true);
	}

	function addBot()
	{
		FlxG.watch.addQuick("robotTurn", robotTurn);
		if (robotTurn != PlayState.levelRobots.length + 1)
		{
			if (PlayState.score >= PlayState.levelRobots.members[robotTurn].price)
			{
				PlayState.score -= PlayState.levelRobots.members[robotTurn].price;
				PlayState.incr(PlayState.score -= PlayState.levelRobots.members[robotTurn].price, PlayState.scoreT);
				// rbt = new Robot(50, realRandomRobot, 50);

				var realRandomRobot:Robot = PlayState.levelRobots.members[robotTurn];

				allBoughtRobots.add(realRandomRobot);

				robotTurn++;

				PlayState.currobotCount += 1;

				// FlxG.watch.addQuick("randomValue", randomRobot);
				FlxG.watch.addQuick("robotParentFolder", realRandomRobot.levelfld);
				FlxG.watch.addQuick("robotPng", realRandomRobot.pathh);
			}
			else
			{
				trace("Damn! You got no money loser!");
			}
		}

		if (robotTurn == PlayState.levelRobots.length + 1)
		{
			robotTurn = 0;
		}

		// var randomUnit:FlxSprite = allUnits.getRandom();

		// var level_folder:String = PlayState.levelFolder;
		// var robotThumb:FlxSprite = new FlxSprite(randomUnit.x, randomUnit.y).makeGraphic(18, 18, FlxColor.WHITE, false);
		// add(robotThumb);
	}

	function setupUnits()
	{
		var defX:Int = 5;

		var defY:Int = 147;

		var unitTracker:Int = 0;

		for (x in 0...4)
		{
			for (i in 0...4)
			{
				unitTracker++;

				var button:FlxSprite = new FlxSprite(defX, defY).loadGraphic("assets/images/unit_card.png", false, 30, 30, false);
				defX += 67;
				allUnits.add(button);
			}
		}
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		FlxG.watch.addQuick("curLevel", PlayState.parentLevel);
	}
}
