package;

import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxSpriteGroup;
import flixel.math.FlxMath;
import flixel.util.FlxTimer;
import Paths;

using StringTools;

//fhisjdx

class Achievements extends FlxSprite{
	//vars here
	

	//functions here
	public function new(?ASS:String){
		super();
		//animations
		frames = Paths.getSparrowAtlas('8bit/them','shared');

		scale.set(4,4);
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
		antialiasing = false;
		setPosition(800,FlxG.height * 0.9);
		if (ASS == null){
			trace('ass is null, aftermath of lmao too hard :(');
			animation.play('Sus');
		}
		else{
			animation.play(ASS);
			trace('ASS is there, dont lmao too hard now. that surgery costed a lot');
		}
		
	}
}

class MedalSaves{
	//public var Savecrap:Array<Bool> = [false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false]//20 bools.
	//nvm idfk.
	public static function initMedal()
	{
		if (FlxG.save.data.loaded == null){
			FlxG.save.data.GGWP = false;
			FlxG.save.data.Gamer = false;
			FlxG.save.data.BluSpy = false;
			FlxG.save.data.TOUHOU = false;
			FlxG.save.data.ProPlayer = false;
			FlxG.save.data.ECHO = false;
			FlxG.save.data.GoodEnding = false;
			FlxG.save.data.BadEnding = false;
			FlxG.save.data.Firewall = false;
			FlxG.save.data.Bumbass = false;
			FlxG.save.data.FCFinal = false;
			FlxG.save.data.Spike = false;
			FlxG.save.data.Coin = false;
			FlxG.save.data.FCFour = false;
			FlxG.save.data.NewWorld = false;
			FlxG.save.data.FCThree = false;
			FlxG.save.data.Sus = false;
			FlxG.save.data.BigSus = false;
			FlxG.save.data.Perfect = false;
			FlxG.save.data.loaded = true;
		}
		if (FlxG.save.data.NewWorld)
			FlxG.save.data.NewWorld = false;
	}
}