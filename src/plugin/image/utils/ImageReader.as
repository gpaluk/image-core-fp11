package plugin.image.utils 
{
	import flash.utils.ByteArray;
	import plugin.image.utils.IDataReader;
	/**
	 * ...
	 * @author Gary Paluk - http://www.plugin.io
	 */
	public class ImageReader implements IDataReader
	{
		
		private var _data:ByteArray;
		
		public function ImageReader( data:ByteArray ) 
		{
			_data = data;
		}
		
	}

}