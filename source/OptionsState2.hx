package;

import flixel.util.FlxColor;
import flixel.FlxSprite;
//import Checkbox;
import flixel.FlxG;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import 8BitData;

class OptionsState2 extends MusicBeatState
{
	private var grptext:FlxTypedGroup<Alphabet>;

	private var checkboxGroup:FlxTypedGroup<Checkbox>;

	var curSelected:Int = 0;

	var menuItems:Array<String> = [];

	var notice:FlxText;
	var data:8BitData = new 8BitData();
	var safe:Int;
	var fpscap:Int;
	var accuracy:Int;
	var speed:Int;
	var crap:Bool = false;
	var newcap:Int;
	var newacc:Int;
	var newjudge:Int;
	var newspeed:Int;

	override public function create() 
	{
		safe = data.loadInt('frames');
		fpscap = data.loadInt('fpsCap');
		accuracy = data.loadInt('accuracyMod');
		speed = data.loadInt('scrollSpeed');
		newcap = fpsCap;
		newacc = accuracy;
		newjudge = safe;
		newspeed = speed;
		#if (desktop || android)
		menuItems = ['judgement: $safe',
			'fps cap: $fpscap',
			'accuracy: $accuracy',
			'scrollspeed: $speed',
			'customize gameplay'
		]
		#end
		var menuBG:FlxSprite = new FlxSprite().loadGraphic('assets/images/menuDesat.png');
		menuBG.color = 0xFFea71fd;
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

			/*var ch = new Checkbox(controlLabel.x + controlLabel.width + 10, controlLabel.y - 20);
			checkboxGroup.add(ch);
			add(ch);*/

			/*switch (menuItems[i]){
				case 'dfjk':
					ch.change(data.loadBool('dfjk'));
				case 'downscroll':
					ch.change(data.loadBool('downscroll'));
				case 'ghost tap':
					ch.change(data.loadBool('ghost'));
				case 'reset button':
					ch.change(data.loadBool('resetButton'));
			}*/

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

		changeSelection();
	}

	override function update(elapsed:Float)
	{
		data.flushData();
		super.update(elapsed);
		data.flushData();

		var daSelected:String = menuItems[curSelected];
		if (daSelected.startsWith('fpscap')){
		    	if (!crap){
					notice.text = 'Change your FPS Cap.\nChange pages with LEFT or RIGHT';
				}
				if (crap){
					notice.text = 'Value: $newcap LEFT or RIGHT to change value\nACCEPT to exit and save';
				}
		}
		else if (daSelected.startsWith('accuracy')){
				if (!crap){
					notice.text = 'Change how accuracy is calculated. (1 = Simple, 2 = Milisecond Based)\nChange pages with LEFT or RIGHT';
				}
				if (crap){
					notice.text = 'Value: $newacc LEFT or RIGHT to change value\nACCEPT to exit and save';
				}
		}
		else if (daSelected.startsWith('judgement')){
				if (!crap){
					notice.text = 'Customize your Hit Timings. (LEFT or RIGHT)\nChange pages with LEFT or RIGHT';
				}
				if (crap){
					notice.text = 'Value: $newjudge LEFT or RIGHT to change value\nACCEPT to exit and save';
		    	}
		}
		else if (daSelected.startsWith('scrollspeed')){
				if (!crap){
					notice.text = 'Change your scroll speed. (1 = Chart dependent)\nChange pages with LEFT or RIGHT\nChange pages with LEFT or RIGHT';
				}
				if (crap){
				    notice.text = 'Value: $newspeed LEFT or RIGHT to change value\nACCEPT to exit and save';
		    	}
		}
		else if (daSelected.startsWith('customize')){
				if (!crap){
					notice.text = 'Drag and drop gameplay modules to your prefered positions!\nChange pages with LEFT or RIGHT';
		    	}
		}

		if (controls.ACCEPT)
		{

			trace(curSelected);

			if (daSelected.startsWith('fpscap')){
					if (!crap){
					    crap = true;
					}
					if (crap){
					    data.save('fpscap', false, newcap, newcap);
					    crap = false;
					    FlxG.resetState();
					}
			}
			else if (daSelected.startsWith('accuracy')){
					if (!crap){
					    crap = true;
					}
					if (crap){
					    data.save('accuracyMod', false, newacc, newacc);
					    crap = false;
					    FlxG.resetState();
					}
			}
			else if (daSelected.startsWith('judgement')){
					if (!crap){
					    crap = true;
					}
					if (crap){
					    data.save('frames', false, newjudge, newjudge);
					    crap = false;
					    FlxG.resetState();
					}
			}
			else if (daSelected.startsWith('scrollspeed')){
					if (!crap){
					    crap = true;
					}
					if (crap){
					    data.save('scrollSpeed', false, newspeed, newspeed);
					    crap = false;
					    FlxG.resetState();
					}
			}
			else if (daSelected.startsWith('customize')){
					if (!crap){
					    data.flushData();
					    FlxG.switchState(new GameplayCustomizeState());
					}
			}
			data.flushData();
		}

		if (controls.BACK #if android || FlxG.android.justReleased.BACK #end) {
			data.flushData();
			FlxG.switchState(new OptionsMenu());
		}

		if (controls.UP_P && !cool)
			changeSelection(-1);
		if (controls.DOWN_P && !cool)
			changeSelection(1);

		if (controls.RIGHT_P){
			if (!cool){
		    	FlxG.switchState(new OptionsState3());
			}
			if (cool){
			    if (daSelected.startsWith('fpscap')) && newcap > 59 && newcap < 286){
			        newcap += 1;
			    }
			    else if (daSelected.startsWith('accuracy')) && newacc > 0 && newacc < 3){
			        newacc += 1;
			    }
			    else if(daSelected.startsWith('judgement')){
			        newjudge += 1;
			    }
			    else if(daSelected.startsWith('scrollspeed')){
			        newspeed += 1;
			    }
			}
		}
		if (controls.LEFT_P){
			if (!cool){
			    FlxG.switchState(new OptionsState());
			}
			if (cool){
			    if (daSelected.startsWith('fpscap')) && newcap > 59 && newcap < 286){
			        newcap -= 1;
			    }
			    else if (daSelected.startsWith('accuracy')) && newacc > 0 && newacc < 3){
			        newacc -= 1;
			    }
			    else if(daSelected.startsWith('judgement')){
			        newjudge -= 1;
			    }
			    else if(daSelected.startsWith('scrollspeed')){
			        newspeed -= 1;
			    }
			}
		}

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