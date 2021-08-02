package;

import flixel.util.FlxColor;
import flixel.FlxSprite;
import Checkbox;
import flixel.FlxG;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import BitData;

class OptionsState4 extends MusicBeatState
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
		menuItems = ['fps counter',
			'flash',
			'watermark',
			'antialiasing',
			'miss sounds',
			'score screen',
			'show input',
			'optimization',
			#if desktop
			'caching',
			#end
			'botplay'
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
				case 'fps counter':
					ch.change(FlxG.save.data.fps);
				case 'watermark':
					ch.change(FlxG.save.data.watermarks);
				case 'flash':
					ch.change(FlxG.save.data.flashing);
				case 'antialiasing':
					ch.change(FlxG.save.data.antialiasing);
				case 'miss sounds':
					ch.change(FlxG.save.data.missSounds);
				case 'score screen':
					ch.change(FlxG.save.data.scoreScreen);
				case 'show input':
					ch.change(FlxG.save.data.inputShow);
				case 'optimization':
					ch.change(FlxG.save.data.optimize);
				case 'caching':
					ch.change(FlxG.save.data.cacheImages);
				case 'botplay':
					ch.change(FlxG.save.data.botplay);
			}

			// DONT PUT X IN THE FIRST PARAMETER OF new ALPHABET() !!
		}

		var noticebg = new FlxSprite(0, FlxG.height - 56).makeGraphic(FlxG.width, 60, FlxColor.BLACK);
		noticebg.alpha = 0.25;


		notice = new FlxText(0, 0, 0, "", 24);

		//notice.x = (FlxG.width / 2) - (notice.width / 2);
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
			case 'fps counter':
				notice.text = 'Toggle the FPS Counter.\nSwitch pages using LEFT or RIGHT\n';
			case 'flash':
				notice.text = 'Toggle flashing lights that can cause epileptic seizures and strain.\nSwitch pages using RIGHT\n';
			case'watermark':
				notice.text = 'Enable and disable all watermarks from the engine.\nSwitch pages using LEFT or RIGHT\n';
			case 'antialiasing':
				notice.text = 'Toggle antialiasing, improving graphics quality at a slight performance penalty.\nSwitch pages using LEFT or RIGHT\n';
			case 'miss sounds':
				notice.text = "Toggle miss sounds playing when you don't hit a note.\nSwitch pages using LEFT or RIGHT\n";
			case 'score screen':
				notice.text = "Show the score screen after the end of a song.\nSwitch pages using LEFT or RIGHT\n";
			case 'show input':
				notice.text = "Display every single input on the score screen.\nSwitch pages using LEFT or RIGHT\n";
			case 'optimization':
				notice.text = "No characters or backgrounds. Just a usual rhythm game layout.\nSwitch pages using LEFT or RIGHT\n";
			case 'caching':
				notice.text = "On startup, cache every character. Significantly decrease load times. (HIGH MEMORY)\nSwitch pages using LEFT or RIGHT\n";
			case 'botplay':
				notice.text = "Showcase your charts and mods with autoplay.\nSwitch pages using LEFT or RIGHT\n";
		}

		if (controls.ACCEPT)
		{

			trace(curSelected);

			switch (daSelected)
			{
				case 'fps counter':
					FlxG.save.data.fps = checkboxGroup.members[curSelected].change();
				case 'flash':
					FlxG.save.data.flashing = checkboxGroup.members[curSelected].change();
				case 'watermark':
					FlxG.save.data.watermarks = checkboxGroup.members[curSelected].change();
				case 'antialiasing':
					FlxG.save.data.antialiasing = checkboxGroup.members[curSelected].change();
				case 'miss sounds':
					FlxG.save.data.missSounds = checkboxGroup.members[curSelected].change();
				case 'score screen':
					FlxG.save.data.scoreScreen = checkboxGroup.members[curSelected].change();
				case 'show input':
					FlxG.save.data.inputShow = checkboxGroup.members[curSelected].change();
				case 'optimization':
					FlxG.save.data.optimize = checkboxGroup.members[curSelected].change();
				case 'caching':
					FlxG.save.data.cacheImages = checkboxGroup.members[curSelected].change();
				case 'botplay':
					FlxG.save.data.botplay = checkboxGroup.members[curSelected].change();
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
			FlxG.switchState(new OptionsState());
		}
		if (controls.LEFT_P)
			FlxG.switchState(new OptionsState3());

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