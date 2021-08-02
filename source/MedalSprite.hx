package;

import flixel.FlxSprite;

class MedalSprite extends FlxSprite
{
	public var unlock:Bool;

	public function new(?x, ?y, ?ass:String = "Sus") {
		super(x, y);

		var tex = Paths.getSparrowAtlas('8bit/them', 'shared');
		frames = tex;

		animation.addByPrefix('GGWP','GGWP',24,false);
		animation.addByPrefix('Gamer','GAMER',24,false);
		animation.addByPrefix('Blue Spy','BLUSPY',24,false);
		animation.addByPrefix('TOUHOU Bit','touhou bit',24,false);
		animation.addByPrefix('Pro Player','pro player',24,false);
		animation.addByPrefix('ECHO','ECHO',24,false);
		animation.addByPrefix('Good Ending','good ending',24,false);
		animation.addByPrefix('Bad Ending','bad ending',24,false);
		animation.addByPrefix('Firewall','firewall',24,false);
		animation.addByPrefix('Bumbass','DUNABD',24,false);
		animation.addByPrefix('FC Final','CDBZ',24,false);
		animation.addByPrefix('Spike','spike',24,false);//spike :)
		animation.addByPrefix('One Coin','Only one coin',24,false);
		animation.addByPrefix('FC Four','TWTMF',24,false);
		animation.addByPrefix('New World','new world',24,false);
		animation.addByPrefix('FC Three','wild west',24,false);
		animation.addByPrefix('Sus','sus',24,false);
		animation.addByPrefix('Big Sus','BIG SUS',24,false);
		animation.addByPrefix('Perfect','The perfect player',24,false);

		animation.play(ass);

		setGraphicSize(Std.int(width * 6));
		antialiasing = false;
		alpha = 0;
		updateHitbox();
		checkShit();
	}
	public function changeShit(?man:Bool) {
		if (man != null)
			unlock = man;
		else
			unlock = !unlock;
		trace(unlock);
		if (unlock)
			alpha = 1;
		else
			alpha = 0.6;

		return unlock;
	}

	public function checkShit(){
		switch (unlock){
			case false | null:
				alpha = 0.6;
			case true:
				alpha = 1;
		}
	}
}