package
{
	import org.flixel.FlxEmitter;
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxObject;
	import org.flixel.FlxParticle;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.FlxU;

	public class Player
	{
		[Embed(source="../data/laser.mp3")] public var laser:Class;
		[Embed(source="../data/spaceShip.png")] public var spaceship:Class;
		
		public var bullet:FlxParticle;
		
		public var emitter:FlxEmitter;
		public var body:FlxSprite;
		
		public var SPEED:int = 150;
		
		public var moving:Boolean = false;
		
		public var bullets:Array;

		public var bGroup:FlxGroup;
		
		public var useWASD:Boolean = false;
		
		
		public var atk:int;
		public var shield:int;
		public var speed:int;
		
		protected var _speedExperience:int = 0;
		
		public function set speedExperience( value:int ):void
		{
			_speedExperience += value;
			if( _speedExperience >= 300 )
			{
				speed += 1;
				_hud.speed = speed;
				_speedExperience = 0;
			}
		}
		
		protected var _attackExperience:int = 0;
		
		public function set attackExperience( value:int ):void
		{
			_attackExperience += value;
			
			if( _attackExperience >= 300 )
			{
				atk += 1;
				_attackExperience = 0;
			}
		}
		
		protected var _state:FlxState;
		
		public var _hud:Hud;
		
		public function Player( color:uint, state:FlxState, hud:Hud )
		{
			super();
			
			_hud = hud;
			
			atk = 1;
			shield = 100;
			speed = 130;
			
			_state = state;
			
			bullets = new Array();
			bGroup = new FlxGroup();
			
			body = new FlxSprite();
			body.makeGraphic( 16, 16, color );
			_state.add( body );
		}
		
		public function fireBullet( direction:uint, blank:Boolean = false ):void
		{
			//FlxG.play( laser );
			
			bullet = new FlxParticle();
			
			if( blank != true )
			{
				bullet.makeGraphic( 5, 5, FlxU.makeColor( int( Math.random() * 255 ), int( Math.random() * 255 ), int( Math.random() * 255 ) ) );
				bullet.facing = direction;
			}
			else
			{
				bullet.makeGraphic( 5, 5, FlxU.makeColor( int( Math.random() * 255 ), int( Math.random() * 255 ), int( Math.random() * 255 ) ) );
				bullet.facing = direction;
			}
			
			bullet.x = body.x + body.width / 2;
			bullet.y = body.y + body.height / 2;
			
			bullets.push( bullet );
			bGroup.add( bullet );
			_state.add( bullet );
		}
		
		public function updateBullets():void
		{
			for( var i:int = 0; i < bullets.length; i++ )
			{
				if( bullets[i] == null ) continue;
				
				switch( bullets[i].facing )
				{
					case FlxObject.RIGHT: bullets[i].x += 7; break;
					case FlxObject.LEFT: bullets[i].x -= 7; break;
					case FlxObject.UP:  bullets[i].y -= 7; break;
					case FlxObject.DOWN:  bullets[i].y += 7; break;
				}
				
				//want to destory those bad boys ;-)
				if( bullets[i].x < 0 || bullets[i].x > FlxG.stage.stageWidth )
				{
					_state.remove( bullets[i] );
					bullets[i].kill();
					bullets[i] = null;
				}
				else if( bullets[i].y < 0 || bullets[i].y > FlxG.stage.stageHeight )
				{
					_state.remove( bullets[i] );
					bullets[i].kill();
					bullets[i] = null;
				}
			}
		}
		
		public function update():void
		{
			
			
			updateBullets();	
			
			updateControls();
			
		}
		
		public function updateControls():void
		{
			if( FlxG.keys.RIGHT && useWASD == false )
			{	
				fireBullet( FlxObject.RIGHT );
				
				
				moving = true;
				
				body.facing = FlxObject.RIGHT;
				
				if( body.x <= FlxG.stage.stageWidth - body.width - 5)
				{
					body.x += speed * FlxG.elapsed;
				}
			}
			
			if( FlxG.keys.D && useWASD == true )
			{
				fireBullet( FlxObject.RIGHT );
				moving = true;
				
				body.facing = FlxObject.RIGHT;
				
				if( body.x <= FlxG.stage.stageWidth - body.width - 5 )
				{
					body.x += speed * FlxG.elapsed;
				}
			}
			
			
			if( FlxG.keys.LEFT && useWASD == false )
			{
				fireBullet( FlxObject.LEFT );
				
				moving = true;
				
				body.facing = FlxObject.LEFT;
				
				if( body.x >= 5 )
				{
					body.x -= speed * FlxG.elapsed;
				}	
			}
			
			if( FlxG.keys.A && useWASD == true )
			{
				fireBullet( FlxObject.LEFT );
				
				moving = true;
				
				body.facing = FlxObject.LEFT;
				
				if( body.x >= 5 )
				{
					body.x -= speed * FlxG.elapsed;
				}	
			}
			
			if( FlxG.keys.UP && useWASD == false )
			{
				fireBullet( FlxObject.UP );
				
				moving = true;
				
				body.facing = FlxObject.UP;
				
				if( body.y >= 5 )
				{
					body.y -= speed * FlxG.elapsed;
				}
				
				
			}
			
			if( FlxG.keys.W && useWASD == true )
			{
				fireBullet( FlxObject.UP );
				
				moving = true;
				
				body.facing = FlxObject.UP;
				
				if( body.y >= 5 )
				{
					body.y -= speed * FlxG.elapsed;
				}
				
				
			}
			
			if( FlxG.keys.DOWN && useWASD == false )
			{
				fireBullet( FlxObject.DOWN );
				
				moving = true;
				
				body.facing = FlxObject.DOWN;
				
				if( body.y <= FlxG.stage.stageHeight - body.height  - 5 )
				{
					body.y += speed * FlxG.elapsed;
				}
			}
			
			if( FlxG.keys.S && useWASD == true )
			{
				fireBullet( FlxObject.DOWN );
				
				moving = true;
				
				body.facing = FlxObject.DOWN;
				
				if( body.y <= FlxG.stage.stageHeight - body.height  - 5 )
				{
					body.y += speed * FlxG.elapsed;
				}
			}
			
			/*
			{
				moving = false;
			}
			*/
			/*
			if( FlxG.keys.SPACE && useWASD == false )
			{	
				switch( body.facing )
				{
					case FlxObject.RIGHT:  break;
					case FlxObject.LEFT: fireBullet( FlxObject.LEFT );   break;
					case FlxObject.UP: fireBullet( FlxObject.UP );       break;
					case FlxObject.DOWN: fireBullet( FlxObject.DOWN );   break;
				}
			}
			
			if( FlxG.keys.SHIFT && useWASD == true )
			{		
				switch( body.facing )
				{
					case FlxObject.RIGHT: fireBullet( FlxObject.RIGHT ); break;
					case FlxObject.LEFT: fireBullet( FlxObject.LEFT );   break;
					case FlxObject.UP: fireBullet( FlxObject.UP );       break;
					case FlxObject.DOWN: fireBullet( FlxObject.DOWN );   break;
				}
			}
			*/
		}
		
	}
}