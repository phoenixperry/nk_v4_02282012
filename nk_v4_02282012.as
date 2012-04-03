package 
{
	import Box2D.Collision.b2AABB;
	
	import com.as3nui.nativeExtensions.kinect.events.SkeletonFrameEvent;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	import starling.core.Starling; 
	[SWF(width="1024", height="768", frameRate="60", backgroundColor="#ffffff")]
	public class nk_v4_02282012 extends Sprite
	
	{
		protected var st:Starling;
		public function nk_v4_02282012()
		{
			st = new Starling(GameMain, stage); 
			st.start(); 
			stage.stage3Ds[0].addEventListener(Event.CONTEXT3D_CREATE, onContextCreated);
		}
		
		private function onContextCreated(e:Event):void
		{
			var debugSprite:Sprite=new Sprite();
			addChild(debugSprite);
			(st.stage.getChildAt(0) as GameMain).setDebugDraw(debugSprite)
		}
	}
}