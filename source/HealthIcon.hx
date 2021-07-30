package;

import flixel.FlxG;
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

		if(FlxG.save.data.antialiasing)
			{
				antialiasing = true;
			}
		if (char == 'sm')
		{
			loadGraphic(Paths.image("stepmania-icon"));
			return;
		}
		loadGraphic(Paths.image('iconGrid'), true, 150, 150);
		animation.add('bf', [0, 1], 0, false, false);
		animation.add('bf-car', [0, 1], 0, false);
		animation.add('bf-christmas', [0, 1], 0, false);
		animation.add('bf-pixel', [0, 1], 0, false, false);
		animation.add('virus', [2, 3], 0, false, isPlayer);
		animation.add('bit', [4, 5], 0, false, isPlayer);
		animation.add('retro', [6, 7], 0, false, isPlayer);
		animation.add('classic', [8, 9], 0, false, isPlayer);
		animation.add('virus-mad', [10, 11], 0, false, isPlayer);
		animation.add('dark', [12, 13], 0, false, isPlayer);
		animation.add('blue', [14, 15], 0, false, isPlayer);
		animation.add('bf-pixel-lose', [1, 1], 0, false, false);
		animation.add('virus-lose', [3, 3], 0, false, isPlayer);
		animation.add('bit-lose', [5, 5], 0, false, isPlayer);
		animation.add('retro-lose', [7, 7], 0, false, isPlayer);
		animation.add('classic-lose', [9, 9], 0, false, isPlayer);
		animation.add('virus-mad-lose', [11, 11], 0, false, isPlayer);
		animation.add('dark-lose', [13, 13], 0, false, isPlayer);
		animation.add('blue-lose', [15, 15], 0, false, isPlayer);
		animation.add('virus-win', [20, 20], 0, false, isPlayer);
		animation.add('dark-win', [21, 21], 0, false, isPlayer);
		animation.add('bf-pixel-win', [22, 22], 0, false, false);
		animation.add('bit-win', [30, 30], 0, false, isPlayer);
		animation.add('classic-win', [31, 31], 0, false, isPlayer);
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
