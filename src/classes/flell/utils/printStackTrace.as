/* AS3
	Copyright 2008 __MyCompanyName__.
*/
package flell.utils {
	
	public function printStackTrace(traces : Boolean = true) : String{
	    var res : String
	    
	    try{
	        throw Error("ds");
	    }catch (e : Error){
	        var msg : String ;
	        msg = e.getStackTrace();
	        msg = msg.substr( msg.indexOf("printStackTrace"));
	        msg = "Stack trace:" + msg.substr(msg.indexOf("\n"));
	    }
	    
	    traces ? trace(msg) : null;
	    return msg;
	}
	
}
