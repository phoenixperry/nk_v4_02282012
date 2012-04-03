package 
{
	import Box2D.Collision.Shapes.b2CircleShape;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2DebugDraw;
	import Box2D.Dynamics.b2Fixture;
	import Box2D.Dynamics.b2FixtureDef;
	import Box2D.Dynamics.b2World;
	
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.ui.Keyboard;
	import flash.utils.Timer;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.KeyboardEvent;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.Texture;
	import starling.utils.Stats;

	
	
	
	public class GameMain extends Sprite
	{
		private var level1:LevelOne; 
	    private var k:Kinect;
		private var useKinect:Boolean = false ; 
		private var _mouseX:Number = 0;
		private var _mouseY:Number = 0;
			
		public static var RATIO:Number = 30;
		private static var _world:b2World; 
		public static const GAME_WIDTH:Number = 1024; 
		public static const GAME_HEIGHT:Number = 768;  
		
		private var gameTimer:GameTimer; 
		 
		public function GameMain() 
		{
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
			level1 = new LevelOne(); 
			addChild(level1); 	
		}
		private function onAdded(e:Event):void
		{
			setupPhysicsWorld();
			gameTimer = new GameTimer(); 
			
			
			this.addChild(new Stats());
			removeEventListener(Event.ADDED_TO_STAGE, onAdded); 
	
			if(useKinect) {
				k = new Kinect(); 
				addChild(k); 	
			}
			else{
				
				stage.addEventListener(TouchEvent.TOUCH, onTouch);
				stage.addEventListener(KeyboardEvent.KEY_DOWN, deleteLevel);
				}
		}		
		

		
		private function updateW(e:Event):void
		{
			var timeStep:Number = 1 / 60;
			var velocityIterations:int = 6;
			var positionIterations:int = 2;
			
			
			_world.Step(timeStep, velocityIterations, positionIterations);
			_world.ClearForces();
			_world.DrawDebugData();
			
		}		
		
		private function deleteLevel(e:KeyboardEvent):void { 
			if(e.keyCode == Keyboard.RIGHT){
			//level1.removeLevel(); 
			}
			trace(e);
		}
		
		private function setupPhysicsWorld():void 
		{
			var gravity:b2Vec2 = new b2Vec2(0, 9.8); 
			var allowSleep:Boolean = true; 
			 _world = new b2World(gravity, allowSleep); 
			 addEventListener(Event.ENTER_FRAME, updateW); 
			
			 GameMain.world.SetContactListener(new NKContactListener());
			
		}
		
		
		static public function get world():b2World 
		{
			return _world;
		}
		
		static public function set world(value:b2World):void 
		{
			_world = value;
			
		}
		
		private function onTouch (e:TouchEvent):void
		{
			// get the mouse location related to the stage
			var touch:Touch = e.getTouch(stage);
			var pos:Point = touch.getLocation(stage);
			trace ( touch.phase );
			// store the mouse coordinates
			_mouseY = pos.y;
			_mouseX = pos.x;
			trace(pos.x, pos.y); 
			BalloonActor.xpos = pos.x; 
			BalloonActor.ypos = pos.y;

	
			
		}
		
		public function setDebugDraw(debugSprite:flash.display.Sprite):void{
			
			var debugDraw:b2DebugDraw = new b2DebugDraw();
			debugDraw.SetSprite(debugSprite);
			
						debugDraw.SetSprite(debugSprite);
						GameMain.world.SetDebugDraw(debugDraw); 
						
						debugDraw.SetDrawScale(GameMain.RATIO);
						debugDraw.SetLineThickness( 1.0);
						debugDraw.SetAlpha(1);
						debugDraw.SetFillAlpha(0.8);
						debugDraw.SetFlags(b2DebugDraw.e_shapeBit);

			_world.SetDebugDraw(debugDraw);
			
		}


		
		
	}
}