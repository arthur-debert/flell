package flell.bin {
    import flell.paths.*;
    import flash.utils.Dictionary;
	import flell.Command;
	import flell.CommandOption;
    import flell.Output;
    import flell.Environment
	public class Ls extends Command {
	    public static var NAME :String = "ls";
	    
		public function Ls(environment : Environment){
            super(environment, Ls);
		    baseOptions  = [
    	        new CommandOption("l", "long", Boolean,  false, false, false ),
    	        new CommandOption("p", "show_children", Boolean,  false, false, false ),
    	        new CommandOption("r", "recursive", Boolean,  false, false, false ),
    	    ]

		}
		
		override public function executeRaw(text : String) : Output{
		    return super.executeRaw(text);
	    }
	    
		override public function execute(options : Array, args : Array) : Output{
		    var resolveFrom : String =   environment.currentDir.fullPath;
		    if (args[0] && args[0].length > 1){
		        resolveFrom = args[0] 
		    }
            var fromPath : PathPart = resolvePath(environment, resolveFrom);
            var isRecursive : Boolean = Boolean(getOptionValues('r')[0]);
            var children : Array = getChildren(fromPath, isRecursive);
            
            var longValue : Boolean = Boolean(getOptionValues('l')[0]);        
            var buffer : String = "\n";
            var formatedChildern : Array = [];
            if(isRecursive){
                for (var i:int = 0; i<children.length; i++){
                    formatedChildern[i] = children[i].indentedName;
                    if (longValue){
                        formatedChildern[i]  += ":: " + children[i].type;
                    }
                    
                }
            }else{
                formatedChildern = children;
            }
            formatedChildern.unshift(" ");
            /*if (isRecursive){
                indentByDepthLevel(children);
            }*/
            
            if (longValue || isRecursive){
                buffer =  formatedChildern.join("\n");
            }else{
                buffer = formatedChildern.join(" ");
            }
            return new Output(buffer, 0);
		}

        public function getChildren(fromPath : PathPart, recursive : Boolean = false) : Array{
            var children : Array = [];
            var tempPathPart : PathPart;
            trace(fromPath);    
            for (var i:int = 0; i<fromPath.numChildren; i++)
            {
              tempPathPart = fromPath.getChildAt(i);
              children.push(tempPathPart);
              if (recursive && fromPath.numChildren > 0 ){
                  children = children.concat(getChildren(tempPathPart, true));
              }
            }
            return children;
        }
	}
	
}
