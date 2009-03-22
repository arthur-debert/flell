package flell.paths{
/**
*    Joins a list of path parts. Mimics python join behaviour.
*      
*/    
    public function joinStr(...paths) : String{
        var isAbs : Boolean = isAbsolute(paths[0]);
        var trailingSlash : Boolean = paths[paths.length-1].charAt(paths[paths.length-1].length-1) == SEP;
        paths = paths.map(trimEdgesSeparator);
        var path : String = paths.join(SEP);
        if (isAbs) {
            path = SEP + path;
        }
        if(trailingSlash){
            path += SEP;
        }
        return path;
    }
}
import flell.paths.PathResolver;
var SEP : String = PathResolver.PATH_SEPARATOR;
function trimEdgesSeparator(str : String, ...ignore ) : String{
        var needsTrimming : Boolean = str.charAt(0) == SEP || str.charAt(str.length-1) == SEP; 
        while (needsTrimming) {
            if (str.charAt(0) == SEP){
                str = str.substr(1);
            }
            if (str.charAt(str.length -1 ) == SEP ){
                str = str.substr(0, -1);
            }
            needsTrimming = str.charAt(0) == SEP || str.charAt(str.length-1) == SEP;
        }
        return str;
}