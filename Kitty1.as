package
{

	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2FixtureDef;
	
	import flash.display.Bitmap;
	import flash.geom.Point;
	import flash.ui.GameInput;
	import flash.utils.Dictionary;
	
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas; 

	public class Kitty1 extends Actor
	{
		[Embed(source="./assets/level1/sprites/kitty.png")] 
		public var BalloonBit:Class;  
		
		[Embed(source="./assets/level1/sprites/kitty.xml",  mimeType="application/octet-stream")]
		public var BalloonXml:Class;
		
		public function Kitty1() 
		{
		}
	}
}