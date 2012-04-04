package 
{
	import flash.display3D.textures.Texture;
	import flash.geom.Point;
	import flash.utils.Dictionary;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.EnterFrameEvent;
	import starling.events.Event;
	
	
	public class LevelOne extends LevelGen
	{
		
		[Embed(source="./assets/level1/sprites/para1.png")]
		private var para1:Class;
		
		[Embed(source="./assets/level1/sprites/para2.png")]
		private var para2:Class;
	
		private var para:Parallex; 
		
		private var kitty:Kitty1; 
		private var w:Number = 1024; 
		private var h:Number = 768; 
		private var b:Number=1024; 
		private var s:Number=20; 
		private var vert:Boolean = false; 
		//private var items:Array; 
		private var SIDE_WALL_THICKNESS:Number = 1; 
		private var SIDE_WALL_HEIGHT:Number = GameMain.GAME_HEIGHT; 
		private var LEFT_WALL_POSITION:Point; 
		private var RIGHT_WALL_POSITION:Point;  
		protected var items:Array; 
		private var ball:BalloonActor; 
		

		public function LevelOne()
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE, loadl)
			items = []; 
			
			
		}
		  	protected function loadl(e:Event):void { 
			removeEventListener(Event.ADDED_TO_STAGE, loadLevel); 
			
		//	parallax
			para = new Parallex(para1, para2, w, h, b, s, vert); 
			addChild(para); 
			addEventListener(Event.ENTER_FRAME, update); 
		
	
//			for (var j:int = 0; j < 20; j++) 
//			{
//				var xp:Number = 200 + (j*20); 	
//				var foo2:BallActor = new BallActor(this, new Point(xp,200), new Point(10,-3));
//				addChild(foo2); 
//				items.push(foo2); 
//			}
			
	//		balloon
			ball = new BalloonActor();
			addChild(ball);

			
			kitty = new Kitty1(); 
			addChild(kitty); 
			
		
			makeAWall();
			}
			

		private function update(e:Event):void { 
		para.update(); 
			for each(var actor:Actor in items) {
				actor.updateNow(); 
			}
		}
		
		private function makeAWall():void {
			LEFT_WALL_POSITION = new Point(0,0); 
			RIGHT_WALL_POSITION = new Point(GameMain.GAME_WIDTH, 0); 
			var BTM_WALL_POSITION:Point = new Point(0, GameMain.GAME_HEIGHT); 
			
			var wallShapeCoords:Array = new Array(); 
			wallShapeCoords.push(
					new Array( 
						new Point(0,0), 
						new Point(SIDE_WALL_THICKNESS, 0),
						new Point(SIDE_WALL_THICKNESS, SIDE_WALL_HEIGHT),
						new Point(0, SIDE_WALL_HEIGHT)
						)
					); 
			var floorCoords:Array = new Array(); 
			floorCoords.push(
					new Array(
						new Point(0, 0), 
						new Point(GameMain.GAME_WIDTH, 0), 
						
						new Point(GameMain.GAME_WIDTH, SIDE_WALL_THICKNESS), 
						new Point(0, SIDE_WALL_THICKNESS)
						)
					); 
			
			//add left wall 
			var leftWall:ArbiStaticActor = new ArbiStaticActor(this, LEFT_WALL_POSITION, wallShapeCoords); 
			//items.push(leftWall); 
		
			var rightWall:ArbiStaticActor = new ArbiStaticActor(this, RIGHT_WALL_POSITION, wallShapeCoords); 
			//items.push(rightWall); 
		
			var btmWall:ArbiStaticActor = new ArbiStaticActor(this, BTM_WALL_POSITION, floorCoords); 
			
		}
		
	override public function removeLevel():void {
		//this is going to take more than this... research here 
		//remove all the listeners for a level. 
		//			if(this.numChildren < 0) {
		//				
		//				removeChildAt(1); 
		//				
		//			}

			//remove textures, children, listeners the shazm! 
			ball.remove(); 	
			kitty.remove(); 
			para.remove(); 
		
		//getting the box2d bodies outta here!  
		
			kitty.destroy(); 
			ball.destroy(); 
			
			//now let's get those starling babies out of here! 
			//objects first! 
			this.removeChildren(); 
				
			this.dispose();
			trace(numChildren); 
			//listeners outta here
			this.removeEventListeners(); 
			
	}	
	
	}
}