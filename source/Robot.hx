package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.math.FlxPoint;
import flixel.system.debug.watch.Watch;
import flixel.util.FlxColor;
import flixel.util.FlxPath;
import flixel.util.FlxTimer;

class Robot extends FlxSprite
{
	var defPos:FlxPoint = new FlxPoint(27, 119);

	public var speed:Int;
	public var spl:Int;
	public var lastTouched:Bool;
	public var curRobotFolder:String;

	public static var price:Int;

	public var touched:Dynamic;

	public static var thisRobotMode:String;

	public static var pathh:String;

	public var _frames:Array<Int>;

	public var hasEarnedCoin:Bool;

	public function new(speed:Int, _path:String, _price:Int, ?spl:Int)
	{
		super(defPos.x, defPos.y); // Default at bottom left of the PG

		this.curRobotFolder = PlayState.levelFolder;

		this.loadGraphic('assets/images/$curRobotFolder/$pathh', true, 18, 18);

		// this.makeGraphic(18, 18, FlxColor.WHITE);

		this.speed = speed;

		price = _price;

		pathh = _path;

		this.spl = spl;

		this.handleFrames();
		this.setPath();
	}

	function handleFrames()
	{
		this.animation.add("0", [0], 6, false);
		this.animation.add("1", [1], 6, false);
		this.animation.add("2", [2], 6, false);
		this.animation.add("3", [3], 6, false);
	}

	function setPath()
	{
		var points:Array<FlxPoint> = [
			new FlxPoint(37, 129),
			new FlxPoint(37, 35),
			new FlxPoint(276, 35),
			new FlxPoint(276, 129)
		];
		var path = new FlxPath(points);

		this.path = path;

		path.start(points, speed, FlxPath.LOOP_FORWARD);
	}

	function handleTouch() {}

	public function earnCoin()
	{
		if (!hasEarnedCoin)
		{
			hasEarnedCoin = true;
			PlayState.score++;
		}
	}

	var animTimeTracker:Float = 0;
	var curAnimIndex:Int = 0;

	override function update(elapsed:Float):Void
	{
		animTimeTracker += elapsed;
		if (animTimeTracker >= 0.5) // replace 10.0 with the value when you want them to change
		{
			if (curAnimIndex > 3)
				curAnimIndex = 0;

			animation.play(Std.string(curAnimIndex));
			curAnimIndex++;
			animTimeTracker = 0;
		}

		super.update(elapsed);
	}
}
