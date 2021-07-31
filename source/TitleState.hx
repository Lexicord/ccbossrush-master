package;

#if sys
import smTools.SMFile;
#end
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.display.FlxGridOverlay;
import flixel.addons.transition.FlxTransitionSprite.GraphicTransTileDiamond;
import flixel.addons.transition.FlxTransitionableState;
import flixel.addons.transition.TransitionData;
import flixel.graphics.FlxGraphic;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup;
import flixel.input.gamepad.FlxGamepad;
import flixel.math.FlxPoint;
import flixel.math.FlxRect;
import flixel.system.FlxSound;
import flixel.system.ui.FlxSoundTray;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import io.newgrounds.NG;
import lime.app.Application;
import openfl.Assets;

#if windows
import Discord.DiscordClient;
#end

#if cpp
import sys.thread.Thread;
#end

using StringTools;

class TitleState extends MusicBeatState
{
	static var initialized:Bool = false;

	var blackScreen:FlxSprite;
	var credGroup:FlxGroup;
	var credTextShit:Alphabet;
	var textGroup:FlxGroup;
	var ngSpr:FlxSprite;

	var curWacky:Array<String> = [];

	var wackyImage:FlxSprite;

	override public function create():Void
	{
		#if polymod
		polymod.Polymod.init({modRoot: "mods", dirs: ['introMod']});
		#end
		
		#if sys
		if (!sys.FileSystem.exists(Sys.getCwd() + "/assets/replays"))
			sys.FileSystem.createDirectory(Sys.getCwd() + "/assets/replays");
		#end

		@:privateAccess
		{
			trace("Loaded " + openfl.Assets.getLibrary("default").assetsLoaded + " assets (DEFAULT)");
		}
		
		PlayerSettings.init();

		#if windows
		DiscordClient.initialize();

		Application.current.onExit.add (function (exitCode) {
			DiscordClient.shutdown();
		 });
		 
		#end

		curWacky = FlxG.random.getObject(getIntroTextShit());

		trace('hello');

		// DEBUG BULLSHIT

		super.create();

		// NGio.noLogin(APIStuff.API);

		#if ng
		var ng:NGio = new NGio(APIStuff.API, APIStuff.EncKey);
		trace('NEWGROUNDS LOL');
		#end

		FlxG.save.bind('funkin', 'lexicord');

		KadeEngineData.initSave();

		// var file:SMFile = SMFile.loadFile("file.sm");
		// this was testing things
		
		Highscore.load();

		if (FlxG.save.data.weekUnlocked != null)
		{
			// FIX LATER!!!
			// WEEK UNLOCK PROGRESSION!!
			// StoryMenuState.weekUnlocked = FlxG.save.data.weekUnlocked;

			if (StoryMenuState.weekUnlocked.length < 4)
				StoryMenuState.weekUnlocked.insert(0, true);

			// QUICK PATCH OOPS!
			if (!StoryMenuState.weekUnlocked[0])
				StoryMenuState.weekUnlocked[0] = true;
		}

		#if FREEPLAY
		FlxG.switchState(new FreeplayState());
		#elseif CHARTING
		FlxG.switchState(new ChartingState());
		#else
		new FlxTimer().start(1, function(tmr:FlxTimer)
		{
			startIntro();
		});
		#end
	}

	var logoBl:FlxSprite;
	var danceLeft:Bool = false;
	var titleText:FlxSprite;

