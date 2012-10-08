package
{
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	import org.flixel.FlxU;
	
	public class WinState extends FlxState
	{
		[Embed(source="../data/bg.png")] public var bg:Class;
		
		[Embed(source="../data/victory.mp3")] public var victory:Class;
		
		public var player:Player;
		
		override public function create():void
		{
			FlxG.play( victory );
			
			
			///FFFFUUUUUUUUUCCCCCKKK copying and pasting code, whatevs
			var survivalCountDownTxt:FlxText = new FlxText( 0, 0, 790, "" );
			survivalCountDownTxt.size = 24;
			survivalCountDownTxt.x = FlxG.stage.stageWidth / 2 - 225;
			survivalCountDownTxt.y = FlxG.stage.stageHeight / 2 - 270;
			survivalCountDownTxt.text = "You survived for " + PlayState.survivalCountDownAmount.toString() + " seconds!";
			add( survivalCountDownTxt );
			
			add( new FlxSprite( 0, 0, bg ) );
			
			var colorName:String = "";
			
			
			if( PlayState.winningColor != FlxU.makeColor( 0, 0, 255 ) )
			{
				colorName = "BLUE";
			}
			else
			{
				colorName = "RED";
			}
			
			var winnerText:FlxText = new FlxText( 0, 0, 600, colorName + " HAS WON!!!" );
			winnerText.size = 30;
			winnerText.x = FlxG.stage.stageWidth / 2 - 150;
			winnerText.y = FlxG.stage.stageHeight / 2;
			add( winnerText );
		}
	}
}