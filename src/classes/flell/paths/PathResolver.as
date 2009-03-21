package flell.paths {
    import flash.utils.Dictionary;
    import flell.paths.PathPart;
    import flell.utils.printStackTrace;
    import flash.display.DisplayObject;
    import br.com.stimuli.string.printf;
    import flell.Environment;
	public class PathResolver extends Object {        
        public static var __objects : Dictionary = new Dictionary(true);
        public static function resolve (environment : Environment, pathName : String, regexMatch : Boolean = false) : PathPart{
            var current : PathPart
            if (pathName.charAt(0) == "/"){
                current =  getFrom(environment.stage);
            }else{
                current = environment.currentDir;
            }
            if(pathName == "/") return current;
            var parts : * = pathName.substr(1).split("/");
            var dobj : *;
            while (parts.length > 0){
                if(parts[0].length >0 ){
                    current = current.getChildByName(parts[0]);
                    if (!current){
                        return  null;
                    }
                    parts.shift();
                }
            }
            return current;
        }
        
        public static function getFrom(source : *) : PathPart{
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
	}	
}
