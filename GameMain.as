package 
{
	import Box2D.Collision.Shapes.b2CircleShape;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2Fixture;
	import Box2D.Dynamics.b2FixtureDef;
	import Box2D.Dynamics.b2World;
	
	import flash.geom.Point;
	
	import starling.core.Starling;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.KeyboardEvent;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
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
		public function GameMain() 
		{
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
			level1 = new LevelOne(); 
			addChild(level1); 

		}
		private function onAdded(e:Event):void
		{
			setupPhysicsWorld(); 	
			this.addChild(new Stats());
			removeEventListener(Event.ADDED_TO_STAGE, onAdded); 
			if(useKinect) {
				k = new Kinect(); 
				addChild(k); 	
			}
			else{
				
				stage.addEventListener(TouchEvent.TOUCH, onTouch);
				}
		}		
		
		private function updateW(e:Event):void
		{
			var timeStep:Number = 1 / 30;
			var velocityIterations:int = 6;
			var positionIterations:int = 2;
			
			//	UpdateMouseWorld();
			
			_world.Step(timeStep, velocityIterations, positionIterations);
			_world.ClearForces();
			
		}		
	
		
		private function setupPhysicsWorld():void 
		{
			var gravity:b2Vec2 = new b2Vec2(0, 9.8); 
			var allowSleep:Boolean = true; 
			 _world = new b2World(gravity, allowSleep); 
			 addEventListener(Event.ENTER_FRAME, updateW); 
		
			
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
			
			BalloonActor.xpos = _mouseX; 
			BalloonActor.ypos = _mouseY;
		}

	
	}
}