package;

import flixel.FlxG;
import flixel.FlxSprite;

class NoteSplash extends FlxSprite
{
	public function new(xPos:Float, yPos:Float, ?note:Int)
	{
		if (note == null)
			note = 0;
		super(xPos, yPos);
		frames = Paths.getSparrowAtlas('pop', 'shared');
		animation.addByIndices("note1-0", "down pop note", [0,1,2,3], "", 24, false);
		animation.addByIndices("note2-0", "up pop note", [0,1,2,3], "", 24, false);
		animation.addByIndices("note0-0", "left pop note", [0,1,2,3], "", 24, false);
		animation.addByIndices("note3-0", "right pop note", [0,1,2,3], "", 24, false);

		animation.addByIndices("note1-1", "down pop note", [4,5,6,7], "", 24, false);
		animation.addByIndices("note2-1", "up pop note", [4,5,6,7], "", 24, false);
		animation.addByIndices("note0-1", "left pop note", [4,5,6,7], "", 24, false);
		animation.addByIndices("note3-1", "right pop note", [4,5,6,7], "", 24, false);
		setupNoteSplash(xPos, xPos, note);
	}

	public function setupNoteSplash(xPos:Float, yPos:Float, ?note:Int)
	{
		if (note == null)
			note = 0;
		setPosition(xPos, yPos);
		alpha = 0.7;
		animation.play("note" + note + "-" + FlxG.random.int(0, 1), true);
		animation.curAnim.frameRate = 24 + FlxG.random.int(-2, 2);
		updateHitbox();
		offset.set(0.3 * width, 0.3 * height);
	}

	override public function update(elapsed)
	{
		if (animation.curAnim.finished)
			kill();
		super.update(elapsed);
	}
}