	function startIntro()
	{
		if (!initialized)
		{
			var diamond:FlxGraphic = FlxGraphic.fromClass(GraphicTransTileDiamond);
			diamond.persist = true;
			diamond.destroyOnNoUse = false;

			FlxTransitionableState.defaultTransIn = new TransitionData(FADE, FlxColor.BLACK, 1, new FlxPoint(0, -1), {asset: diamond, width: 32, height: 32},
				new FlxRect(-200, -200, FlxG.width * 1.4, FlxG.height * 1.4));
			FlxTransitionableState.defaultTransOut = new TransitionData(FADE, FlxColor.BLACK, 0.7, new FlxPoint(0, 1),
				{asset: diamond, width: 32, height: 32}, new FlxRect(-200, -200, FlxG.width * 1.4, FlxG.height * 1.4));

			transIn = FlxTransitionableState.defaultTransIn;
			transOut = FlxTransitionableState.defaultTransOut;

			// HAD TO MODIFY SOME BACKEND SHIT
			// IF THIS PR IS HERE IF ITS ACCEPTED UR GOOD TO GO
			// https://github.com/HaxeFlixel/flixel-addons/pull/348

			// var music:FlxSound = new FlxSound();
			// music.loadStream(Paths.music('freakyMenu'));
			// FlxG.sound.list.add(music);
			// music.play();
			if (FlxG.save.data.BEATDAGAME == false)
				{
					FlxG.sound.playMusic(Paths.music('freakyMenu'));
				}
				else 
				{
					FlxG.sound.playMusic(Paths.music('therace'));
				}
			FlxG.sound.music.fadeIn(4, 0, 0.7);
		}

		Conductor.changeBPM(135);
		persistentUpdate = true;

		var BG:FlxSprite = new FlxSprite(0,0).loadGraphic(Paths.image('TitleBG'));
		BG.antialiasing = true;
		BG.active = false;
		BG.screenCenter();
		BG.scrollFactor.set();
		add(BG);

		logoBl = new FlxSprite(-150, -100);
		logoBl.frames = Paths.getSparrowAtlas('logoBumpin');
		logoBl.antialiasing = true;
		logoBl.setGraphicSize(Std.int(logoBl.width / 1.5));
		logoBl.updateHitbox();
		logoBl.screenCenter();
		logoBl.y -= 85;

		add(logoBl);

		var ballz:FlxSprite = new FlxSprite(0,0);
		ballz.frames = Paths.getSparrowAtlas('revived');
		ballz.antialiasing = true;
		ballz.animation.addByPrefix('shiny', 'revivedbump', 24);
		ballz.setPosition(logoBl.x, logoBl.y);
		ballz.y += 385;
		ballz.x += 135;

		add(ballz);
		ballz.animation.play('shiny');
		
		var logo:FlxSprite = new FlxSprite(-150, -100);
		logo.frames = Paths.getSparrowAtlas('logoBumpin');
		logo.antialiasing = true;
		logo.setGraphicSize(Std.int(logo.width / 1.5));
		logo.updateHitbox();
		logo.screenCenter();
		logo.alpha = 0.65;
	//	add(logo);

		titleText = new FlxSprite(100, FlxG.height * 0.8);
		titleText.frames = Paths.getSparrowAtlas('titleEnter');
		titleText.animation.addByPrefix('idle', "Press Enter to Begin", 24);
		titleText.animation.addByPrefix('press', "ENTER PRESSED", 24);
		titleText.antialiasing = true;
		titleText.animation.play('idle');
		titleText.updateHitbox();
		// titleText.screenCenter(X);
		add(titleText);

	//	FlxG.mouse.visible = true;

		FlxTween.tween(logoBl, {y: logoBl.y + 135}, 0.85, {ease: FlxEase.quadInOut, type: PINGPONG});
		//FlxTween.tween(logo, {y: logoBl.y + 135}, 0.85, {ease: FlxEase.quadInOut, type: PINGPONG, startDelay: 0.2});
		FlxTween.tween(ballz, {y: ballz.y + 135}, 0.85, {ease: FlxEase.quadInOut, type: PINGPONG, startDelay: 0.1});

		credGroup = new FlxGroup();
		add(credGroup);
		textGroup = new FlxGroup();

		blackScreen = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		credGroup.add(blackScreen);

		credTextShit = new Alphabet(0, 0, "ninjamuffin99\nPhantomArcade\nkawaisprite\nevilsk8er", true);
		credTextShit.screenCenter();

		// credTextShit.alignment = CENTER;

		credTextShit.visible = false;

		ngSpr = new FlxSprite(0, FlxG.height * 0.52).loadGraphic(Paths.image('newgrounds_logo'));
		add(ngSpr);
		ngSpr.visible = false;
		ngSpr.setGraphicSize(Std.int(ngSpr.width * 0.8));
		ngSpr.updateHitbox();
		ngSpr.screenCenter(X);
		ngSpr.antialiasing = true;

		FlxTween.tween(credTextShit, {y: credTextShit.y + 20}, 2.9, {ease: FlxEase.quadInOut, type: PINGPONG});

		FlxG.mouse.visible = false;

		if (initialized)
			skipIntro();
		else
			initialized = true;

		// credGroup.add(credTextShit);
	}

