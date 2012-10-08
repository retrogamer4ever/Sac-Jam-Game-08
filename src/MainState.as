package
{
	import org.flixel.FlxButton;
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	import org.flixel.FlxU;
	
	public class MainState extends FlxState
	{
		[Embed(source="../data/bg.png")] public var bg:Class;
		[Embed(source="../data/fistPump.jpg")] public var fistPump:Class;
		
		[Embed(source="../data/getReady.mp3")] public var getReady:Class;
		
		[Embed(source="../data/mainMenu.mp3")] public var mainMenu:Class;
		
		
		override public function create():void
		{
			FlxG.playMusic( mainMenu );
			
			
			FlxG.mouse.show();
			
			add( new FlxSprite( 0, 0, bg ) );
			
			var mainText:FlxText = new FlxText( 0, 0, 600, "YOU MUST SURVIVE!!!" );
			mainText.size = 30;
			mainText.x = FlxG.stage.stageWidth / 2 - 200;
			mainText.y = FlxG.stage.stageHeight / 2 - 190;
			add( mainText );
			
			var button:FlxButton = new FlxButton();
			button.loadGraphic( fistPump );
			add( button );
			
			button.x = FlxG.stage.stageWidth / 2 - 230;
			button.y = FlxG.stage.stageHeight / 2 - 90;
			FlxG.play( getReady );
			button.onUp = function():void {  FlxG.fade( 0xff000000, 1, function():void
			{
				FlxG.music.stop();
				FlxG.switchState( new PlayState() );
			});}
		}
	}
}