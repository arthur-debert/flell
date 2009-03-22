package flell.paths {
    import flash.utils.Dictionary;
    
    import flell.Environment;
	public class PathResolver extends Object {        
        public static var __objects : Dictionary = new Dictionary(true);
        
        public static const PATH_SEPARATOR : String = "/";
		public static const CURR_DIR_MARKER : String = ".";
		public static const PARENT_DIR_MARKER : String = "..";
		
        
        
        public static function getFrom(source : *) : PathPart{
            if (!source) return null;
            if (!__objects[source]){
                __objects[source] = new PathPart(source);
            }
            return __objects[source] as PathPart;
        }
        
        
        
        
		
		
		
	}	
}
