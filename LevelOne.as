package 
{
	import flash.display3D.textures.Texture;
	import flash.geom.Point;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.EnterFrameEvent;
	import starling.events.Event; 
	
	import flash.utils.Dictionary;
	
	
	public class LevelOne extends LevelGen
	{
		
		[Embed(source="./assets/level1/sprites/para1.png")]
		private var para1:Class;
		
		[Embed(source="./assets/level1/sprites/para2.png")]
		private var para2:Class;
	
		private var para:Parallex; 
			
		private var w:Number = 1024; 
		private var h:Number = 768; 
		private var b:Number=768; 
		private var s:Number=20; 
		private var vert:Boolean = true; 
		private var items:Array; 
		
		private var ball:BalloonActor; 
		
		public var foo:BallActor; 
		public function LevelOne()
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE, loadLevel)
			items = []; 
			
			
		}
		 protected function loadLevel(e:Event):void { 
			removeEventListener(Event.ADDED_TO_STAGE, loadLevel); 
			
			//parallax
			para = new Parallex(para1, para2, w, h, b, s, vert); 
			addChild(para); 
			addEventListener(Event.ENTER_FRAME, update); 
			
			//balloon
			ball = new BalloonActor();
			addChild(ball);
			items.push(ball); 
			for (var j:int = 0; j < 20; j++) 
			{
				var xp = 200 + (j*20); 	
				var foo2:BallActor = new BallActor(this, new Point(xp,200), new Point(10,-3));
				addChild(foo2); 
				items.push(foo2); 
			}
//			
			}
			

		private function update(e:Event):void { 
			para.update(); 
			for each(var actor:Actor in items) {
				actor.updateNow(); 
			}
		}
		
//		private function remove():void
//			for(i:Number =0; i < items.length; i++)
//				
		//Actor(items[i]).destroy(); 
//		///to add function that removes all items from the array by calling the remove fucntion of actor -- must be added
		
		//remove any other items in array
		//removeChild(para)
		
	}
}