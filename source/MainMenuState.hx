package;

import flixel.input.gamepad.FlxGamepad;
import Controls.KeyboardScheme;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.effects.FlxFlicker;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import io.newgrounds.NG;
import lime.app.Application;

#if windows
import Discord.DiscordClient;
#end

using StringTools;

class MainMenuState extends MusicBeatState
{
	var curSelected:Int = 0;

	var curLetter:Int = 1;
	var LetterO:Bool = false;
	var LetterN:Bool = false;
	var LetterS:Bool = false;
	var LetterL:Bool = false;
	var LetterA:Bool = false;
	var LetterU:Bool = false;
	var LetterG:Bool = false;
	var LetterH:Bool = false;
	var LetterT:Bool = false;

	var menuItems:FlxTypedGroup<FlxSprite>;

	//COPY AND PASTE FROM HERE
	//START
	#if !switch
	var optionShit:Array<String> = ['Boss Rush', 'Freeplay', 'Achievements', 'Options', 'Skins'];
	#else
	var optionShit:Array<String> = ['Boss Rush', 'Freeplay'];
	#end
	//END

	var newGaming:FlxText;
	var newGaming2:FlxText;
	public static var firstStart:Bool = true;

	public static var nightly:String = "";

	public static var kadeEngineVer:String = "1.5.4" + nightly;
	public static var gameVer:String = "0.2.7.1";

	var camFollow:FlxObject;
	public static var finishedFunnyMove:Bool = false;

	override function create()
	{
		#if windows
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In the Menus", null);
		#end
		if (FlxG.random.bool(1))
			{
				var sussy:FlxSprite = new FlxSprite(-100).loadGraphic(Paths.image('Suspicious'));
				sussy.screenCenter();
				sussy.antialiasing = true;
				add(sussy);
				FlxG.save.data.Sussy = true;
				FlxG.save.flush();
				FlxG.sound.play(Paths.sound('errorsfx'));
				var popupforthig:FlxSprite = new FlxSprite(0, 0);
				popupforthig.frames = Paths.getSparrowAtlas('Achievement', 'shared');
				popupforthig.antialiasing = true;
				popupforthig.screenCenter();
				popupforthig.animation.addByPrefix('swag', 'Thingy', 24, false);
				add(popupforthig);
				popupforthig.animation.play('swag');
				popupforthig.animation.finishCallback = function(lol:String)
					{
						remove(popupforthig);
					}	
			}
		if (FlxG.save.data.BEATDAGAME == false)
			{
				optionShit.remove('Freeplay');
			}
		if (!FlxG.sound.music.playing)
		{
			if (FlxG.save.data.BEATDAGAME == false)
				{
					FlxG.sound.playMusic(Paths.music('freakyMenu'));
				}
				else 
				{
					FlxG.sound.playMusic(Paths.music('therace'));
				}
		}

		persistentUpdate = persistentDraw = true;

		var bg:FlxSprite = new FlxSprite(-100).loadGraphic(Paths.image('FunkyBG'));
		bg.scrollFactor.x = 0;
		bg.scrollFactor.y = 0.10;
		bg.setGraphicSize(Std.int(bg.width * 1.4));
		bg.updateHitbox();
		bg.screenCenter();
		bg.antialiasing = true;
		add(bg);

		FlxG.mouse.visible = false;

		camFollow = new FlxObject(0, 0, 1, 1);
		add(camFollow);


		menuItems = new FlxTypedGroup<FlxSprite>();
		add(menuItems);

		//COPY AND PASTE THE LINES BELOW (replace the line that says FNF_MENU_ASSETS or some shit)
		//START
		var tex = Paths.getSparrowAtlas('ccmenuassets');

		for (i in 0...optionShit.length)
		{
			var menuItem:FlxSprite = new FlxSprite(10, FlxG.height * 1.3);
			menuItem.frames = tex;
			menuItem.animation.addByPrefix('idle', optionShit[i] + " basic", 24);
			menuItem.animation.addByPrefix('selected', optionShit[i] + " white", 24);
			menuItem.animation.play('idle');
			menuItem.ID = i;
			//menuItem.screenCenter(X);
			menuItems.add(menuItem);
			menuItem.scrollFactor.x = 0;
			menuItem.scrollFactor.y = 0.5;
			menuItem.antialiasing = true;
			if (firstStart)
				FlxTween.tween(menuItem,{y: (i * 160)},1 + (i * 0.25) ,{ease: FlxEase.expoInOut, onComplete: function(flxTween:FlxTween) 
					{ 
						finishedFunnyMove = true; 
						changeItem();
					}});
			else
				menuItem.y = (i * 160);
		}
		//END
		//THERE IS MORE

		firstStart = false;

		FlxG.camera.follow(camFollow, null, 0.60 * (60 / FlxG.save.data.fpsCap));

		var versionShit:FlxText = new FlxText(5, FlxG.height - 18, 0, gameVer +  (Main.watermarks ? " FNF - " + kadeEngineVer + "KE Castle Crashers" : ""), 12);
		versionShit.scrollFactor.set();
		versionShit.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(versionShit);

		// NG.core.calls.event.logEvent('swag').send();


		if (FlxG.save.data.dfjk)
			controls.setKeyboardScheme(KeyboardScheme.Solo, true);
		else
			controls.setKeyboardScheme(KeyboardScheme.Duo(true), true);

		changeItem();

		super.create();
	}

	var selectedSomethin:Bool = false;

