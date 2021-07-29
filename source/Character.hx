package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.animation.FlxBaseAnimation;
import flixel.graphics.frames.FlxAtlasFrames;

using StringTools;

class Character extends FlxSprite
{
	public var animOffsets:Map<String, Array<Dynamic>>;
	public var debugMode:Bool = false;

	public var isPlayer:Bool = false;
	public var curCharacter:String = 'bf';

	public var holdTimer:Float = 0;

	public var otherFrames:Array<Character>;

	public function new(x:Float, y:Float, ?character:String = "bf", ?isPlayer:Bool = false, ?isDebug:Bool = false)
	{
		super(x, y);

		animOffsets = new Map<String, Array<Dynamic>>();
		curCharacter = character;
		this.isPlayer = isPlayer;

		var tex:FlxAtlasFrames;
		antialiasing = true;

		switch (curCharacter)
		{
			case 'gf':
				// GIRLFRIEND CODE
				tex = Paths.getSparrowAtlas('characters/GF_assets');
				frames = tex;
				animation.addByIndices('sad', 'gf sad', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12], "", 24, false);
				animation.addByIndices('danceLeft', 'GF Dancing Beat', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'GF Dancing Beat', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);

				addOffset('sad', -2, -2);
				addOffset('danceLeft', 0, -9);
				addOffset('danceRight', 0, -9);

				playAnim('danceRight');

			case 'gf-ice':
				tex = Paths.getSparrowAtlas('iceking/GF_ice');
				frames = tex;
				animation.addByIndices('sad', 'gf sad', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12], "", 24, false);
				animation.addByIndices('danceLeft', 'GF Dancing Beat', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'GF Dancing Beat', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);

				addOffset('sad', -2, -2);
				addOffset('danceLeft', 0, -9);
				addOffset('danceRight', 0, -9);

				playAnim('danceRight');

			case 'dad':
				// DAD ANIMATION LOADING CODE
				tex = Paths.getSparrowAtlas('characters/DADDY_DEAREST', 'shared');
				frames = tex;
				animation.addByPrefix('idle', 'Dad idle dance', 24);
				animation.addByPrefix('singUP', 'Dad Sing Note UP', 24);
				animation.addByPrefix('singRIGHT', 'Dad Sing Note RIGHT', 24);
				animation.addByPrefix('singDOWN', 'Dad Sing Note DOWN', 24);
				animation.addByPrefix('singLEFT', 'Dad Sing Note LEFT', 24);

				addOffset('idle');
				addOffset("singUP", -6, 50);
				addOffset("singRIGHT", 0, 27);
				addOffset("singLEFT", -10, 10);
				addOffset("singDOWN", 0, -30);

				playAnim('idle');
			case 'bf-frozen':
				var tex = Paths.getSparrowAtlas('iceking/bf-frozen');
				frames = tex;
				animation.addByPrefix('idle', 'frozen idle', 24, false);
				animation.addByPrefix('shake', 'frozen shake', 24, true);

				addOffset('idle', -5);
				addOffset("shake", 15, 150);

				playAnim('idle');

				flipX = true;
			case 'iceking':
				tex = Paths.getSparrowAtlas('iceking/iceking', 'shared');
				frames = tex;
				animation.addByPrefix('idle', 'Ice Idle Dance', 24);
				animation.addByPrefix('singUP', 'Ice Note Up', 24);
				animation.addByPrefix('singRIGHT', 'Ice Note Right', 24);
				animation.addByPrefix('singDOWN', 'Ice Note Down', 24);
				animation.addByPrefix('singLEFT', 'Ice Note Left', 24);

				addOffset('idle');
				addOffset("singUP", 500, 310);
				addOffset("singRIGHT", -50, 160);
				addOffset("singLEFT", 220, 10);
				addOffset("singDOWN", 760, 80);

				playAnim('idle');
			case 'painter':
				tex = Paths.getSparrowAtlas('painter/character/painter', 'shared');
				frames = tex;
				animation.addByPrefix('idle', 'Painter Idle', 24);
				animation.addByPrefix('singUP', 'Painter Note Up', 24);
				animation.addByPrefix('singRIGHT', 'Painter Note Right', 24);
				animation.addByPrefix('singDOWN', 'Painter Note Down', 24);
				animation.addByPrefix('singLEFT', 'Painter Note Left', 24);

