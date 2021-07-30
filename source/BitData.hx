package;

import flixel.FlxG;
import flixel.util.FlxSave;
import flixel.input.gamepad.FlxGamepad;
import openfl.Lib;

class BitData{
	var bitdata:FlxSave = new FlxSave();
	var desktop:Bool = false;
	var mobile:Bool = false;
	public function new(){
		//bitdata = new FlxSave();
		bitdata.bind("save-data");
	}
	public function startData(){
		#if desktop
		desktop = true;
		#end
		#if android
		mobile = true;
		#end
		if (bitdata.data.weekUnlocked == null){
			bitdata.data.weekUnlocked = 7;
		}
		if (bitdata.data.newInput == null){
			bitdata.data.newInput = true;
		}

		if (bitdata.data.downscroll == null){
			bitdata.data.downscroll = false;
		}

		if (bitdata.data.antialiasing == null){
			bitdata.data.antialiasing = true;
		}

		if (bitdata.data.missSounds == null){
			bitdata.data.missSounds = true;
		}

		if (bitdata.data.dfjk == null){
			bitdata.data.dfjk = false;
		}
		if (bitdata.data.accuracyDisplay == null){
			bitdata.data.accuracyDisplay = true;
		}

		if (bitdata.data.offset == null){
			bitdata.data.offset = 0;
		}

		if (bitdata.data.songPosition == null){
			bitdata.data.songPosition = false;
		}

		if (bitdata.data.fps == null){
			bitdata.data.fps = false;
		}

		if (bitdata.data.changedHit == null)
		{
			bitdata.data.changedHitX = -1;
			bitdata.data.changedHitY = -1;
			bitdata.data.changedHit = false;
		}

		if (bitdata.data.fpsRain == null){
			bitdata.data.fpsRain = false;
		}

		if (bitdata.data.fpsCap == null){
		    if (desktop){
		    	bitdata.data.fpsCap = 120;
		    }
		    if (mobile){
		        bitdata.data.fpsCap = 90;
		    }
		}

		if (bitdata.data.fpsCap > 285 || bitdata.data.fpsCap < 60 && desktop){
			bitdata.data.fpsCap = 120; // baby proof so you can't hard lock ur copy of kade engine
		}
		if (bitdata.data.fpsCap > 90 || bitdata.data.fpsCap < 60 && mobile){
			bitdata.data.fpsCap = 60; // baby proof so you can't hard lock ur copy of kade engine
		}
		
		if (bitdata.data.scrollSpeed == null || bitdata.data.scrollSpeed == 0){
			bitdata.data.scrollSpeed = 1;
		}

		if (bitdata.data.npsDisplay == null){
			bitdata.data.npsDisplay = false;
		}

		if (bitdata.data.frames == null){
			bitdata.data.frames = 10;
		}

		if (bitdata.data.accuracyMod == null){
			bitdata.data.accuracyMod = 1;
		}

		if (bitdata.data.watermark == null){
			bitdata.data.watermark = true;
		}

		if (bitdata.data.ghost == null){
			bitdata.data.ghost = true;
		}

		if (bitdata.data.distractions == null){
			bitdata.data.distractions = true;
		}
		
		if (bitdata.data.stepMania == null){
			bitdata.data.stepMania = false;
		}

		if (bitdata.data.flashing == null){
			bitdata.data.flashing = true;
		}

		if (bitdata.data.resetButton == null && desktop){
			bitdata.data.resetButton = false;
		}
		
		if (bitdata.data.botplay == null){
			bitdata.data.botplay = false;
		}

		if (bitdata.data.cpuStrums == null){
			bitdata.data.cpuStrums = false;
		}

		if (bitdata.data.strumline == null){
			bitdata.data.strumline = false;
		}
		
		if (bitdata.data.customStrumLine == null){
			bitdata.data.customStrumLine = 0;
		}

		if (bitdata.data.camzoom == null){
			bitdata.data.camzoom = true;
		}

		if (bitdata.data.scoreScreen == null){
			bitdata.data.scoreScreen = true;
		}

		if (bitdata.data.inputShow == null){
			bitdata.data.inputShow = false;
		}

		if (bitdata.data.optimize == null){
			bitdata.data.optimize = false;
		}
		
		if (bitdata.data.cacheImages == null && desktop){
			bitdata.data.cacheImages = false;
		}

		var gamepad:FlxGamepad = FlxG.gamepads.lastActive;
		
		KeyBinds.gamepad = gamepad != null;

		Conductor.recalculateTimings();
		PlayerSettings.player1.controls.loadKeyBinds();
		KeyBinds.keyCheck();

		Main.watermarks = bitdata.data.watermark;

		(cast (Lib.current.getChildAt(0), Main)).setFPSCap(bitdata.data.fpsCap);
		bitdata.flush();
	}
	public function flushData(){
		bitdata.flush();
	}
	public function save(name:String, ?data:Bool = false, ?data2:Int = 0, ?data3:Int = 0){
		switch (name){
			case 'week':
				bitdata.data.weekUnlocked = data2;
			case 'input':
				bitdata.data.newInput = data;
			case 'downscroll':
				bitdata.data.downscroll = data;
			case 'antialiasing':
				bitdata.data.antialiasing = data;
			case 'missSounds':
				bitdata.data.missSounds = data;
			case 'dfjk':
				bitdata.data.dfjk = data;
			case 'accuracyDisplay':
				bitdata.data.accuracyDisplay = data;
			case 'offset':
				bitdata.data.offset = data2;
			case 'songPosition':
				bitdata.data.songPosition = data;
			case 'fps':
				bitdata.data.fps = data;
			case 'changedHit':
				bitdata.data.changedHit = data;
				bitdata.data.changedHitY = data2;
				bitdata.data.changedHitX = data3;
			case 'fpsRain':
				bitdata.data.fpsRain = data;
			case 'fpsCap':
				bitdata.data.fpsCap = data2;
			case 'scrollSpeed':
				if (data2 != 0){
			    	bitdata.data.scrollSpeed = data2;
				}
			case 'npsDisplay':
				bitdata.data.npsDisplay = data;
			case 'frames':
				bitdata.data.frames = data2;
			case 'accuracyMod':
				bitdata.data.accuracyMod = data2;
			case 'watermark':
				bitdata.data.watermark = data;
			case 'ghost':
				bitdata.data.ghost = data;
			case 'distractions':
				bitdata.data.distractions = data;
			case 'stepMania':
				bitdata.data.stepMania = data;
			case 'flashing':
				bitdata.data.flashing = data;
			case 'resetButton':
				bitdata.data.resetButton = data;
			case 'botplay':
				bitdata.data.botplay = data;
			case 'cpuStrums':
				bitdata.data.cpuStrums = data;
			case 'customStrumLine':
				bitdata.data.customStrumLine = data2;
			case 'strumline':
				bitdata.data.strumline = data;
			case 'camzoom':
				bitdata.data.camzoom = data;
			case 'scoreScreen':
				bitdata.data.scoreScreen = data;
			case 'inputShow':
				bitdata.data.inputShow = data;
			case 'optimize':
				bitdata.data.optimize = data;
			default:
				trace('invalid crap dumbass');
		}
		bitdata.flush();
	}
	public function loadBool(name:String):Bool{
		var crep:Bool;
		switch (name){
			//case 'week':
				//return bitdata.data.weekUnlocked;
			case 'input':
				crep = bitdata.data.newInput;
			case 'downscroll':
				crep = bitdata.data.downscroll;
			case 'antialiasing':
				crep = bitdata.data.antialiasing;
			case 'missSounds':
				crep = bitdata.data.missSounds;
			case 'dfjk':
				crep = bitdata.data.dfjk;
			case 'accuracyDisplay':
				crep = bitdata.data.accuracyDisplay;
			//case 'offset':
				//bitdata.data.offset;
			case 'songPosition':
				crep = bitdata.data.songPosition;
			case 'fps':
				crep = bitdata.data.fps;
			case 'changedHit':
				crep = bitdata.data.changedHit;
			case 'fpsRain':
				crep = bitdata.data.fpsRain;
			//case 'fpsCap':
				//bitdata.data.fpsCap;
			//case 'scrollSpeed':
				//if (data2 != 0){
			    	//bitdata.data.scrollSpeed;
				//}
			case 'npsDisplay':
				crep = bitdata.data.npsDisplay;
			//case 'frames':
				//bitdata.data.frames;
			//case 'accuracyMod':
				//bitdata.data.accuracyMod2;
			case 'watermark':
				crep = bitdata.data.watermark;
			case 'ghost':
				crep = bitdata.data.ghost;
			case 'distractions':
				crep = bitdata.data.distractions;
			case 'stepMania':
				crep = bitdata.data.stepMania;
			case 'flashing':
				crep = bitdata.data.flashing;
			case 'resetButton':
				crep = bitdata.data.resetButton;
			case 'botplay':
				crep = bitdata.data.botplay;
			case 'cpuStrums':
				crep = bitdata.data.cpuStrums;
			//case 'customStrumLine':
				//bitdata.data.customStrumLine;
			case 'strumline':
				crep = bitdata.data.strumline;
			case 'camzoom':
				crep = bitdata.data.camzoom;
			case 'scoreScreen':
				crep = bitdata.data.scoreScreen;
			case 'inputShow':
				crep = bitdata.data.inputShow;
			case 'optimize':
				crep = bitdata.data.optimize;
			default:
				trace('invalid bool dumbass');
				crep = false;
		}
		return crep;
		bitdata.flush();
	}
	public function loadInt(name:String):Int{
		var crep:Int;
		switch (name){
			case 'offset':
				crep = bitdata.data.offset;
			//case 'changedHit':
				//crep = bitdata.data.changedHit;
			case 'changedHitY':
				crep = bitdata.data.changedHitY;
			case 'changedHitX':
				crep = bitdata.data.changedHitX;
			case 'fpsCap':
				crep = bitdata.data.fpsCap;
			case 'scrollSpeed':
				crep = bitdata.data.scrollSpeed;
			case 'frames':
				crep = bitdata.data.frames;
			case 'accuracyMod':
				crep = bitdata.data.accuracyMod2;
			case 'customStrumLine':
				crep = bitdata.data.customStrumLine;
			default:
				trace('invalid bool dumbass');
				crep = 1;
		}
		return crep;
		bitdata.flush();
	}
}
