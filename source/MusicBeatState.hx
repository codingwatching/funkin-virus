package;

#if windows
import Discord.DiscordClient;
#end
import flixel.util.FlxColor;
import openfl.Lib;
import Conductor.BPMChangeEvent;
import flixel.FlxG;
import flixel.addons.ui.FlxUIState;
import flixel.input.actions.FlxActionInput;
import ui.FlxVirtualPad;
import Achievements;
import flixel.*;
import flixel.tweens.FlxTween;
import flixel.util.*;
import flixel.text.FlxText;

class MusicBeatState extends FlxUIState
{
	private var lastBeat:Float = 0;
	private var lastStep:Float = 0;

	private var curStep:Int = 0;
	private var curBeat:Int = 0;
	private var curDecimalBeat:Float = 0;
	private var controls(get, never):Controls;

	public var cameraStuff:FlxCamera;
	public var fpressed:Int = 0;
	public var dontSpam:Bool = false;

	inline function get_controls():Controls
		return PlayerSettings.player1.controls;
	#if (android || ios)
	var _virtualpad:FlxVirtualPad;

	var trackedinputs:Array<FlxActionInput> = [];

	// adding virtualpad to state
	public function addVirtualPad(?DPad:FlxDPadMode, ?Action:FlxActionMode) {
		_virtualpad = new FlxVirtualPad(DPad, Action);
		_virtualpad.alpha = 0.75;
		add(_virtualpad);
		controls.setVirtualPad(_virtualpad, DPad, Action);
		trackedinputs = controls.trackedinputs;
		controls.trackedinputs = [];

		#if android
		controls.addAndroidBack();
		#end
	}
	
	override function destroy() {
		controls.removeFlxInput(trackedinputs);

		super.destroy();
	}
	#else
	public function addVirtualPad(?DPad, ?Action){};
	#end

	override function create()
	{
		cameraStuff = new FlxCamera();
		cameraStuff.bgColor.alpha = 0;
		FlxG.cameras.add(cameraStuff);
		TimingStruct.clearTimings();
		(cast (Lib.current.getChildAt(0), Main)).setFPSCap(FlxG.save.data.fpsCap);

		if (transIn != null)
			trace('reg ' + transIn.region);

		super.create();
	}


	var array:Array<FlxColor> = [
		FlxColor.fromRGB(148, 0, 211),
		FlxColor.fromRGB(75, 0, 130),
		FlxColor.fromRGB(0, 0, 255),
		FlxColor.fromRGB(0, 255, 0),
		FlxColor.fromRGB(255, 255, 0),
		FlxColor.fromRGB(255, 127, 0),
		FlxColor.fromRGB(255, 0 , 0)
	];

	var skippedFrames = 0;

	override function update(elapsed:Float)
	{
		//everyStep();
		var nextStep:Int = updateCurStep();

		if (nextStep >= 0)
		{
			if (nextStep > curStep)
			{
				for (i in curStep...nextStep)
				{
					curStep++;
					updateBeat();
					stepHit();
				}
			}
			else if (nextStep < curStep)
			{
				//Song reset?
				curStep = nextStep;
				updateBeat();
				stepHit();
			}
		}

		if (Conductor.songPosition < 0)
			curDecimalBeat = 0;
		else
		{
			if (TimingStruct.AllTimings.length > 1)
			{
				var data = TimingStruct.getTimingAtTimestamp(Conductor.songPosition);

				FlxG.watch.addQuick("Current Conductor Timing Seg", data.bpm);

				Conductor.crochet = ((60 / data.bpm) * 1000);

				var percent = (Conductor.songPosition - (data.startTime * 1000)) / (data.length * 1000);

				curDecimalBeat = data.startBeat + (((Conductor.songPosition/1000) - data.startTime) * (data.bpm / 60));
			}
			else
			{
				curDecimalBeat = (Conductor.songPosition / 1000) * (Conductor.bpm/60);
				Conductor.crochet = ((60 / Conductor.bpm) * 1000);
			}
		}

		if (FlxG.save.data.fpsRain && skippedFrames >= 6)
			{
				if (currentColor >= array.length)
					currentColor = 0;
				(cast (Lib.current.getChildAt(0), Main)).changeFPSColor(array[currentColor]);
				currentColor++;
				skippedFrames = 0;
			}
			else
				skippedFrames++;

		if ((cast (Lib.current.getChildAt(0), Main)).getFPSCap != FlxG.save.data.fpsCap && FlxG.save.data.fpsCap <= 290)
			(cast (Lib.current.getChildAt(0), Main)).setFPSCap(FlxG.save.data.fpsCap);

		if (FlxG.save.data.lessUpdate)
			super.update(elapsed/2);
		else
			super.update(elapsed);

//shit for Achievements
		if (FlxG.keys.justPressed.F && !dontSpam)
			fpressed += 1;

		switch (fpressed){
			case 69:
				fpressed == 70;
				medalPop('Sus');
			case 420:
				fpressed == 421;
				medalPop('Big Sus');
		}

	}

