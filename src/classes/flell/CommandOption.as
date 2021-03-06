/* AS3
	Copyright 2008 __MyCompanyName__.
*/
package flell {
	import flash.utils.Dictionary;
	import flell.Command;
	
	
	public class CommandOption  {
	    public var takesArgument : Boolean = false;
	    public var multiple : Boolean = false;
	    public var shortName : String;
	    public var fullName : String;
        public var valueType : Class;
        private var _value : * = null;
        public var defaultValue : *;
        
		public function CommandOption(shortName : String, fullName : String, valueType : Class,
		 takesArgument : Boolean = false, defaultValue : * = null, multiple : Boolean = false ){
			this.shortName = shortName;
			this.fullName = fullName;
			this.valueType = valueType;
			this.takesArgument = takesArgument;
			this.defaultValue = defaultValue;
			this.multiple = multiple;
		}	
        
        public function get value() : * { 
            //trace("{CommandOption}::method() shortName", shortName, "valueType", valueType, "_value", _value);
            if (_value != null){
                return  _value as valueType; 
            }
            if(valueType == Boolean){
                return true;
            }
            return null;
        }

        public function set value(newValue:Object) : void { 
            _value = (newValue as valueType); 
        }
		
		
		public function clone(): CommandOption{
		    var opt : CommandOption = new CommandOption(shortName, fullName, 
		    valueType,takesArgument, defaultValue, multiple );
		    opt.value = _value;
		    return opt;
		}
		
		public function toString():String{
		    return "[CommandOption]" + "-" + shortName + ", " + fullName + ": " +value;
		}
	}
	
}
