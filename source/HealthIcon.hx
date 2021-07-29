package;

import flixel.FlxSprite;

class HealthIcon extends FlxSprite
{
	/**
	 * Used for FreeplayState! If you use it elsewhere, prob gonna annoying
	 */
	public var sprTracker:FlxSprite;

	public function new(char:String = 'bf', isPlayer:Bool = false)
	{
		super();
		
		loadGraphic(Paths.image('iconGrid'), true, 150, 150);

		antialiasing = true;
		//castle crasher week thing
		animation.add('barb', [24, 25], 0, false, isPlayer);
		animation.add('cyclops', [26, 27], 0, false, isPlayer);
		animation.add('cyclops-groom', [26, 27], 0, false, isPlayer);
		animation.add('painter', [28, 29], 0, false, isPlayer);
		animation.add('evilwizard', [34, 31], 0, false, isPlayer);
		animation.add('necromancer', [32, 33], 0, false, isPlayer);
		animation.add('spider', [37, 39], 0, false, isPlayer);
		animation.add('iceking', [36, 35], 0, false, isPlayer);
		//
		animation.add('bf', [0, 1], 0, false, isPlayer);
		animation.add('bf-frozen', [0, 1], 0, false, isPlayer);
		animation.add('dad', [12, 13], 0, false, isPlayer);
		animation.add('gf', [16], 0, false, isPlayer);
		animation.play(char);

		scrollFactor.set();
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (sprTracker != null)
			setPosition(sprTracker.x + sprTracker.width + 10, sprTracker.y - 30);
	}
}