				addOffset('idle');
				addOffset("singUP", 60, 20);
				addOffset("singRIGHT", 20, 40);
				addOffset("singLEFT", 220, 40);
				addOffset("singDOWN", 0, 30);

				playAnim('idle');

			case 'evilwizard':
				tex = Paths.getSparrowAtlas('evilwiz/wizard');
				frames = tex;
				animation.addByPrefix('idle', "Evil Wizard Idle Dance", 24);
				animation.addByPrefix('singUP', 'Evil Wizard Note Up', 24, false);
				animation.addByPrefix('singDOWN', 'Evil Wizard Note Down', 24, false);
				animation.addByPrefix('singLEFT', 'Evil Wizard Note Left', 24, false);
				animation.addByPrefix('singRIGHT', 'Evil Wizard Note Right', 24, false);
	
				addOffset('idle');
				addOffset("singUP", 360, 215);
				addOffset("singRIGHT", -10, 33);
				addOffset("singLEFT", 45, 45);
				addOffset("singDOWN", 95, 175);

				playAnim('idle');
			case 'necromancer':
				tex = Paths.getSparrowAtlas('necromancer/Necromancer_Assets');
				frames = tex;
				animation.addByPrefix('idle', "Necromancer Idle", 24);
				animation.addByPrefix('singUP', 'Necromancer Up', 24, false);
				animation.addByPrefix('singDOWN', 'Necromancer Down', 24, false);
				animation.addByPrefix('singLEFT', 'Necromancer Left', 24, false);
				animation.addByPrefix('singRIGHT', 'Necromancer Right', 24, false);
	
				addOffset('idle');
				addOffset("singUP", -10, 120);
				addOffset("singRIGHT", 20, 10);
				addOffset("singLEFT", 30, 0);
				addOffset("singDOWN", 0, 90);

				playAnim('idle');
			case 'bfdiess':
				var tex = Paths.getSparrowAtlas('characters/BOYFRIEND');
				frames = tex;
				animation.addByPrefix('idle', 'BF idle dance', 24, false);

				animation.addByPrefix('firstDeath', "BF dies", 24, false);
				animation.addByPrefix('deathLoop', "BF Dead Loop", 24, true);
				animation.addByPrefix('deathConfirm', "BF Dead confirm", 24, false);


				addOffset('idle', -5);
				addOffset('firstDeath', 37, 11);
				addOffset('deathLoop', 37, 5);
				addOffset('deathConfirm', 37, 69);

				playAnim('idle');

				flipX = true;
			case 'bf':
				var tex = Paths.getSparrowAtlas('characters/BOYFRIEND' + FlxG.save.data.bfskin, 'shared');
				frames = tex;

				trace(tex.frames.length);

				animation.addByPrefix('idle', 'BF idle dance', 24, false);
				animation.addByPrefix('singUP', 'BF NOTE UP0', 24, false);
				animation.addByPrefix('singLEFT', 'BF NOTE LEFT0', 24, false);
				animation.addByPrefix('singRIGHT', 'BF NOTE RIGHT0', 24, false);
				animation.addByPrefix('singDOWN', 'BF NOTE DOWN0', 24, false);
				animation.addByPrefix('singUPmiss', 'BF NOTE UP MISS', 24, false);
				animation.addByPrefix('singLEFTmiss', 'BF NOTE LEFT MISS', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'BF NOTE RIGHT MISS', 24, false);
				animation.addByPrefix('singDOWNmiss', 'BF NOTE DOWN MISS', 24, false);

				animation.addByPrefix('TakeDamage', 'BF hit', 24, false);
				addOffset("TakeDamage", 7, 4);

				if (FlxG.save.data.bfskin == "")
				{
					animation.addByPrefix('Dodge', 'boyfriend dodge', 24, false);
					addOffset("Dodge", 7, 4);
				}

				animation.addByPrefix('hey', 'BF HEY', 24, false);

				animation.addByPrefix('firstDeath', "BF dies", 24, false);
				animation.addByPrefix('deathLoop', "BF Dead Loop", 24, true);
				animation.addByPrefix('deathConfirm', "BF Dead confirm", 24, false);
				
				animation.addByPrefix('scared', 'BF idle shaking', 24);

