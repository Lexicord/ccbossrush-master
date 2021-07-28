package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSubState;
import flixel.math.FlxPoint;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import flixel.text.FlxText;
import flixel.FlxSprite;

class GameOverSubstate extends MusicBeatSubstate
{
	var bf:Boyfriend;
	var camFollow:FlxObject;

	var stageSuffix:String = "";

	public function new(x:Float, y:Float)
	{
		var daStage = PlayState.curStage;
		var daBf:String = 'bfdiess';

		super();

		Conductor.songPosition = 0;

		bf = new Boyfriend(x, y, daBf);
		add(bf);

		if (FlxG.save.data.LoseToBarb == false)
			{
				FlxG.save.data.LoseToBarb = true;
				FlxG.save.flush();
				FlxG.sound.play(Paths.sound('errorsfx'));
			}

		camFollow = new FlxObject(bf.getGraphicMidpoint().x, bf.getGraphicMidpoint().y, 1, 1);
		add(camFollow);

		FlxG.sound.play(Paths.sound('fnf_loss_sfx' + stageSuffix));
		Conductor.changeBPM(100);

		// FlxG.camera.followLerp = 1;
		// FlxG.camera.focusOn(FlxPoint.get(FlxG.width / 2, FlxG.height / 2));
		FlxG.camera.scroll.set();
		FlxG.camera.target = null;

		bf.playAnim('firstDeath');
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (controls.ACCEPT)
		{
			endBullshit();
		}

		if (controls.BACK)
		{
			FlxG.sound.music.stop();

			if (PlayState.isStoryMode)
				FlxG.switchState(new StoryMenuState());
			else
				FlxG.switchState(new FreeplayState());
			PlayState.loadRep = false;
		}

		if (bf.animation.curAnim.name == 'firstDeath' && bf.animation.curAnim.curFrame == 12)
		{
			FlxG.camera.follow(camFollow, LOCKON, 0.01);
		}

		if (bf.animation.curAnim.name == 'firstDeath' && bf.animation.curAnim.finished)
		{ 
			if (PlayState.SONG.player2 == 'painter') // this code is giving me a brain tumor but it works so who cares lol!
			{
			var randcool:Int = FlxG.random.int(1, 5);
				FlxG.sound.play(Paths.sound('painterquote' + randcool));
				if (randcool == 1)
				{
					var txt:FlxText = new FlxText(0, 0, FlxG.width, "Achievement Unlocked, You are a Faliure.",	18);
						txt.setFormat("VCR OSD Mono", 32, FlxColor.fromRGB(200, 200, 200), CENTER);
						txt.borderColor = FlxColor.BLACK;
						txt.borderSize = 3;
						txt.borderStyle = FlxTextBorderStyle.OUTLINE;
						txt.screenCenter();
						txt.y -= 350;
						add(txt);
				}
				else if (randcool == 2)
				{
					var txt:FlxText = new FlxText(0, 0, FlxG.width, "I'm in your Castle.",	18);
						txt.setFormat("VCR OSD Mono", 32, FlxColor.fromRGB(200, 200, 200), CENTER);
						txt.borderColor = FlxColor.BLACK;
						txt.borderSize = 3;
						txt.borderStyle = FlxTextBorderStyle.OUTLINE;
						txt.screenCenter();
						txt.y -= 350;
						add(txt);
				}
				else if (randcool == 3)
				{
					var txt:FlxText = new FlxText(0, 0, FlxG.width, "My Art Will Be Your Demise.",	18);
						txt.setFormat("VCR OSD Mono", 32, FlxColor.fromRGB(200, 200, 200), CENTER);
						txt.borderColor = FlxColor.BLACK;
						txt.borderSize = 3;
						txt.borderStyle = FlxTextBorderStyle.OUTLINE;
						txt.screenCenter();
						txt.y -= 350;
						add(txt);

				}
				else if (randcool == 4)
				{
					var txt:FlxText = new FlxText(0, 0, FlxG.width, "My Brush Is Mightier Than Your Sword.", 18);
						txt.setFormat("VCR OSD Mono", 32, FlxColor.fromRGB(200, 200, 200), CENTER);
						txt.borderColor = FlxColor.BLACK;
						txt.borderSize = 3;
						txt.borderStyle = FlxTextBorderStyle.OUTLINE;
						txt.screenCenter();
						txt.y -= 350;
						add(txt);
				}
				else if (randcool == 5)
				{
					var txt:FlxText = new FlxText(0, 0, FlxG.width, "It Must've Been Something I Ate.",	18);
						txt.setFormat("VCR OSD Mono", 32, FlxColor.fromRGB(200, 200, 200), CENTER);
						txt.borderColor = FlxColor.BLACK;
						txt.borderSize = 3;
						txt.borderStyle = FlxTextBorderStyle.OUTLINE;
						txt.screenCenter();
						txt.y -= 350;
						add(txt);
				}
			}
			FlxG.sound.playMusic(Paths.music('gameOver' + stageSuffix));
		}

		if (FlxG.sound.music.playing)
		{
			Conductor.songPosition = FlxG.sound.music.time;
		}
	}

	override function beatHit()
	{
		super.beatHit();

		FlxG.log.add('beat');
	}

	var isEnding:Bool = false;

	function endBullshit():Void
	{
		if (!isEnding)
		{
			isEnding = true;
			bf.playAnim('deathConfirm', true);
			FlxG.sound.music.stop();
			FlxG.sound.play(Paths.music('gameOverEnd' + stageSuffix));
			new FlxTimer().start(0.7, function(tmr:FlxTimer)
			{
				FlxG.camera.fade(FlxColor.BLACK, 2, false, function()
				{
					LoadingState.loadAndSwitchState(new PlayState());
				});
			});
		}
	}
}
