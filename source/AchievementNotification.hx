package;

import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;

class AchievementNotification extends FlxSprite
{
	public function new(x:Float, y:Float)
	{
		super(x, y);

		// BG fangirls dissuaded
		frames = Paths.getSparrowAtlas('AchievementFrame','shared');
		antialiasing = true;

		animation.addByPrefix('open', 'AchievementOpen', 24);
		animation.play('AchievementOpen');
		animation.finishCallback = function(lol:String)
			{
				animation.play('AchievementOpened');
			}
	}



}