	function getIntroTextShit():Array<Array<String>>
	{
		var fullText:String = Assets.getText(Paths.txt('introText'));

		var firstArray:Array<String> = fullText.split('\n');
		var swagGoodArray:Array<Array<String>> = [];

		for (i in firstArray)
		{
			swagGoodArray.push(i.split('--'));
		}

		return swagGoodArray;
	}

	var transitioning:Bool = false;

	override function update(elapsed:Float)
	{
		if (FlxG.sound.music != null)
			Conductor.songPosition = FlxG.sound.music.time;
		// FlxG.watch.addQuick('amp', FlxG.sound.music.amplitude);

		if (FlxG.keys.justPressed.F)
		{
			FlxG.fullscreen = !FlxG.fullscreen;
		}

	//	FlxG.camera.setPosition(FlxG.mouse.screenX, FlxG.mouse.screenY);

		var pressedEnter:Bool = controls.ACCEPT;

		#if mobile
		for (touch in FlxG.touches.list)
		{
			if (touch.justPressed)
			{
				pressedEnter = true;
			}
		}
		#end

		if (pressedEnter && !transitioning && skippedIntro)
		{
			#if !switch
			NGio.unlockMedal(60960);

			// If it's Friday according to da clock
			if (Date.now().getDay() == 5)
				NGio.unlockMedal(61034);
			#end

			if (FlxG.save.data.flashing)
				titleText.animation.play('press');

			FlxG.camera.flash(FlxColor.WHITE, 1);
			FlxG.sound.play(Paths.sound('confirmMenu'), 0.7);

			transitioning = true;
			// FlxG.sound.music.stop();

			MainMenuState.firstStart = true;

			new FlxTimer().start(2, function(tmr:FlxTimer)
			{
				// Get current version of Kade Engine
				
				var http = new haxe.Http("https://raw.githubusercontent.com/KadeDev/Kade-Engine/master/version.downloadMe");
				var returnedData:Array<String> = [];
				
				http.onData = function (data:String)
				{
					returnedData[0] = data.substring(0, data.indexOf(';'));
					returnedData[1] = data.substring(data.indexOf('-'), data.length);
				  	if (!MainMenuState.kadeEngineVer.contains(returnedData[0].trim()) && !OutdatedSubState.leftState && MainMenuState.nightly == "")
					{
						trace('outdated lmao! ' + returnedData[0] + ' != ' + MainMenuState.kadeEngineVer);
						OutdatedSubState.needVer = returnedData[0];
						OutdatedSubState.currChanges = returnedData[1];
						FlxG.switchState(new OutdatedSubState());
					}
					else
					{
						FlxG.switchState(new MainMenuState());
					}
				}
				
				http.onError = function (error) {
				  trace('error: $error');
				  FlxG.switchState(new MainMenuState()); // fail but we go anyway
				}
				
				http.request();
			});
			// FlxG.sound.play(Paths.music('titleShoot'), 0.7);
		}

		if (pressedEnter && !skippedIntro && initialized)
		{
			skipIntro();
		}

		super.update(elapsed);
	}

	function createCoolText(textArray:Array<String>)
	{
		for (i in 0...textArray.length)
		{
			var money:Alphabet = new Alphabet(0, 0, textArray[i], true, false);
			money.screenCenter(X);
			money.y += (i * 60) + 200;
			credGroup.add(money);
			textGroup.add(money);
		}
	}

