package plugin.image.atf.enum 
{
	/**
	 * ...
	 * @author Gary Paluk - http://www.plugin.io
	 */
	public class ATFTextureType 
	{
		
		public static const TYPE_2D:ATFTextureType = new ATFTextureType( "2d", 0x0 );
		public static const TYPE_CUBE:ATFTextureType = new ATFTextureType( "cube", 0x1 );
		
		private var _type:String;
		private var _value:Number;
		public function ATFTextureType( type: String, value:uint ) 
		{
			_type = type;
			_value = value;
		}
		
		public function get type():String 
		{
			return _type;
		}
		
		public function get value():Number 
		{
			return _value;
		}
		
	}

}