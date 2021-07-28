
package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.text.FlxTypeText;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxSpriteGroup;
import flixel.input.FlxKeyManager;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import Discord.DiscordClient;

using StringTools;

class AchievementState extends MusicBeatState
{
		var Amount:Int = 0;
		var curSelected:Int = 0;

	override function create()
	{
		super.create();
		var bg:FlxSprite = new FlxSprite().loadGraphic(Paths.image('menuBGBlue', 'preload'));
		bg.screenCenter();
		add(bg);


		#if windows
		// Updating Discord Rich Presence
		DiscordClient.changePresence("Watching The Creditroll", null);
		#end

	}

	override function update(elapsed:Float)
	{
		if (controls.ACCEPT)
		{
			FlxG.switchState(new MainMenuState());
		}

		if (controls.BACK)
			{
				//leftState = true;
				FlxG.switchState(new MainMenuState());
			}

		super.update(elapsed);
	}
}