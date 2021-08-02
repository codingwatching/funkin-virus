package;

import flixel.util.FlxColor;
import flixel.FlxSprite;
import Checkbox;
import flixel.FlxG;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import BitData;

class OptionsState3 extends MusicBeatState
{
	private var grptext:FlxTypedGroup<Alphabet>;

	private var checkboxGroup:FlxTypedGroup<Checkbox>;

	var curSelected:Int = 0;

	var menuItems:Array<String> = [];

	var notice:FlxText;
	//var data:BitData = new BitData();

	override public function create() 
	{
		#if (android || ios || desktop)
		menuItems = ['distractions',
			'camzoom',
			'stepmania',
			'accuracy',
			'song posistion',
			'nps display',
			'rainbow fps',
			'cpustrums'
		];
		#end
		var menuBG:FlxSprite = new FlxSprite().loadGraphic('assets/images/menuDesat.png');
		menuBG.color = FlxColor.fromRGB(82, 79, 78);
		menuBG.setGraphicSize(Std.int(menuBG.width * 1.1));
		menuBG.updateHitbox();
		menuBG.screenCenter();
		menuBG.antialiasing = true;
		add(menuBG);

		grptext = new FlxTypedGroup<Alphabet>();
		add(grptext);

		checkboxGroup = new FlxTypedGroup<Checkbox>();
		add(checkboxGroup);

		for (i in 0...menuItems.length)
		{ 
			var controlLabel:Alphabet = new Alphabet(0, (70 * i) + 30, menuItems[i], true, false);
			controlLabel.isMenuItem = true;
			controlLabel.targetY = i;
			grptext.add(controlLabel);

			var ch = new Checkbox(controlLabel.x + controlLabel.width + 10, controlLabel.y - 20);
			checkboxGroup.add(ch);
			add(ch);

			switch (menuItems[i]){
				case 'distractions':
					ch.change(FlxG.save.data.distractions);
				case 'camzoom':
					ch.change(FlxG.save.data.camzoom);
				case 'accuracy':
					ch.change(FlxG.save.data.accuracyDisplay);
				case 'song posistion':
					ch.change(FlxG.save.data.songPosistion);
				case 'nps display':
					ch.change(FlxG.save.data.npsDisplay);
				case 'rainbow fps':
					ch.change(FlxG.save.data.fpsRain);
				case 'cpustrums':
					ch.change(FlxG.save.data.cpuStrums);
				case 'stepmania':
					ch.change(FlxG.save.data.stepMania);
			}

			// DONT PUT X IN THE FIRST PARAMETER OF new ALPHABET() !!
		}

		var noticebg = new FlxSprite(0, FlxG.height - 56).makeGraphic(FlxG.width, 60, FlxColor.BLACK);
		noticebg.alpha = 0.25;

		notice = new FlxText(0, 0, 0, "", 24);

		notice.screenCenter();
		notice.y = FlxG.height - 56;
		notice.alpha = 0.6;
		add(noticebg);
		add(notice);
		#if (android || ios)
		addVirtualPad(FULL, A_B);
		#end
		changeSelection();
	}

	override function update(elapsed:Float)
	{

		if (FlxG.save.data.lessUpdate)
			super.update(elapsed/2);
		else
			super.update(elapsed);

		for (i in 0...checkboxGroup.length)
		{
			checkboxGroup.members[i].x = grptext.members[i].x + grptext.members[i].width + 10;
			checkboxGroup.members[i].y = grptext.members[i].y - 20;
		} 
		var daSelected:String = menuItems[curSelected];

		switch (daSelected){
			case 'distractions':
				notice.text = 'Toggle stage distractions that can hinder your gameplay.\nSwitch pages using LEFT or RIGHT\n';
			case 'camzoom':
				notice.text = 'Toggle making the notes scroll down rather than up.\nSwitch pages using RIGHT\n';
			case 'accuracy':
				notice.text = 'Toggle the camera zoom in-game.\nSwitch pages using LEFT or RIGHT\n';
			case 'song posistion':
				notice.text = "Show the song's current position as a scrolling bar.\nSwitch pages using LEFT or RIGHT\n";
			case 'stepmania':
				notice.text = 'Sets the colors of the arrows depending on quantization instead of direction.\nSwitch pages using LEFT or RIGHT\n';
			case 'nps display':
				notice.text = 'Shows your current Notes Per Second on the info bar.\nSwitch pages using LEFT or RIGHT\n';
			case 'rainbow fps':
				notice.text = 'Make the FPS Counter flicker through rainbow colors.\nSwitch pages using LEFT or RIGHT\n';
			case 'cpustrums':
				notice.text = "Toggle the CPU's strumline lighting up when it hits a note.\nSwitch pages using LEFT or RIGHT\n";
		}

		if (controls.ACCEPT)
		{

			trace(curSelected);

			switch (daSelected)
			{
				case 'distractions':
					FlxG.save.data.distractions = checkboxGroup.members[curSelected].change();
				case 'camzoom':
					FlxG.save.data.camzoom = checkboxGroup.members[curSelected].change();
				case 'accuracy':
					FlxG.save.data.accuracyDisplay = checkboxGroup.members[curSelected].change();
				case 'song position':
					FlxG.save.data.songPosistion = checkboxGroup.members[curSelected].change();
				case 'stepmania':
					FlxG.save.data.stepMania = checkboxGroup.members[curSelected].change();
				case 'nps display':
					FlxG.save.data.npsDisplay = checkboxGroup.members[curSelected].change();
				case 'rainbow fps':
					FlxG.save.data.fpsRain = checkboxGroup.members[curSelected].change();
				case 'cpustrums':
					FlxG.save.data.cpuStrums = checkboxGroup.members[curSelected].change();
			}
			FlxG.save.flush();
		}

		if (controls.BACK #if android || FlxG.android.justReleased.BACK #end) {
			FlxG.save.flush();
			FlxG.switchState(new OptionsMenu());
		}

		if (controls.UP_P)
			changeSelection(-1);
		if (controls.DOWN_P)
			changeSelection(1);

		if (controls.RIGHT_P){
			FlxG.switchState(new OptionsState4());
		}
		if (controls.LEFT_P)
			FlxG.switchState(new OptionsState());

	}

	function changeSelection(change:Int = 0)
	{
		FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);

		curSelected += change;

		if (curSelected < 0)
			curSelected = grptext.length - 1;
		if (curSelected >= grptext.length)
			curSelected = 0;

		var bullShit:Int = 0;

		for (item in grptext.members)
		{
			item.targetY = bullShit - curSelected;
			bullShit++;

			item.alpha = 0.6;
			// item.setGraphicSize(Std.int(item.width * 0.8));

			if (item.targetY == 0)
			{
				item.alpha = 1;
				// item.setGraphicSize(Std.int(item.width));
			}
		}
	}

	// code from here https://stackoverflow.com/questions/23689001/how-to-reliably-format-a-floating-point-number-to-a-specified-number-of-decimal
	public static function floatToStringPrecision(n:Float, prec:Int){
		n = Math.round(n * Math.pow(10, prec));
		var str = ''+n;
		var len = str.length;
		if(len <= prec){
		  while(len < prec){
			str = '0'+str;
			len++;
		  }
		  return Std.parseFloat('0.'+str);
		}
		else{
		  return Std.parseFloat(str.substr(0, str.length-prec) + '.'+str.substr(str.length-prec));
		}//what.
	  }
}