	private function updateBeat():Void
	{
		lastBeat = curBeat;
		curBeat = Math.floor(curStep / 4);
	}

	public static var currentColor = 0;

	private function updateCurStep():Int
	{
		var lastChange:BPMChangeEvent = {
			stepTime: 0,
			songTime: 0,
			bpm: 0
		}
		for (i in 0...Conductor.bpmChangeMap.length)
		{
			if (Conductor.songPosition >= Conductor.bpmChangeMap[i].songTime)
				lastChange = Conductor.bpmChangeMap[i];
		}

		return lastChange.stepTime + Math.floor((Conductor.songPosition - lastChange.songTime) / Conductor.stepCrochet);
	}

	public function stepHit():Void
	{
		if (curStep % 4 == 0)
			beatHit();
	}

	public function beatHit():Void
	{
		//do literally nothing dumbass
	}
	
	public function fancyOpenURL(schmancy:String)
	{
		#if linux
		Sys.command('/usr/bin/xdg-open', [schmancy, "&"]);
		#else
		FlxG.openURL(schmancy);
		#end
	}

	public function medalPop(ass:String){
		dontSpam = true;
		var medal:Achievements = new Achievements(ass);
		var medalBg:FlxSprite = new FlxSprite(800, FlxG.height * 0.9).loadGraphic(Paths.image('UNLOCK', 'shared'));
		medalBg.scale.set(5,5);
		medalBg.antialiasing = false;
		medalBg.y += 200;
		medal.y += 200;
		medal.cameras = [cameraStuff];
		medalBg.cameras = [cameraStuff];
		add(medalBg);
		add(medal);
		FlxTween.linearMotion(medal, 800, FlxG.height * 0.9 + 200, 800, FlxG.height * 0.9, 2, true);
		FlxTween.linearMotion(medalBg, 800, FlxG.height * 0.9 + 200, 800, FlxG.height * 0.9, 2, true);
		textPop(ass);
		new FlxTimer().start(4, function(tmr:FlxTimer){
			FlxTween.linearMotion(medal, 800, FlxG.height * 0.9, 800, FlxG.height * 0.9 + 200, 2, true);
			FlxTween.linearMotion(medalBg, 800, FlxG.height * 0.9, 800, FlxG.height * 0.9 + 200, 2, true);
			new FlxTimer().start(2, function(tmr:FlxTimer){
				remove(medal);
				remove(medalBg);
				dontSpam = false;
			});
		});
	}
	public function textPop(ass:String){
		var txt:FlxText = new FlxText(0, 0, 0, "", 24);
		txt.screenCenter();
		txt.y = FlxG.height - 56;
		txt.alpha = 0;
		switch (ass){
			case 'Sus':
				txt.text = "SUS!\nPress F 69 times.\n";
				FlxG.save.data.Sus = true;
			default:
				txt.text = "how\n";
		}
		new FlxTimer().start(0.1, function(tmr:FlxTimer){
			txt.alpha += 0.1;
			if (txt.alpha < 0.9)
				tmr.reset(0.1);
		});
		new FlxTimer().start(6, function(tmr:FlxTimer){
			remove(txt);
		});
	}
}
//im not a good flxtext dude. :(