	function addMoreText(text:String)
	{
		var coolText:Alphabet = new Alphabet(0, 0, text, true, false);
		coolText.screenCenter(X);
		coolText.y += (textGroup.length * 60) + 200;
		credGroup.add(coolText);
		textGroup.add(coolText);
	}

	function deleteCoolText()
	{
		while (textGroup.members.length > 0)
		{
			credGroup.remove(textGroup.members[0], true);
			textGroup.remove(textGroup.members[0], true);
		}
	}

	override function beatHit()
	{
		super.beatHit();

		FlxG.log.add(curBeat);

		FlxTween.tween(FlxG.camera, {zoom:1.05}, 0.3, {ease: FlxEase.quadOut, type: BACKWARD});


		switch (curBeat)
		{
			case 4:
				createCoolText(['Credits To']);
			// credTextShit.visible = true;
			case 5:
				addMoreText('Banbuds');
			case 6:
				addMoreText('KadeDeveloper');
			case 7:
				addMoreText('Tsuraran');
			case 8:
				addMoreText('YingYang48');
			case 9:
				addMoreText('Brandxn');
			case 10: 
				addMoreText('SugarRatio');
			case 12:
				deleteCoolText();
				createCoolText(['Revived By']);
			case 13:
				addMoreText('Lexicord');
			case 14:
				addMoreText('MadBear422');
			case 15:
				addMoreText('Wizord');
			case 16:
				addMoreText('Proffesorbonnie');
			case 17:
				addMoreText('Goodenoty');
			case 18:
				addMoreText('Goodenoty');
			case 19:
				addMoreText('XG_Chris');
			case 21:
				deleteCoolText();
				createCoolText([curWacky[0]]);
			case 22:
				addMoreText(curWacky[1]);
			case 23:
				deleteCoolText();
				curWacky = FlxG.random.getObject(getIntroTextShit());
				createCoolText([curWacky[0]]);
			case 24:
				addMoreText(curWacky[1]);
			case 25:
				deleteCoolText();
				curWacky = FlxG.random.getObject(getIntroTextShit());
				createCoolText([curWacky[0]]);
			case 26: 
				addMoreText(curWacky[1]);
			case 27: 
				deleteCoolText();
				curWacky = FlxG.random.getObject(getIntroTextShit());
				createCoolText([curWacky[0]]);	
			case 28:
				addMoreText(curWacky[1]);
			case 29:
				deleteCoolText();
				curWacky = FlxG.random.getObject(getIntroTextShit());
				createCoolText([curWacky[0]]);	
			case 30: 
				addMoreText(curWacky[1]);
			case 31:
				deleteCoolText();
				curWacky = FlxG.random.getObject(getIntroTextShit());
				createCoolText([curWacky[0]]);	
			case 32: 
				addMoreText(curWacky[1]);
			case 33:
				deleteCoolText();
				curWacky = FlxG.random.getObject(getIntroTextShit());
				createCoolText([curWacky[0]]);	
			case 34: 
				addMoreText(curWacky[1]);
			case 35:
				deleteCoolText();
				curWacky = FlxG.random.getObject(getIntroTextShit());
				createCoolText([curWacky[0]]);	
			case 36: 
				addMoreText(curWacky[1]);
			case 37:
				deleteCoolText();
				curWacky = FlxG.random.getObject(getIntroTextShit());
				createCoolText([curWacky[0]]);	
			case 38: 
				addMoreText(curWacky[1]);
			case 39:
				deleteCoolText();
				createCoolText(['Da Beat Drop']);
			case 42:
				addMoreText('lmao');
			case 43:
				skipIntro();
		}
	}

	var skippedIntro:Bool = false;

	function skipIntro():Void
	{
		if (!skippedIntro)
		{
			remove(ngSpr);

			FlxG.camera.flash(FlxColor.WHITE, 0.75);
			remove(credGroup);
			skippedIntro = true;
		}
	}
}