	override function update(elapsed:Float)
	{
		if (FlxG.sound.music.volume < 0.8)
		{
			FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
		}
	if (FlxG.save.data.UnlockedBob == false)
		{
		if (FlxG.keys.justPressed.O)
			{
				if (curLetter == 1)
					{
						LetterO = true;
						curLetter = 2;
						FlxG.sound.play(Paths.sound('clicksfx'));
					}
			}
			if (FlxG.keys.justPressed.N)
				{
					if (curLetter == 2)
						{
							LetterN = true;
							curLetter = 3;
							FlxG.sound.play(Paths.sound('clicksfx'));
						}
				}
				if (FlxG.keys.justPressed.S)
					{
						if (curLetter == 3)
							{
								LetterS = true;
								curLetter = 4;
								FlxG.sound.play(Paths.sound('clicksfx'));
							}
					}
					if (FlxG.keys.justPressed.L)
						{
							if (curLetter == 4)
								{
									LetterL = true;
									curLetter = 5;
									FlxG.sound.play(Paths.sound('clicksfx'));
								}
						}
						if (FlxG.keys.justPressed.A)
							{
								if (curLetter == 5)
									{
										LetterA = true;
										curLetter = 6;
										FlxG.sound.play(Paths.sound('clicksfx'));
									}
							}
							if (FlxG.keys.justPressed.U)
								{
									if (curLetter == 6)
										{
											LetterU = true;
											curLetter = 7;
											FlxG.sound.play(Paths.sound('clicksfx'));
										}
								}
								if (FlxG.keys.justPressed.G)
									{
										if (curLetter == 7)
											{
												LetterG = true;
												curLetter = 8;
												FlxG.sound.play(Paths.sound('clicksfx'));
											}
									}
									if (FlxG.keys.justPressed.H)
										{
											if (curLetter == 8)
												{
													LetterN = true;
													curLetter = 9;
													FlxG.sound.play(Paths.sound('clicksfx'));
												}
										}
										if (FlxG.keys.justPressed.T)
											{
												if (curLetter == 9)
													{
														LetterT = true;
														curLetter = 1;
														FlxG.save.data.UnlockedBob = true;
														FlxG.save.flush();
														var popupforthig:FlxSprite = new FlxSprite(0, 0);
														popupforthig.frames = Paths.getSparrowAtlas('Achievement', 'shared');
														popupforthig.antialiasing = true;
														popupforthig.screenCenter();
														popupforthig.animation.addByPrefix('swag', 'Thingy', 24, false);
														add(popupforthig);
														popupforthig.animation.play('swag');
														popupforthig.animation.finishCallback = function(lol:String)
															{
																remove(popupforthig);
															}	
													}
											}
									}	
		if (!selectedSomethin)
		{
			var gamepad:FlxGamepad = FlxG.gamepads.lastActive;

			if (gamepad != null)
			{
				if (gamepad.justPressed.DPAD_UP)
				{
					FlxG.sound.play(Paths.sound('scrollMenu'));
					changeItem(-1);
				}
				if (gamepad.justPressed.DPAD_DOWN)
				{
					FlxG.sound.play(Paths.sound('scrollMenu'));
					changeItem(1);
				}
			}

			if (FlxG.keys.justPressed.UP)
			{
				FlxG.sound.play(Paths.sound('scrollMenu'));
				changeItem(-1);
			}

			if (FlxG.keys.justPressed.DOWN)
			{
				FlxG.sound.play(Paths.sound('scrollMenu'));
				changeItem(1);
			}

			if (controls.BACK)
			{
				FlxG.switchState(new TitleState());
			}

			if (controls.ACCEPT)
			{
				if (optionShit[curSelected] == 'Deez Ballz')
				{
					//fancyOpenURL("https://ninja-muffin24.itch.io/funkin");
				}
				else
				{
					selectedSomethin = true;
					FlxG.sound.play(Paths.sound('confirmMenu'));
					
					if (FlxG.save.data.flashing)

					menuItems.forEach(function(spr:FlxSprite)
					{
						if (curSelected != spr.ID)
						{
							FlxTween.tween(spr, {alpha: 0}, 1.3, {
								ease: FlxEase.quadOut,
								onComplete: function(twn:FlxTween)
								{
									spr.kill();
								}
							});
						}
						else
						{
							if (FlxG.save.data.flashing)
							{
								FlxFlicker.flicker(spr, 1, 0.06, false, false, function(flick:FlxFlicker)
								{
									goToState();
								});
							}
							else
							{
								new FlxTimer().start(1, function(tmr:FlxTimer)
								{
									goToState();
								});
							}
						}
					});
				}
			}
		}

		super.update(elapsed);

		menuItems.forEach(function(spr:FlxSprite)
		{
			//spr.screenCenter(X);
		});
	}
	
	function goToState()
	{
		var daChoice:String = optionShit[curSelected];

		switch (daChoice)
		{
			case 'Boss Rush':
				FlxG.switchState(new StoryMenuState());
				trace("Story Menu Selected");
			case 'Achievements':
				FlxG.switchState(new AchievementState());
				trace("Achievements Menu Selected");
			case 'Skins':
				FlxG.switchState(new SkinState());
				trace("Skins Menu Selected");
			case 'Freeplay':
				FlxG.switchState(new FreeplayState());
				trace("Freeplay Menu Selected");
			case 'Options':
				FlxG.switchState(new OptionsMenu());
		}
	}

	function changeItem(huh:Int = 0)
	{
		if (finishedFunnyMove)
		{
			curSelected += huh;

			if (curSelected >= menuItems.length)
				curSelected = 0;
			if (curSelected < 0)
				curSelected = menuItems.length - 1;
		}
		menuItems.forEach(function(spr:FlxSprite)
		{
			spr.animation.play('idle');

			if (spr.ID == curSelected && finishedFunnyMove)
			{
				spr.animation.play('selected');
				camFollow.setPosition(spr.getGraphicMidpoint().x, spr.getGraphicMidpoint().y);
			}

			spr.updateHitbox();
		});
	}
}
