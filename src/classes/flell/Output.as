package flell {
	import flash.utils.Dictionary;
	import flell.dump;
	
	public class Output {
		public var buffer : String ;
		public var returnCode : int;
		
		public function Output(buffer : String, returnCode : int){
            this.buffer = buffer;
            this.returnCode = returnCode;
		}

        public function toString() : String{
            return buffer;
        }
        
        public function toValue() : Number{
            return returnCode;
        }
    }
}
