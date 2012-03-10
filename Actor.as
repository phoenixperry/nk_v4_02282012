package 
{
	import Box2D.Dynamics.b2Body;
	
	import starling.display.DisplayObject;
	import starling.display.Sprite; 

	/**
	 * ...
	 * @author phoenix
	 */
	public class Actor extends Sprite
	{
		protected var _body:b2Body; 
		protected var _costume:DisplayObject; 
		
		public function Actor(myBody:b2Body, myCosutme:DisplayObject) 
		{
			_body = myBody; 
			_costume = myCosutme; 
			if ( _body.GetType() == b2Body.b2_dynamicBody)
				
			{	
				updateMyLook(); 
				childSpecificUpdating(); 
			}
		}
		public function updateNow(): void 
		{
			updateMyLook(); 
			childSpecificUpdating(); 	
		}
		
		protected function childSpecificUpdating():void 
		{
			//child specific updating class. 
			
		}
		
		public function destroy():void 
		{
			//remove the actor from the world
			trace("offScreen"); 
			
			
		}
		private function updateMyLook():void 
		{
			_costume.x = _body.GetPosition().x * GameMain.RATIO; 
			_costume.y = _body.GetPosition().y * GameMain.RATIO; 
			//_costume.rotation = _body.GetAngle() * 180 / Math.PI; 
			
			if (_costume.x < 0 || _costume.y < 0 || _costume.x > 1024 || _costume.y >768) {
			//	removeEventListener(Event.ENTER_FRAME, onRun); 
				//parent.removeChild(this); 
				destroy(); 
			}
 
			
		}
		
		
		
	}
	
}