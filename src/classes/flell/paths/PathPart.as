package flell.paths {
		
	import flash.display.*;
	import flash.text.TextField;
	public class PathPart {
		public var source : DisplayObject;
		
		
		public function PathPart(source : DisplayObject){
			this.source = source;
			if(!source){
			    throw new Error("Cannot create PathPart with no display");
			}
		}
				
		public function get numChildren () : int{
		    if (source is DisplayObjectContainer){
		        return (source as DisplayObjectContainer).numChildren;
		    }
		    return 0;
		}
		
		public function getChildAt(index : int) : PathPart{
		    if (source is DisplayObjectContainer){
		        return  PathResolver.getFrom((source as DisplayObjectContainer).getChildAt(index));
		    }
		    return null;
		}
		
		public function get children () : Array{
		    var theChildren : Array = new Array(numChildren);
		    for (var i:int = 0; i<numChildren; i++){
		      theChildren[i] = getChildAt(i);
		    }
		    return theChildren;
		}
		
		public function get parent() : PathPart{
		    if (source.parent){
		        return PathResolver.getFrom(source.parent );
		    }
		    return null;
		}
		
		public function get fullPath() : String{
		    var thePath : String = PathResolver.PATH_SEPARATOR;
		    if (parent){
		        thePath = parent.fullPath;
		        thePath +=  source.name + PathResolver.PATH_SEPARATOR;
		    }
		    
		    return thePath;
		}
		
        public function get indentedName() : String{
            var buffer : Array = new Array(depthLevel);
            var separator : String = (new Array(4)).join(" ");
            return buffer.join(separator) + source.name;
        }
        
        public function get depthLevel() : int{
            if (parent){
                return parent.depthLevel + 1;
            }
            return 0;
        }
		public function getChildByName(name : String) : PathPart{
		    if (source is DisplayObjectContainer){
		        trace(source as DisplayObjectContainer);
		        
		        var disObj : DisplayObject = (source as DisplayObjectContainer).getChildByName(name);
		        trace(disObj);
		        return  PathResolver.getFrom(disObj);
		    }
		    return null;
		}
		
		public function get type() : String{
		    if(source is MovieClip){
		        return "MovieClip"
		    }else if(source is Bitmap){
		        return "Bitmap"
		    }else if(source is Sprite){
		        return "Sprite"
		    }else if(source is TextField){
		        return "TextField"
		    }else if(source is Shape){
		        return "Shape"
		    }
		    return "";
		}
		
		public function nameMatches(toMatch : String) : Boolean{
		    return source.name.search(new RegExp(toMatch)) > 0;
		}
		
		public function toString() : String{
		    // 
		    if (source is Stage){
		        return "/";
		    }
		    return source.name;
		}
		
		
	}	
}
