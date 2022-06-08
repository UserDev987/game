package;

import flixel.FlxCamera.FlxCameraFollowStyle;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.group.FlxGroup;
import flixel.group.FlxSpriteGroup;
import flixel.text.FlxText;
import flixel.util.FlxCollision;
import flixel.util.FlxColor;
import flixel.util.FlxDirectionFlags;
import openfl.filters.ShaderFilter;

class Final extends FlxState
{
	public var timerT:FlxText;
	public var time:Float;
	public var sprite:FlxSprite;
	public var allCoins:FlxTypedGroup<FlxSprite>;
	public var text:FlxText;
	public var coin:Int;
	public var rec:FlxSprite;

	var SPEED:Int = 100;
	var GRAVITY:Int = 600;

	var shader:VhsShader;

	override public function create()
	{
		super.create();

		FlxG.camera.bgColor = FlxColor.BLACK;

		sprite = new FlxSprite(0, 123).makeGraphic(30, 30, FlxColor.WHITE, false);
		sprite.drag.y = SPEED * 4;
		sprite.acceleration.y = GRAVITY;
		sprite.velocity.x = 100;

		FlxG.camera.follow(sprite, FlxCameraFollowStyle.PLATFORMER);

		var platformLength = 5000;
		rec = new FlxSprite(0, 154).makeGraphic(platformLength, 30, FlxColor.GRAY, false);
		FlxG.worldBounds.right = 5000;
        rec.immovable = true;

		text = new FlxText(18, 10, 0, "Get as much as you can!", 11, true);
		text.font = "assets/images/t.ttf";
		text.scrollFactor.set(0, 0);

		timerT = new FlxText(0, 0, 0, "Elapsed: 0", 12, true);
		timerT.font = "assets/images/ikkle-4.ttf";

		add(timerT);
		add(text);
		add(rec);
		getCoin();
		add(sprite);
	}

	function getCoin()
	{
		var _x:Int = 44;
		var y:Int = 138;

		allCoins = new FlxTypedGroup<FlxSprite>();

		for (i in 0...300)
		{
			_x += 100;
            FlxG.worldBounds.right += 100;
            var ranY:Int = FlxG.random.int(0, 170);
            allCoins.add(new FlxSprite(_x, ranY).makeGraphic(8, 8, FlxColor.WHITE, false));
		}
		add(allCoins);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		time += elapsed;
		timerT.text = 'Elapsed: $time';

        rec.velocity.x = sprite.velocity.x;
		FlxG.collide(rec, sprite);

		var jumping:Bool = false;
		var jumpTimer:Float = 0;

		if (jumping && !FlxG.keys.justPressed.SPACE)
			jumping = false;

		/*
		 * Reset jumpTimer when touching the floor
		 * Note: This sprite's touching flags are set via FlxG.collide,
		 * and are reset to false on super.update
		 */
		if (sprite.isTouching(DOWN) && !jumping)
			jumpTimer = 0;

		if (jumpTimer >= 0 && FlxG.keys.justPressed.SPACE)
		{
			jumping = true;
			jumpTimer += elapsed;
		}
		else
			jumpTimer = -1;

		// hold button to jump higher (up to 0.25s)
		if (jumpTimer > 0 && jumpTimer < 0.25)
			sprite.velocity.y = -300;

		FlxG.overlap(sprite, allCoins, function(sprite:FlxSprite, coinn:FlxSprite)
		{
			coin++;
			coinn.kill();
		});

		if (coin == 60)
		{
			FlxG.camera.flash(FlxColor.WHITE, 3, function()
			{
				FlxG.camera.shake(3, 3, function()
				{
					shader = new VhsShader();
					FlxG.game.setFilters([new ShaderFilter(shader)]);
					shader.setNoisePercent(0 / 100);

					FlxG.camera.shake(4, 6, function()
					{
						FlxG.camera.fade(FlxColor.BLACK, 2, false, function()
						{
							var txt:FlxText = new FlxText(0, 0, 0, "ITS OVER :)", 12, true);
							txt.font = "assets/images/ikkle-4.ttf";
							txt.antialiasing = true;
							txt.screenCenter(XY);
							add(txt);
						});
					});
				});
			});
		};
	}
}
