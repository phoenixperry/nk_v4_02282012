package
{
	import starling.display.Sprite;

	public class SpriteSheet extends Sprite
	{
		[Embed(source="./assets/level1/sprites/fullSheet/fullSheet.xml",  mimeType="application/octet-stream")]
		private static var _FullSheet:Class;
		public static var fullSheetXML:XML; 
				
		public function SpriteSheet()
		{
			fullSheetXML = XML(new _FullSheet()); 
		}

		


	}
}