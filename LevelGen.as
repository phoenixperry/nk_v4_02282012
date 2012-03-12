package 
{
	import flash.display.DisplayObjectContainer;
	
	import starling.display.Sprite;

	public class LevelGen extends Sprite
	{
		protected var items:Array; 
		
		public function LevelGen()
		{
			items = []; 
			//update level 
			//make an array for all objects 
			//remove level 
		}
		protected function loadLevel():void {
					
		}
		
		protected function removeLevel(level:LevelGen):void {
			//this is going to take more than this... research here 
			//remove all the listeners for a level. 
			level.removeEventListeners(); 
	
			//remove all the actors of the level. 
			for (var i:int = 0; i < items.length; i++) 
			{
				if(level.numChildren < 0) {
					//DisplayObject(items[i]).removeEventListeners(); 
					parent.removeChild(items[i]); 
					
				}
			}
		}
		
	}
}