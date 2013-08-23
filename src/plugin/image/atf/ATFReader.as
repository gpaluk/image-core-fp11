package plugin.image.atf 
{
	import flash.display3D.Context3DTextureFormat;
	import flash.utils.ByteArray;
	import flash.utils.Endian;
	import plugin.image.atf.enum.ATFTextureType;
	import plugin.image.utils.IDataReader;
	
	/**
	 * ...
	 * @author Gary Paluk - http://www.plugin.io
	 */
	public class ATFReader implements IDataReader
	{
		
		public static const TYPE_2D:ATFTextureType = ATFTextureType.TYPE_2D;
		public static const TYPE_CUBE:ATFTextureType = ATFTextureType.TYPE_CUBE;
		
		private var _magic:String;
		private var _type:ATFTextureType;
		private var _format:String;
		private var _width:int;
		private var _height:int;
		private var _numTextures:int;
		private var _data:ByteArray;
		private var _totalBytes:int;
		
		public function ATFReader( data:ByteArray ) 
		{
			data.endian = Endian.LITTLE_ENDIAN;
			_data = data;
			_data.position = 0;
			parse();
		}
		
		private function parse():void
		{
			parseHeader();
			parseType();
			parseLength();
			parseDimensions();
			parseNumTextures();
		}
		
		private function parseHeader():void
		{
			if( _data.length < 3 )
			{
				throw new Error( "ATF parsing error, invalid length." );
			}
			
			_magic = _data.readUTFBytes( 3 );
			if( _magic != "ATF" )
			{
				throw new Error( "ATF parsing error, unknown format " + _magic );
			}
		}
		
		private function parseLength():void
		{
			_totalBytes = (_data.readUnsignedByte() << 16) + (_data.readUnsignedByte() << 8) + _data.readUnsignedByte();
		}
		
		/* TODO
		BGR_PACKED
		BGRA
		BGRA_PACKED
		COMPRESSED
		COMPRESSED_ALPHA
		*/
		private function parseType():void
		{
			var tdata:uint = _data.readUnsignedByte();
			var type:int = tdata >> 7; // UB[1]
			var format:int = tdata & 0x7f; // UB[7]
			
			switch( format )
			{
				case 0:
				case 1:
						_format = "rgba";
					break;
				case 2:
				case 3:
						_format = "compressed";
					break;
				case 4:
				case 5:
						_format = "compressedAlpha";
					break;
					
					// for old ATF.... TODO.... Look at this stuff
				case 16:
						_format = "compressed";
					break
				default:
					throw new Error( "Invalid ATF format " + format );
			}
			
			switch( type )
			{
				case 0:
						_type = ATFTextureType.TYPE_2D;
					break;
				case 1:
						_type = ATFTextureType.TYPE_CUBE;
					break;
				default:
					throw new Error("Invalid ATF type");
			}
		}
		
		private function parseDimensions():void
		{
			_width = Math.pow( 2, _data.readUnsignedByte() );
            _height = Math.pow( 2, _data.readUnsignedByte() );
		}
		
		private function parseNumTextures():void
		{
			_numTextures = _data.readUnsignedByte();
		}
		
		public function get magic():String 
		{
			return _magic;
		}
		
		public function get type():ATFTextureType 
		{
			return _type;
		}
		
		public function get format():String 
		{
			return _format;
		}
		
		public function get width():int 
		{
			return _width;
		}
		
		public function get height():int 
		{
			return _height;
		}
		
		public function get numTextures():int 
		{
			return _numTextures;
		}
		
		public function get data():ByteArray 
		{
			return _data;
		}
		
		public function get totalBytes():int 
		{
			return _totalBytes;
		}
	}
}