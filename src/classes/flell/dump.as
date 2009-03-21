package flell {
	public function dump(objName : String, obj :*) : void{
	    var buffer : Array = [objName];
	    for (var prop : String in obj){
	        buffer.push("\t" + prop + ": " + obj[prop]);
	    }
	    trace(buffer.join("\n"));
	}	
}
