package 
{
	import starling.display.Sprite; 

	public class LevelGen extends Sprite
	{
		protected var _actors:Array; 
		
		public function LevelGen()
		{
			_actors = []; 
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
			for (var i:int = 0; i < _actors.length; i++) 
			{
				if(level.numChildren < 0) {
					removeChild(_actors[i]); 
					//_actors[i].removeEventListeners();
				}
			}
		}
		
	}
}