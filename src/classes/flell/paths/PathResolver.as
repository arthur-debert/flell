package flell.paths {
    import flash.utils.Dictionary;
    
    import flell.Environment;
	public class PathResolver extends Object {        
        public static var __objects : Dictionary = new Dictionary(true);
        
        public static const PATH_SEPARATOR : String = "/";
		public static const CURR_DIR_MARKER : String = ".";
		public static const PARENT_DIR_MARKER : String = "..";
		
        public static function resolve (environment : Environment, pathName : String, regexMatch : Boolean = false) : PathPart{
            var current : PathPart
            if (isAbsolute(pathName)){
                current =  getFrom(environment.stage);
            }else{
                current = environment.currentDir;
            }
            if(pathName == PATH_SEPARATOR) return current;
            
            var parts : * = pathName.split(PATH_SEPARATOR);
            var dobj : *;
            
            while (parts.length > 0){
                current = current.getChildByName(parts[0]);
                if (!current){
                        return  null;
                }
                parts.shift();
                
            }
            return current;
        }
        
        public static function getFrom(source : *) : PathPart{
            if (!source) return null;
            if (!__objects[source]){
                __objects[source] = new PathPart(source);
            }
            return __objects[source] as PathPart;
        }
        
        public static function split(fullPath : *) : Array{
            fullPath = String(fullPath);
            var base : String = fullPath.substr(0, fullPath.lastIndexOf("/"));
            var file : String  = fullPath.substr(base.length);
            return [base, file];
        }
        
        public static function isAbsolute(pathName : String) : Boolean{
		    return (pathName.substr(0,PATH_SEPARATOR.length) == PATH_SEPARATOR);
		}
		
		
		/**
		 * Sets the current source to the new indication.
		 * @param pathPartObj   Can be a String or PathPart object.
		 * @return 
		 * 
		 */		
		public static  function changeDir(environment : Environment, pathName : String) : PathPart{
		    var result : PathPart = resolve(environment, pathName);
		    if (result){
		        environment.currentDir = result;
		        return result;
		    }
            return null;
		}
	}	
}
