package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.math.FlxPoint;
import flixel.system.debug.watch.Watch;
import flixel.util.FlxColor;
import flixel.util.FlxPath;
import flixel.util.FlxTimer;

using StringTools;

class Robot extends FlxSprite
{
	var defPos:FlxPoint = new FlxPoint(27, 119);

	public var speed:Int;
	public var spl:Int;
	public var lastTouched:Bool;
	public var curRobotFolder:String;

	public var price:Int;

	public var touched:Dynamic;

	public static var thisRobotMode:String;

	public var pathh:String;

	public var _frames:Array<Int>;

	public var hasEarnedCoin:Bool;

	public var levelfld:Int;

	public function new(speed:Int, _path:String, _price:Int, fld:Int, ?spl:Int)
	{
		super(defPos.x, defPos.y); // Default at bottom left of the PG

		this.levelfld = fld;

		// this.curRobotFolder = PlayState.folder;

		pathh = _path;

		if (pathh.contains("3") || pathh.contains("4"))
		{
			this.loadGraphic('assets/images/$levelfld/$pathh', true, 27, 16);
		}
		else
		{
			this.loadGraphic('assets/images/$levelfld/$pathh', true, 18, 18);
		}

		// this.makeGraphic(18, 18, FlxColor.WHITE);

		FlxG.watch.addQuick("fullString", 'assets/images/$levelfld/$pathh');

		this.speed = speed;

		this.price = _price;

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

	public function earnCoin()
	{
		if (!hasEarnedCoin)
		{
			hasEarnedCoin = true;
			PlayState.score += price;
			PlayState.incr(PlayState.score += price, PlayState.scoreT);
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
