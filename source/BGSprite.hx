package;

import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;

class BGSprite extends FlxSprite
{
	private var idleAnim:String;
	public function new(image:String, lib:String, x:Float = 0, y:Float = 0, ?scrollX:Float = 1, ?scrollY:Float = 1, ?animArray:Array<String> = null,?fps:Int = 24, ?loop:Bool = false) {
		super(x, y);

        trace('creating ' + image);

		if (animArray != null) {
			frames = Paths.getSparrowAtlas(image,lib);
			for (i in 0...animArray.length) {
				var anim:String = animArray[i];
				trace('adding anim ' + anim);
				animation.addByPrefix(anim, anim, fps, loop);
				if(idleAnim == null) {
					this.idleAnim = anim;
					animation.play(anim);
					trace('set idle to ' + idleAnim);
				}
				trace('added');
			}
		} else {
			loadGraphic(Paths.image(image,lib));
			active = false;
		}
		scrollFactor.set(scrollX, scrollY);
		antialiasing = true;
        trace('done');
	}

	public function dance() {
		if(idleAnim != null) {
			this.animation.play(idleAnim);
		}
	}
}