				if (FlxG.save.data.bfskin == "BOB")
				{
					animation.addByPrefix('idle', 'bob_idle', 24, false);
					animation.addByPrefix('singUP', 'bob_UP', 24, false);
					animation.addByPrefix('singLEFT', 'bob_LEFT', 24, false);
					animation.addByPrefix('singRIGHT', 'bob_RIGHT', 24, false);
					animation.addByPrefix('singDOWN', 'bob_DOWN', 24, false);
					animation.addByPrefix('singUPmiss', 'bob1_UPMiss', 24, false);
					animation.addByPrefix('singLEFTmiss', 'bob1_LEFTMiss', 24, false);
					animation.addByPrefix('singRIGHTmiss', 'bob1_RIGHTMiss', 24, false);
					animation.addByPrefix('singDOWNmiss', 'bob1_DOWNMiss', 24, false);
					animation.addByPrefix('TakeDamage', 'bob_hit', 24, false);

					animation.addByPrefix('firstDeath', "bob_first_death", 24, false);
					animation.addByPrefix('deathLoop', "bob_deadloop", 24, true);
					animation.addByPrefix('deathConfirm', "bob_deadconfirm", 24, false);
	
				}

				switch (FlxG.save.data.bfskin)
				{
					case 'PURPLE':
					{
						addOffset('idle', -5, 91);
						addOffset("singUP", -29, 118);
						addOffset("singRIGHT", -38, 84);
						addOffset("singLEFT", 12, 86);
						addOffset("singDOWN", -10, 41);
						addOffset("singUPmiss", -29, 118);
						addOffset("singRIGHTmiss", -30, 112);
						addOffset("singLEFTmiss", 12, 115);
						addOffset("singDOWNmiss", -11, 72);
						addOffset("hey", 7, 95);
						addOffset('firstDeath', 37, 11);
						addOffset('deathLoop', 37, 5);
						addOffset('deathConfirm', 37, 69);
						addOffset('scared', -4, 91);
					}
					case "BOB":
					{
						addOffset('idle', 50, 90);
						addOffset("singUP", 55, 85);
						addOffset("singRIGHT", 75, 90);
						addOffset("singLEFT", 77, 85);
						addOffset("singDOWN", 55, 85);
						addOffset("singUPmiss", 67, 85);
						addOffset("singRIGHTmiss", 60, 85);
						addOffset("singLEFTmiss", 50, 85);
						addOffset("singDOWNmiss", 55, 90);
						addOffset('firstDeath', -60, 65);
						addOffset('deathLoop', -110, 60);
						addOffset('deathConfirm', -108, 65);
						addOffset('TakeDamage', -70, 30);
					}
					case "ICESKIMO":
					{
						addOffset('idle', -30, 50);
						addOffset("singUP", -70, 30);
						addOffset("singRIGHT", -85, 50);
						addOffset("singLEFT", -58, 26);
						addOffset("singDOWN", -80, -15);
						addOffset("singUPmiss", -70, 85);
						addOffset("singRIGHTmiss", -90, 70);
						addOffset("singLEFTmiss", -60, 55);
						addOffset("singDOWNmiss", -60, 25);
						addOffset("hey", -23, 50);
						addOffset('scared', -35, 35);
					}
					default:
					{
						addOffset('idle', -5);
						addOffset("singUP", -29, 27);
						addOffset("singRIGHT", -38, -7);
						addOffset("singLEFT", 12, -6);
						addOffset("singDOWN", -10, -50);
						addOffset("singUPmiss", -29, 27);
						addOffset("singRIGHTmiss", -30, 21);
						addOffset("singLEFTmiss", 12, 24);
						addOffset("singDOWNmiss", -11, -19);
						addOffset("hey", 7, 4);
						addOffset('firstDeath', 37, 11);
						addOffset('deathLoop', 37, 5);
						addOffset('deathConfirm', 37, 69);
						addOffset('scared', -4);
					}
				}

				playAnim('idle');

				flipX = true;

			case 'spider':
				frames = Paths.getSparrowAtlas("evilwiz/spider/idle");

				animation.addByPrefix("idle","Spider Idle Dance", 24, true);

				otherFrames = [];

				trace('poggers');

				otherFrames.push(new Character(x,y,"spider-left"));
				otherFrames.push(new Character(x,y,"spider-right"));
				otherFrames.push(new Character(x,y,"spider-up"));
				otherFrames.push(new Character(x,y,"spider-down"));

				addOffset('idle',0,0);

				trace('adding shit');

