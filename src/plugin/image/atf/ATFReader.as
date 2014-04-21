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
		private var _data:ByteArray;
		private var _signature:String;
		private var _reserved:uint;
		private var _version:uint;
		private var _length:uint;
		private var _cubemap:uint;
		private var _format:uint;
		private var _width:int;
		private var _height:int;
		private var _count:uint;
		
		public function ATFReader( data:ByteArray ) 
		{
			_data = new ByteArray();
			_data.endian = Endian.LITTLE_ENDIAN;
			
			data.position = 0;
			
			_signature = data.readMultiByte( 3, "ascii" );
			_reserved = data.readUnsignedInt();
			_version = data.readUnsignedByte();
			_length = data.readUnsignedInt();
			var tdata : uint = data.readUnsignedByte();
			
			//0 = normal texture
			//1 = cube map texture
			_cubemap = tdata >> 7; 	// UB[1]
			
			//0 = RGB888
			//1 = RGBA88888
			//2 = Compressed
			//3 = RAW Compressed
			//4 = Compressed With Alpha
			//5 = RAW Compressed With Alpha
			_format = tdata & 0x7f;	// UB[7]
			var log2Width:uint = data.readUnsignedByte();
			var log2Height:uint = data.readUnsignedByte();
			_width = 1 << log2Width;
			_height = 1 << log2Height;
			_count = data.readUnsignedByte();
			
			_data = data;
		}
		
		public function get data():ByteArray 
		{
			return _data;
		}
		
		public function get signature():String 
		{
			return _signature;
		}
		
		public function get reserved():uint 
		{
			return _reserved;
		}
		
		public function get version():uint 
		{
			return _version;
		}
		
		public function get length():uint 
		{
			return _length;
		}
		
		public function get cubemap():uint 
		{
			return _cubemap;
		}
		
		public function get format():uint 
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
		
		public function get count():uint 
		{
			return _count;
		}
		
		
	}
}