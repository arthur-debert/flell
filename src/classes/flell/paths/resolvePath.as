// ActionScript file
package flell.paths{
    import flell.Environment;
    
    public function resolvePath (environment : Environment, pathName : String, regexMatch : Boolean = false) : PathPart{
            var current : PathPart
            if (isAbsolute(pathName)){
                current =  PathResolver.getFrom(environment.stage);
                pathName = pathName.substr(1 );
            }else{
                current = environment.currentDir;
            }
            if(pathName == PathResolver.PATH_SEPARATOR || pathName == "") return current;
            
            var parts : * = pathName.split(PathResolver.PATH_SEPARATOR);
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
}