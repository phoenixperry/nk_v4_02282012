package
{
	import Box2D.Collision.*;
	import Box2D.Collision.Shapes.*;
	import Box2D.Collision.Shapes.b2CircleShape;
	import Box2D.Common.Math.*;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.*;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2FixtureDef;
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.ui.GameInput;
	import flash.utils.Dictionary;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	
	public class Diamonds extends Actor
	{
		
		public static const CACHE_ID:String = "DIAMOND"; 
		
		[Embed(source="./assets/level1/sprites/fullSheet/allSprites.png")] 
		public var DiamondBit:Class;  
		
		[Embed(source="./assets/level1/sprites/fullSheet/fullSheet.xml",  mimeType="application/octet-stream")]
		public var DiamondSheet:Class;
		
		//textures 
		private var dAtlas:TextureAtlas; 
		private var dTexture:Texture; 
		protected var dMovie:MovieClip; 
		
		//box2d
		public var dBody:b2Body; 
		protected var dict:Dictionary;
		
		//tests 
		private var beenHit:Boolean = false;
		
		public function Diamonds()
		{
	
			addEventListener(Event.ADDED_TO_STAGE, diamondAdded); 
			
			var dBitmap:Bitmap = new DiamondBit(); 
			dTexture = Texture.fromBitmap(dBitmap, true); 
			
			var dImage:Image = new Image(dTexture); 
			
			var dXml:XML = XML(new DiamondSheet()); 
			dAtlas = new TextureAtlas(dTexture, dXml); 
			
			//first create the costume 
			var dframes:Vector.<Texture> = dAtlas.getTextures("diamond"); 
			name = "diamond"; 
			dMovie= new MovieClip(dframes,1); 
			
			Starling.juggler.add(dMovie); 
			
			dict = new Dictionary();
			//add kitty specific info 
			dict["diamond"] = [
				
				[
					// density, friction, restitution
					2, 0, 0,
					// categoryBits, maskBits, groupIndex, isSensor
					1, 65535, 0, false,
					'POLYGON',
					
					// vertexes of decomposed polygons
					[
						
						[   new b2Vec2(38/GameMain.RATIO, 22/GameMain.RATIO)  ,  new b2Vec2(20/GameMain.RATIO, 90/GameMain.RATIO)  ,  new b2Vec2(2/GameMain.RATIO, 23/GameMain.RATIO)  ,  new b2Vec2(19/GameMain.RATIO, 1/GameMain.RATIO)  ]
					]
					
				]
				
			];
			
			dBody= createBody("diamond", GameMain.world, b2Body.b2_staticBody,dMovie); 
			dBody.SetFixedRotation(true); 
			
			super(dBody, dMovie); 

				
		}
		private function diamondAdded(e:Event):void
		{
			addChild(dMovie); 
			trace("diamond added"); 
			
		}
		
		
		public function createBody(name:String,  world:b2World, bodyType:uint, userData:*):b2Body
		{
			var fixtures:Array = dict[name];
			
			
			//create body 
			var body:b2Body;		
			var f:Number;
			
			// prepare body def
			var bodyDef:b2BodyDef = new b2BodyDef();
			bodyDef.type = bodyType;
			bodyDef.userData = userData;
			//fixes sticking but lord oh lord at what cost 
			bodyDef.bullet = true; 
			
			
			// create the body
			body = GameMain.world.CreateBody(bodyDef);
			// prepare fixtures
			for( f=0; f<fixtures.length; f++)
			{
				var fixture:Array = fixtures[f];
				
				var fixtureDef:b2FixtureDef = new b2FixtureDef();
				
				fixtureDef.density=fixture[0];
				fixtureDef.friction=fixture[1];
				fixtureDef.restitution=fixture[2];
				
				fixtureDef.filter.categoryBits = fixture[3];
				fixtureDef.filter.maskBits = fixture[4];
				fixtureDef.filter.groupIndex = fixture[5];
				fixtureDef.isSensor = fixture[6];
				
				if(fixture[7] == "POLYGON")
				{                    
					var p:Number;
					var polygons:Array = fixture[8];
					for(p=0; p<polygons.length; p++)
					{
						var polygonShape:b2PolygonShape = new b2PolygonShape();
						polygonShape.SetAsArray(polygons[p], polygons[p].length);
						fixtureDef.shape=polygonShape;
						
						body.CreateFixture(fixtureDef);
						
						
					}
				}
				else if(fixture[7] == "CIRCLE")
				{
					var circleShape:b2CircleShape = new b2CircleShape(fixture[9]);                    
					circleShape.SetLocalPosition(fixture[8]);
					fixtureDef.shape=circleShape;
					body.CreateFixture(fixtureDef);                    
				}                
			}
			
			return body;
			
		}
		override protected function childSpecificUpdating():void
		{ 
			addEventListener(Event.ENTER_FRAME, updateDiamond); 	
		}
		
		private function updateDiamond(e:Event):void
		{
			
			dMovie.x = dBody.GetPosition().x * GameMain.RATIO; 
			dMovie.y = dBody.GetPosition().y * GameMain.RATIO; 
			
		}		
		
		public override function hitByActor(actor:Actor):void {
			//not in hit state
			if (! beenHit)
			{	
				beenHit = true; 
				setState(); 
				//dispatchEvent(new PegEvent(PegEvent.PEG_LIT_UP)); 
			}
		}
		private function setState():void { 
			//do animation for hit here. 
			trace("kitty hit by balloon"); 
		}
		
		public function remove ():void
		{
			dAtlas.dispose(); 
			dTexture.dispose(); 
			this.removeChildren(); 
			//			
		}
		
		public function createMine():void { 
			 
		}
		
		//last two 	
	}
}	
