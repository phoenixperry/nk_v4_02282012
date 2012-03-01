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
	import flash.geom.Point;
	import flash.ui.GameInput;
	import flash.utils.Dictionary;
	
	
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.extensions.*;
	import starling.extensions.ParticleDesignerPS;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas; 
	import starling.core.Starling;  
	public class BalloonActor extends Actor
	{
		
		[Embed(source="./assets/level1/sprites/particle/texture.png")]
		public var ParticleTexture:Class;
		
		[Embed(source="./assets/level1/sprites/particle/particle.pex", mimeType="application/octet-stream")]
		public var ParticleXML:Class; 
		
		[Embed(source="./assets/level1/sprites/balloon.png")] 
		public var BalloonBit:Class;  
		
		[Embed(source="./assets/level1/sprites/balloon.xml",  mimeType="application/octet-stream")]
		public var BalloonXml:Class;
		
		public var particles:ParticleDesignerPS; 
		
		public static const CACHE_ID:String = "BALLOON"; 
		private var _particleMouseX:Number; 
		public var py:Number; 
		
		public var _BallBody:b2Body; 
		protected var dict:Dictionary;
		protected var bMovie:MovieClip; 
	
		
		protected var _mouseXWorldPhys:Number;
		protected var _mouseYWorldPhys:Number;
		protected var _mouseXWorld:Number=0;
		protected var _mouseYWorld:Number=0;
		protected var _mousePVec:b2Vec2 = new b2Vec2();
		
		private static var _xpos:Number; 
		private static var _ypos:Number; 
		

		
		public function BalloonActor()
		{
			addEventListener(Event.ADDED_TO_STAGE, balloonAdded); 
			_particleMouseX = 0; 

			var balloonBitmap:Bitmap = new BalloonBit(); 
			var balloonTexture:Texture = Texture.fromBitmap(balloonBitmap, true); 
			
			var balloonImage:Image = new Image(balloonTexture); 
			
			var balloonXml:XML = XML(new BalloonXml()); 
			var balloonAtlas:TextureAtlas = new TextureAtlas(balloonTexture, balloonXml); 
			
			
			
			//first create the costume 
			var bframes:Vector.<Texture> = balloonAtlas.getTextures("balloon"); 
			name = "balloon"; 
			 bMovie= new MovieClip(bframes, 30); 
			 
			Starling.juggler.add(bMovie); 
			
			particles = new ParticleDesignerPS(XML(new ParticleXML()),
				Texture.fromBitmap(new ParticleTexture())); 
		
		
			
			
			// point array for box2d 
			dict = new Dictionary();
			
			
			dict["mouse"] = [
				
				[
					// density, friction, restitution
					1, 0.2,0.2,
					// categoryBits, maskBits, groupIndex, isSensor
					1, 65535, 0, false,
					'POLYGON',
					
					// vertexes of decomposed polygons
					[
						
						[   new b2Vec2(-4/GameMain.RATIO, 55/GameMain.RATIO)  ,  new b2Vec2(14/GameMain.RATIO, 13/GameMain.RATIO)  ,  new b2Vec2(52/GameMain.RATIO, -3/GameMain.RATIO)  ,  new b2Vec2(81/GameMain.RATIO, -3/GameMain.RATIO)  ,  new b2Vec2(10/GameMain.RATIO, 121/GameMain.RATIO)  ,  new b2Vec2(-17/GameMain.RATIO, 98/GameMain.RATIO)  ] ,
						[   new b2Vec2(197/GameMain.RATIO, 51/GameMain.RATIO)  ,  new b2Vec2(185/GameMain.RATIO, 89/GameMain.RATIO)  ,  new b2Vec2(26/GameMain.RATIO, 149/GameMain.RATIO)  ,  new b2Vec2(10/GameMain.RATIO, 121/GameMain.RATIO)  ,  new b2Vec2(81/GameMain.RATIO, -3/GameMain.RATIO)  ,  new b2Vec2(102/GameMain.RATIO, -4/GameMain.RATIO)  ,  new b2Vec2(144/GameMain.RATIO, -1/GameMain.RATIO)  ,  new b2Vec2(181/GameMain.RATIO, 13/GameMain.RATIO)  ] ,
						[   new b2Vec2(98/GameMain.RATIO, 189/GameMain.RATIO)  ,  new b2Vec2(26/GameMain.RATIO, 149/GameMain.RATIO)  ,  new b2Vec2(185/GameMain.RATIO, 89/GameMain.RATIO)  ,  new b2Vec2(175/GameMain.RATIO, 140/GameMain.RATIO)  ,  new b2Vec2(163/GameMain.RATIO, 175/GameMain.RATIO)  ] ,
						[   new b2Vec2(175/GameMain.RATIO, 140/GameMain.RATIO)  ,  new b2Vec2(185/GameMain.RATIO, 89/GameMain.RATIO)  ,  new b2Vec2(186/GameMain.RATIO, 114/GameMain.RATIO)  ] ,
						[   new b2Vec2(144/GameMain.RATIO, -1/GameMain.RATIO)  ,  new b2Vec2(102/GameMain.RATIO, -4/GameMain.RATIO)  ,  new b2Vec2(123/GameMain.RATIO, -5/GameMain.RATIO)  ]
					]
					
				]
				
			];
			
			
			_BallBody = createBody("mouse", GameMain.world, b2Body.b2_dynamicBody,bMovie); 
		
			super(_BallBody, bMovie); 
			trace(_xpos, _ypos); 
		}
		
	
		public static function set ypos(value:Number):void
		{
			_ypos = value;
		}

	
		public static function set xpos(value:Number):void
		{
			_xpos = value;
		}

	public function balloonAdded(e:Event):void { 
	
		particles.start(); 
		particles.emitterX = bMovie.x +93; 
		particles.emitterY = bMovie.y + 140; 
		_particleMouseX = 	particles.emitterX; 
		py = 	particles.emitterY;
		
		//now add it to juggler
		Starling.juggler.add(particles); 


		addChild(particles); 
		addChild(bMovie); 		
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
			
			
			// create the body
			body = GameMain.world.CreateBody(bodyDef);
			// prepare fixtures
			for(f=0; f<fixtures.length; f++)
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
		addEventListener(Event.ENTER_FRAME, updateMouse); 	
		}
		
		private function updateMouse(e:Event):void
		{
			_mouseXWorldPhys = (_xpos-bMovie.width/2) / GameMain.RATIO;
			_mouseYWorldPhys = (_ypos- bMovie.height/4) / GameMain.RATIO;
			//	trace(_mouseXWorldPhys, _mouseYWorldPhys, xpos, ypos); 
			if(_xpos > 0 && _xpos <stage.stageWidth) { 
				var ballTarget:b2Vec2= new b2Vec2(_mouseXWorldPhys, _mouseYWorldPhys); 
				var ballCurrent:b2Vec2 = new b2Vec2(_BallBody.GetPosition().x, _BallBody.GetPosition().y);
				trace(_BallBody.GetPosition().x, _BallBody.GetPosition().y); 
				var diff:b2Vec2 = new b2Vec2((ballTarget.x-ballCurrent.x), (ballTarget.y-ballCurrent.y)); 
				//iff.Normalize(); 
				diff.Multiply(12);
				_BallBody.SetLinearVelocity(diff); 
				_BallBody.SetAngularVelocity(0); 
				
			} 
			// set the rotation of the sprite
			bMovie.x = _BallBody.GetPosition().x * GameMain.RATIO; 
			bMovie.y = _BallBody.GetPosition().y * GameMain.RATIO;  
			particles.x = (_BallBody.GetPosition().x * GameMain.RATIO); 
			particles.y = (_BallBody.GetPosition().y* GameMain.RATIO)+10; 

			trace(_xpos, _ypos); 
			
		}		
		
	
	
//			
			
		}
	}
