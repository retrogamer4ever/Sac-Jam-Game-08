package
{
	import org.flixel.FlxGroup;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.FlxText;

	public class Hud extends FlxGroup
	{
		public var nameTxt:FlxText;
		public var lifeTxt:FlxText;
		public var shieldTxt:FlxText;
		public var atkTxt:FlxText;
		public var speedTxt:FlxText;
		
		public var dead:Function;
		
		public function set name( value:String ):void {  nameTxt.text = "Name: " + value;  } 
		public function set life( value:int ):void 
		{ 
			_life -= value; 
			
			if( _life <= 0 ) 
			{
				if( dead != null )
				{
					dead();
				}
				
				lifeTxt.text = "Life: 0"; 	
			}
			else
			{
				lifeTxt.text = "Life: " + _life.toString(); 	
			}
		} 
		public function set shield( value:int ):void { _shield -= value; shieldTxt.text = "Shield: " + _shield.toString();  } 
		public function set atk( value:int ):void { _atk = value; atkTxt.text = "Atk: " + _atk.toString();  } 
		public function set speed( value:int ):void { _speed = value; speedTxt.text = "Speed: " + _speed.toString();  } 
		
		protected var _life:int = 500;
		protected var _shield:int = 100;
		protected var _atk:int = 1;
		protected var _speed:int = 150;
		
		public static const WIDTH:int = 400;
		
		public function Hud( _name:String, state:FlxState, addX:int = 0 )
		{
			nameTxt = new FlxText( 5 + addX, 20, WIDTH, "Name: " + _name );
			nameTxt.size = 16;
			state.add( nameTxt );
			lifeTxt = new FlxText( 5 + addX, 40, WIDTH, "Life: " + _life.toString() );
			lifeTxt.size = 16;
			state.add( lifeTxt );
			
			atkTxt = new FlxText( 5 + addX, 60, WIDTH, "Atk: " + _atk.toString() );
			state.add( atkTxt );
			atkTxt.size = 16;
			
			speedTxt = new FlxText( 5 + addX, 80, WIDTH, "Speed: " + _speed.toString() );
			state.add( speedTxt );
			speedTxt.size = 16;
		}
	}
}