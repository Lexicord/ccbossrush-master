
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
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;

using StringTools;

class SkinState extends MusicBeatState
{
	var Amount:Int = 0;
	var fakebf:FlxSprite;
	var curSelection:Int = 0;

	function swapbf()
	{
		remove(fakebf);

		switch (curSelection)
		{
			case 0:
				FlxG.save.data.bfskin = "";
			case 1:
				FlxG.save.data.bfskin = "KNIGHT";
			case 2:
				FlxG.save.data.bfskin = "KNIGHTGREEN";
			case 3:
				FlxG.save.data.bfskin = "KNIGHTORANGE";
			case 4:
				FlxG.save.data.bfskin = "KNIGHTRED";
			case 5:
				if (FlxG.save.data.BEATDAGAME == true)
					{
						FlxG.save.data.bfskin = "KNIGHTPINK";
					}
					else
					{
					if (FlxG.save.data.UnlockedBob == false)
						{
							FlxG.save.data.bfskin = "";
							curSelection = 0;
						}
					else 
						{
							FlxG.save.data.bfskin = "BOB";	
						}
					}
			case 6:
				if (FlxG.save.data.BEATDAGAME == true)
					{
						FlxG.save.data.bfskin = "KNIGHTPURPLE";
					}
					else
					{
					if (FlxG.save.data.UnlockedBob == false)
						{
							FlxG.save.data.bfskin = "";
							curSelection = 0;
						}
					else 
						{
							FlxG.save.data.bfskin = "BOB";	
						}
					}
			case 7:
			if (FlxG.save.data.UnlockedBob == true)
				{
					FlxG.save.data.bfskin = "BOB";
				}
				else
				{
					FlxG.save.data.bfskin = "";
					curSelection = 0;
				}
			case 8:
				if (FlxG.save.data.UnlockIce)
					{
						FlxG.save.data.bfskin = "ICESKIMO";
					}
					else
					{
						FlxG.save.data.bfskin = "";
						curSelection = 0;
					}
			default:
				FlxG.save.data.bfskin = "";
		}

		fakebf = new FlxSprite(0,0);
		fakebf.frames = Paths.getSparrowAtlas('characters/BOYFRIEND' + FlxG.save.data.bfskin, 'shared');
		fakebf.antialiasing = true;
		fakebf.screenCenter();
	if (FlxG.save.data.bfskin != "BOB")
		{fakebf.animation.addByPrefix('idle', 'BF idle dance', 24);}
	else
		{fakebf.animation.addByPrefix('idle', 'bob_idle', 24);}
	
	if (FlxG.save.data.bfskin != "BOB")
		{fakebf.animation.addByPrefix('HEY', 'BF HEY', 24, false);}
	else
		{fakebf.animation.addByPrefix('HEY', 'bob_UP', 24, false);}
	
		add(fakebf);
		fakebf.animation.play('idle');
	}

	override function create()
	{

			super.create();
			var bg:FlxSprite = new FlxSprite().loadGraphic(Paths.image('FreeplayBG', 'preload'));
			bg.screenCenter();
			add(bg);

			fakebf = new FlxSprite(0,0);
			fakebf.frames = Paths.getSparrowAtlas('characters/BOYFRIEND' + FlxG.save.data.bfskin, 'shared');
			fakebf.antialiasing = true;
			fakebf.screenCenter();
		//	fakebf.x -= 175;
			fakebf.animation.addByPrefix('idle', 'BF idle dance', 24);
		if (FlxG.save.data.bfskin != "BOB")
			{fakebf.animation.addByPrefix('HEY', 'BF HEY', 24, false);}

			add(fakebf);
			fakebf.animation.play('idle');
				
			switch (FlxG.save.data.bfskin)
				{
					case 'KNIGHT':
						curSelection = 1;
					case 'KNIGHTRED':
						curSelection = 2;
					case 'KNIGHTGREEN':
						curSelection = 3;
					case 'KNIGHTRED':
						curSelection = 4;
					case 'KNIGHTPINK':
						curSelection = 5;
					case 'KNIGHTPURPLE':
						curSelection = 6;
					case 'BOB':
						curSelection = 7;
					case '':
						curSelection = 0;
					default:
						curSelection = 0;
				}

		var txt:FlxText = new FlxText(0, 0, FlxG.width, "Current Skin: ", 24);
			txt.setFormat("VCR OSD Mono", 32, FlxColor.fromRGB(200, 200, 200), CENTER);
			txt.borderColor = FlxColor.BLACK;
			txt.borderSize = 3;
			txt.borderStyle = FlxTextBorderStyle.OUTLINE;
			txt.screenCenter();
			txt.y -= 275;
			add(txt);

		var txt:FlxText = new FlxText(0, 0, FlxG.width, "Use The Arrow Keys To Switch Skins", 24);
			txt.setFormat("VCR OSD Mono", 32, FlxColor.fromRGB(200, 200, 200), CENTER);
			txt.borderColor = FlxColor.BLACK;
			txt.borderSize = 3;
			txt.borderStyle = FlxTextBorderStyle.OUTLINE;
			txt.screenCenter();
			txt.y += 275;
			add(txt);

			#if windows
			// Updating Discord Rich Presence
			DiscordClient.changePresence("In The Skins Menu", null);
			#end	

	}

	override function update(elapsed:Float)
	{
	//	trace(FlxG.save.data.bfskin); 
		if (controls.RIGHT_P)
			{
				if (curSelection == 7)
				{
					curSelection = 0;
					swapbf();
					FlxG.sound.play(Paths.sound('scrollMenu'));
				}
				else
				{
					curSelection += 1;
					swapbf();
					FlxG.sound.play(Paths.sound('scrollMenu'));
				}
			}	
			if (controls.LEFT_P)
			{
				if (curSelection == 0)
				{
					curSelection = 7;
					swapbf();
					FlxG.sound.play(Paths.sound('scrollMenu'));
				}
				else
				{
					curSelection -= 1;
					swapbf();
					FlxG.sound.play(Paths.sound('scrollMenu'));
				}
			}
			//Detection For Skins

		if (controls.ACCEPT)
		{
		if (FlxG.save.data.bfskin != "BOB")
			{fakebf.animation.play('HEY');}
			FlxG.camera.flash(FlxColor.WHITE, 0.5);
			FlxG.sound.play(Paths.sound('confirmMenu'), 0.7);
			new FlxTimer().start(1.5, function(tmr:FlxTimer)
			{
			trace(FlxG.save.data.bfskin);
			FlxG.switchState(new MainMenuState());
			});
		}

		if (controls.BACK)
			{
				curSelection = 0;
				FlxG.save.data.bfskin = "";
				FlxG.switchState(new MainMenuState());
			}
		super.update(elapsed);
	}
}