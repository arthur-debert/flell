// ActionScript file
package flell.paths{
    import flell.paths.PathResolver;
    
    public function isAbsolute(pathName : String) : Boolean{
        return (pathName.substr(0,PathResolver.PATH_SEPARATOR.length) == PathResolver.PATH_SEPARATOR);
    }
}