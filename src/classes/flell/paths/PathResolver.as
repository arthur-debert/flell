package flell.paths {
    import flash.display.DisplayObject;
    
    import mx.utils.DisplayUtil;
    
    import flash.utils.Dictionary;
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
        
        
        
        
		public static function dumpAll(rootNode : DisplayObject) : void{
		    DisplayUtil.walkDisplayObjects(rootNode, printWithDepth);
		} 
		
		public static function printWithDepth (obj : DisplayObject) : void{
		    var pad : String = obj.name;
		    while (obj.parent){
		        obj = obj.parent;
		        pad = "_" + pad;
		    }
		   trace(pad); 
		}
		
	}	
}
