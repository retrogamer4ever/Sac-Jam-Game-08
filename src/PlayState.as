package
{
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.events.TimerEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.utils.Timer;
	
	import net.pixelpracht.tmx.TmxMap;
	
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxObject;
	import org.flixel.FlxParticle;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	import org.flixel.FlxTilemap;
	import org.flixel.FlxU;

	public class PlayState extends FlxState
	{
		[Embed(source="../data/bg.png")] public var bg:Class;
		
		[Embed(source="../data/gameplay.mp3")] public var gameplay:Class;
		
		[Embed(source="../data/three.mp3")] public var three:Class;
		[Embed(source="../data/two.mp3")] public var two:Class;
		[Embed(source="../data/one.mp3")] public var one:Class;
		[Embed(source="../data/go.mp3")] public var go:Class;
		
		[Embed(source="../data/powerup.mp3")] public var powerup:Class;
		
		[Embed(source="../data/sfx.mp3")] public var sfx:Class;
		
		public var playerOne:Player;
		public var playerTwo:Player;
		
		public var playerOneHud:Hud;
		public var playerTwoHud:Hud;
		
		public static var winningColor:uint;
		public static var survivalTime:int;
		
		public static var survivalTimeTimer:Timer;
		
		public var pause:Boolean = true;	
		
		public var gameStartCountDownTimer:Timer;
		public var gameStartCountDown:int;
		
		public var countDownText:FlxText;
		public var survivalCountDownTxt:FlxText;
		
		public static var survivalCountDownAmount:int = 0;
		
		public var spawnTimer:Timer;
		
		public var spawnItemGroup:FlxGroup;
		
		override public function create():void
		{
			super.create();
			
			
			FlxG.mouse.hide();
				
			add( new FlxSprite( 0, 0, bg ) );
			
			playerOne = new Player( FlxU.makeColor( 255, 0, 0 ), this, playerOneHud );
			playerOne.useWASD = true;
			
			playerOne.body.immovable = true;
			
			playerOne.body.x = FlxG.stage.stageWidth / 2 - 200;
			playerOne.body.y = FlxG.stage.stageHeight / 2 + 200;
			
			add( playerOne.body );
			
			
			playerTwo = new Player( FlxU.makeColor( 0, 0, 255 ), this, playerTwoHud );
			playerTwo.body.immovable = true;
			
			playerTwo.body.x = FlxG.stage.stageWidth / 2 + 200;
			playerTwo.body.y = FlxG.stage.stageHeight / 2 - 125;
			
			add( playerTwo.body );
			
			playerTwoHud = new Hud( "Blue", this, 670 );
			playerTwoHud.dead = function():void {
			winningColor = FlxU.makeColor( 0, 0, 255 ); playerTwo.body.kill(); FlxG.music.stop(); FlxG.switchState( new WinState() ); }
			
			add( playerTwoHud );
			
			
			playerOneHud = new Hud( "Red", this, 10 );
			playerOneHud.dead = function():void { winningColor = FlxU.makeColor( 255, 0, 0 ); playerOne.body.kill(); FlxG.music.stop(); FlxG.switchState( new WinState() ); }
			add( playerOneHud );
			
			pause = true;
			
			countDownText = new FlxText( 0, 0, 790, "" );
			countDownText.size = 70;
			countDownText.x = FlxG.stage.stageWidth / 2 - 25;
			countDownText.y = FlxG.stage.stageHeight / 2 - 170;
			add( countDownText );
			
			
			
			gameStartCountDown = 0;
			
			gameStartCountDownTimer = new Timer( 700 );
			gameStartCountDownTimer.addEventListener( TimerEvent.TIMER, onGameStartCountDown );
			gameStartCountDownTimer.start();
		
			spawnTimer = new Timer( 6000 );
			spawnTimer.addEventListener( TimerEvent.TIMER, onItemSpawn );
			spawnTimer.start();
			
			spawnItemGroup = new FlxGroup();
		}
		
		protected function onItemSpawn( event:TimerEvent ):void
		{
			//I JUST DON'T CARE ANYMORE... SO FREAKING TIRED :-(
			try
			{
			var ran:int = Math.random() * 1;
			
			if( ran == 0 )
			{
				//attack power up
				var atkPowerUp:FlxSprite = new FlxSprite();
				atkPowerUp.ID = 1;
				
				
				atkPowerUp.makeGraphic( 6, 6, FlxU.makeColor( 124, 252, 0 ) ); 
				
				atkPowerUp.x = FlxG.stage.stageWidth / 2  - Math.random() * 200;
				atkPowerUp.y = FlxG.stage.stageHeight / 2  + Math.random() * 200;
				
				add( atkPowerUp );
				
				spawnItemGroup.add( atkPowerUp );
			}
			else
			{
				var speedPowerUp:FlxSprite = new FlxSprite();
				speedPowerUp.ID = 2;
				
				speedPowerUp.makeGraphic( 6, 6, FlxU.makeColor( 255, 255, 0 ) ); 
				
				speedPowerUp.x = FlxG.stage.stageWidth / 2  - Math.random() * 200;
				speedPowerUp.y = FlxG.stage.stageHeight / 2  + Math.random() * 200;
				
				spawnItemGroup.add( speedPowerUp );
				
				add( speedPowerUp );
			}
			}
			catch(error:Error)
			{
				
			}
		}
		
		public function onSurvivalTime( event:TimerEvent ):void
		{
			//SUCH BAD CODING... BUT I JUST DON'T CARE ANYMORE... :-( JAM DAY 2
			try
			{
				survivalCountDownAmount += 1;
				survivalCountDownTxt.text = "Survived " + survivalCountDownAmount.toString() + " seconds";
			}
			catch( error:Error )
			{
				
			}
		}
		
		public function onGameStartCountDown( event:Event ):void
		{
			if( gameStartCountDown == 0 )
			{
				countDownText.text = "3";
				FlxG.play( three );
			}
			else if( gameStartCountDown == 1 )
			{
				countDownText.text = "2";
				FlxG.play( two );
			}
			else if( gameStartCountDown == 2 )
			{
				countDownText.text = "1";
				
				FlxG.play( one );
			}
			else if( gameStartCountDown == 3 )
			{
				countDownText.text = "GO!";
				FlxG.play( go );
			}
			else if( gameStartCountDown == 4 )
			{
				FlxG.play( sfx );
				
				
				FlxG.flash( 0xffffffff, 1, function():void
				{
					FlxG.playMusic( gameplay );
					
					countDownText.text = "";
					gameStartCountDownTimer.stop();
					pause = false;
					survivalTimeTimer = new Timer( 1000 );
					
					survivalTimeTimer.addEventListener( TimerEvent.TIMER, onSurvivalTime );
					survivalTimeTimer.start();
					
					survivalCountDownTxt = new FlxText( 0, 0, 790, "" );
					survivalCountDownTxt.size = 24;
					survivalCountDownTxt.x = FlxG.stage.stageWidth / 2 - 150;
					survivalCountDownTxt.y = FlxG.stage.stageHeight / 2 - 270;
					add( survivalCountDownTxt );
					
				});
			}
				
			gameStartCountDown += 1;
		}
		
		override public function update():void
		{
			if( pause ) return;
			
			super.update();
			
			playerOne.update();
			playerTwo.update();
			
			//want player one and player two to collide with each other
			//screwing everything up!
			//FlxG.collide( playerOne.body, playerTwo.body );
			
			//spawnitems with player two
			FlxG.collide( playerTwo.body, spawnItemGroup, function( player:FlxObject, spawnItem:FlxObject ):void
			{
				
				
				//attk power
				if( spawnItem.ID == 1 )
				{
					playerTwo.atk += 3;
					playerTwoHud.atk = playerTwo.atk;
				}
				else if ( spawnItem.ID == 2 )
				{
					playerTwo.speed += 3;
					playerTwoHud.atk = playerTwo.speed;
				}
				
				FlxG.play( powerup );
				spawnItem.kill();
			}); 
			
			//spawnitems with player two
			FlxG.collide( playerOne.body, spawnItemGroup, function( player:FlxObject, spawnItem:FlxObject ):void
			{
				FlxG.play( powerup );
				
				//attk power
				if( spawnItem.ID == 1 )
				{
					playerOne.atk += 3;
					playerOneHud.atk = playerOne.atk;
				}
				else if ( spawnItem.ID == 2 )
				{
					playerOne.speed += 3;
					playerOneHud.atk = playerOne.speed;
				}
				
				FlxG.play( powerup );
				spawnItem.kill();
			}); 
			
			//check player one collision with player two bullets
			FlxG.collide( playerTwo.bGroup, playerOne.body, function( bullet:FlxObject, player:FlxObject ):void
			{
				playerOneHud.life = playerTwo.atk; 
				bullet.kill();
			}); 
			
			
			//check player two collision with player one bullets
			FlxG.collide( playerOne.bGroup, playerTwo.body, function( bullet:FlxObject, player:FlxObject ):void
			{
				playerTwoHud.life = playerOne.atk;
				bullet.kill();
			} ); 
		}
	}
}