				for (i in otherFrames)
				{
					if (isDebug)
						AnimationDebug.staticVar.add(i);
					i.visible = false;
				}

				trace('poggers');

				playAnim('idle');
	
			case 'spider-right':

				frames = Paths.getSparrowAtlas("evilwiz/spider/right");

				animation.addByPrefix("idle","Spider Note Right", 24, false);

				addOffset('idle', 1860, 901);

				playAnim('idle');
				trace('right');
	
			case 'spider-left':

				frames = Paths.getSparrowAtlas("evilwiz/spider/left");

				animation.addByPrefix("idle","Spider Note Left", 24, false);


				addOffset('idle', 2910, 630);

				playAnim('idle');


				trace('left');
			case 'spider-down':
				frames = Paths.getSparrowAtlas("evilwiz/spider/down");

				animation.addByPrefix("idle","Spider Note Down", 24, false);

				addOffset('idle', 2527, 498);

				playAnim('idle');
				trace('down');
			case 'spider-up':
				frames = Paths.getSparrowAtlas("evilwiz/spider/up");

				animation.addByPrefix("idle","Spider Note Up", 24, false);

				addOffset('idle', 2210, 932);

				playAnim('idle');
				trace('up');
			case 'myfnfocDONTSTEAL':
				var tex = Paths.getSparrowAtlas('myfnfocDONTSTEAL');
				frames = tex;
				animation.addByPrefix('idle', 'myfnfocDONTSTEAL idle', 24, false);

				addOffset('idle');
				playAnim('idle');

			case 'barb':
				var tex = Paths.getSparrowAtlas('barbb/barbchamp');
				frames = tex;
				animation.addByPrefix('idle', 'Barb Idle', 24, false);
				animation.addByPrefix('singUP', 'UP barbarian', 24, false);
				animation.addByPrefix('singLEFT', 'LEFT pose barbarian', 24, false);
				animation.addByPrefix('singRIGHT', 'Barbarian RIGHT animation', 24, false);
				animation.addByPrefix('singDOWN', 'DOWN', 24, false);

				addOffset('idle', -5);
				addOffset("singUP", -20, 55);
				addOffset("singRIGHT", -150, 90);
				addOffset("singLEFT", 520, -25);
				addOffset("singDOWN", -30, -50);
				playAnim('idle');
			case 'cyclops':
                var tex = Paths.getSparrowAtlas('cyclops/character/cyclops_undead');
                frames = tex;
                animation.addByPrefix('idle', 'Cyclops Note Idle', 24, false);
                animation.addByPrefix('singUP', 'Cyclops Note Up', 24, false);
                animation.addByPrefix('singLEFT', 'Cyclops Note Left', 24, false);
                animation.addByPrefix('singRIGHT', 'Cyclops Note Right', 24, false);
                animation.addByPrefix('singDOWN', 'Cyclops Note Down', 24, false);
				
				addOffset('idle', -5);
                addOffset("singUP", 31, 65);
                addOffset("singRIGHT", -120, -100);
                addOffset("singLEFT", 160, -55);
                addOffset("singDOWN", -60, -160);
                playAnim('idle');
			case 'cyclops-groom':
				var tex = Paths.getSparrowAtlas('cyclops/character/groom_undead');
				frames = tex;
				animation.addByPrefix('idle', 'Cyclops Note Idle', 24, false);
				animation.addByPrefix('singUP', 'Groom Note Up', 24, false);
				animation.addByPrefix('singLEFT', 'Groom Note Left', 24, false);
				animation.addByPrefix('singRIGHT', 'Groom Note Right', 24, false);
				animation.addByPrefix('singDOWN', 'Groom Note Down', 24, false);

