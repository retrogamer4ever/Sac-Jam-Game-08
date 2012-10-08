package
{
	import flash.display.Sprite;
	
	import org.flixel.FlxGame;

	[SWF(width="805", height="605", frameRate="60", backgroundColor="0x000000")]
	[Frame(FactoryClass="Preloader")]
	
	public class SacJam08 extends FlxGame
	{
		public function SacJam08()
		{
			super( 805, 605, MainState );	
		}
	}
}