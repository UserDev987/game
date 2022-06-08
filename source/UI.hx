package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.input.mouse.FlxMouseEventManager;
import flixel.math.FlxRandom;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import lime.tools.Platform;

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

	public var notEnough:FlxText;

	public static var nextRobotPrice:Int;

	public static var coinPop:FlxSprite;

	public static var rbt:Robot;

	public var robotTurn:Int = 0;

	public function new()
	{
		super();

		allBoughtRobots = new FlxTypedGroup<Robot>();
		allUnits = new FlxTypedGroup<FlxSprite>();

		addButton = new FlxSprite(289, 58).loadGraphic("assets/images/shop_button_off.png", false, 20, 20);

		add(notEnough);

		add(addButton);
		handleMouseStuff();
	}

	function handleMouseStuff()
	{
		FlxMouseEventManager.add(addButton, function(addButton:FlxSprite)
		{
			addButton.loadGraphic("assets/images/shop_button_on.png");
			addBot();
			PlayState.levelRobots.forEach(function(r:Robot)
			{
				trace(r.price);
			});
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
		FlxG.watch.addQuick("curLevel", PlayState.parentLevel);
		FlxG.watch.addQuick("robotParentFolder", PlayState.levelRobots.members[robotTurn].levelfld);
		FlxG.watch.addQuick("robotPng", PlayState.levelRobots.members[robotTurn].pathh);
		FlxG.watch.addQuick("score", PlayState.score);
		FlxG.watch.addQuick("membersC", PlayState.levelRobots.length);
		// if (robotTurn != PlayState.levelRobots.length - 1)
		// {
		if (PlayState.score >= PlayState.levelRobots.members[robotTurn].price) // check if the curr score (65) is >= 245 NO
		{
			// rbt = new Robot(50, realRandomRobot, 50);

			var subA:Int = PlayState.score -= PlayState.levelRobots.members[robotTurn].price;
			var sc:Int = PlayState.score;

			PlayState.scoreT.text = 'Score: $sc';

			var realRandomRobot:Robot = PlayState.levelRobots.members[robotTurn]; // ref to it

			nextRobotPrice = PlayState.levelRobots.members[robotTurn + 1].price; // works good

			allBoughtRobots.add(realRandomRobot); // ok

			PlayState.currobotCount += 1; // ok
			robotTurn++; // ok

			// FlxG.watch.addQuick("randomValue", randomRobot);
		}
		else
		{
			FlxG.camera.flash(FlxColor.RED, 0.2);
			FlxG.camera.shake(0.02, 0.5);
		}
		// }

		if (robotTurn == PlayState.levelRobots.length - 1)
		{
			robotTurn = 0;
		}
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}