				addOffset('idle', -5);
				addOffset("singUP", 120, 235);
				addOffset("singRIGHT", 40, -10);
				addOffset("singLEFT", 521,25);
				addOffset("singDOWN", 170, -70);
				playAnim('idle');
		}

		dance();

		if (isPlayer)
		{
			flipX = !flipX;

			// Doesn't flip for BF, since his are already in the right place???
			if (!curCharacter.startsWith('bf'))
			{
				// var animArray
				var oldRight = animation.getByName('singRIGHT').frames;
				animation.getByName('singRIGHT').frames = animation.getByName('singLEFT').frames;
				animation.getByName('singLEFT').frames = oldRight;

				// IF THEY HAVE MISS ANIMATIONS??
				if (animation.getByName('singRIGHTmiss') != null)
				{
					var oldMiss = animation.getByName('singRIGHTmiss').frames;
					animation.getByName('singRIGHTmiss').frames = animation.getByName('singLEFTmiss').frames;
					animation.getByName('singLEFTmiss').frames = oldMiss;
				}
			}
		}
	}

	override function update(elapsed:Float)
	{
		if (!curCharacter.startsWith('bf'))
		{
			if (animation.curAnim.name.startsWith('sing'))
			{
				holdTimer += elapsed;
			}

			var dadVar:Float = 4;

			if (curCharacter == 'dad')
				dadVar = 6.1;
			if (holdTimer >= Conductor.stepCrochet * dadVar * 0.001)
			{
				trace('dance');
				dance();
				holdTimer = 0;
			}
		}

		super.update(elapsed);
	}

	private var danced:Bool = false;

	/**
	 * FOR GF DANCING SHIT
	 */
	public function dance()
	{
		if (!debugMode)
		{
			switch (curCharacter)
			{
				case 'gf':
					danced = !danced;

					if (danced)
						playAnim('danceRight');
					else
						playAnim('danceLeft');
				case 'gf-ice':
					danced = !danced;

					if (danced)
						playAnim('danceRight');
					else
						playAnim('danceLeft');
				default:
					playAnim('idle');
			}
		}
	}

	public function playAnim(AnimName:String, Force:Bool = false, Reversed:Bool = false, Frame:Int = 0):Void
	{
		if (debugMode && otherFrames != null)
		{
			if (AnimationDebug.dad != null)
			{
				trace('debug play anim ' + AnimName);
				AnimationDebug.dad.alpha = 0.6;
				for(i in otherFrames)
					i.visible = false;
				switch(AnimName)
				{
					case 'singLEFT':
						otherFrames[0].visible = true;
						otherFrames[0].playAnim('idle', Force, Reversed, Frame);
					case 'singRIGHT':
						otherFrames[1].visible = true;
						otherFrames[1].playAnim('idle', Force, Reversed, Frame);
					case 'singUP':
						otherFrames[2].visible = true;
						otherFrames[2].playAnim('idle', Force, Reversed, Frame);
					case 'singDOWN':
						otherFrames[3].visible = true;
						otherFrames[3].playAnim('idle', Force, Reversed, Frame);
					default:
						AnimationDebug.dad.alpha = 1;
						animation.play('idle', Force, Reversed, Frame);
				}
			}
		}
		else if (otherFrames != null && PlayState.dad != null)
		{
			PlayState.dad.visible = false;
			for(i in otherFrames)
				i.visible = false;

			switch(AnimName)
			{
				case 'singLEFT':
					otherFrames[0].visible = true;
					otherFrames[0].playAnim('idle', Force, Reversed, Frame);
				case 'singRIGHT':
					otherFrames[1].visible = true;
					otherFrames[1].playAnim('idle', Force, Reversed, Frame);
				case 'singUP':
					otherFrames[2].visible = true;
					otherFrames[2].playAnim('idle', Force, Reversed, Frame);
				case 'singDOWN':
					otherFrames[3].visible = true;
					otherFrames[3].playAnim('idle', Force, Reversed, Frame);
				default:
					PlayState.dad.visible = true;
					animation.play(AnimName, Force, Reversed, Frame);

					var daOffset = animOffsets.get(AnimName);
					if (animOffsets.exists(AnimName))
						offset.set(daOffset[0], daOffset[1]);
					else
						offset.set(0, 0);
			}
		}
		else
		{
			animation.play(AnimName, Force, Reversed, Frame);

			var daOffset = animOffsets.get(AnimName);
			if (animOffsets.exists(AnimName))
			{
				offset.set(daOffset[0], daOffset[1]);
			}
			else
				offset.set(0, 0);

			if (curCharacter == 'gf')
			{
				if (AnimName == 'singLEFT')
				{
					danced = true;
				}
				else if (AnimName == 'singRIGHT')
				{
					danced = false;
				}

				if (AnimName == 'singUP' || AnimName == 'singDOWN')
				{
					danced = !danced;
				}
			}
		}
	}

	public function addOffset(name:String, x:Float = 0, y:Float = 0)
	{
		animOffsets[name] = [x, y];
	}
}
