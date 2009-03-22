// ActionScript file
package flell.paths{
    import flell.Environment;
    
    /**
		 * Sets the current source to the new indication.
		 * @param environment   The Environment object to grab current dir from.
		 * @pathName The path, as a String to change to.
		 * @return 
		 * 
		 */		
		public   function changeDir(environment : Environment, pathName : String) : PathPart{
		    var result : PathPart = resolvePath(environment, pathName);
		    if (result){
		        environment.currentDir = result;
		        return result;
		    }
            return null;
		}
}