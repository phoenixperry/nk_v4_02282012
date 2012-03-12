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
		protected var items:Array; 
		public function Actor(myBody:b2Body, myCosutme:DisplayObject) 
		{	
			items= [];
			_body = myBody; 
			_costume = myCosutme; 
			_body.SetUserData(this); 
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
		
		
		protected function hitByActor(actor:Actor):void
		{
			// OVERRIDE IN EXTENDED ACTOR CLASS.
		}
		
		
		protected function destroy():void { 
			cleanUpBeforeRemoving(); 
		}
		
		protected function cleanUpBeforeRemoving():void { 
			//remove the costume 
//			_costume.parent.removeChild(_costume); 
			GameMain.world.DestroyBody(_body);
			_costume.removeEventListeners(); 
			
		}
		
		
	}
	
}