// ActionScript file
package flell.paths{
    public function split(fullPath : *) : Array{
            fullPath = String(fullPath);
            var base : String = fullPath.substr(0, fullPath.lastIndexOf(PathResolver.PATH_SEPARATOR));
            var file : String  = fullPath.substr(base.length);
            return [base, file];
    }
}