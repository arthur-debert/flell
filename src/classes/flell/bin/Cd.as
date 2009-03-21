package flell.bin {
    import flell.paths.*;
    import flash.utils.Dictionary;
	import flell.Command;
	import flell.CommandOption;
    import flell.Output;
    import flell.Environment
	public class Cd extends Command {
	    public static var NAME :String = "cd";
	    
		public function Cd(environment : Environment){
            super(environment, Cd);
		    baseOptions  = [];

		}
		
		override public function executeRaw(text : String) : Output{
		    return super.executeRaw(text);
	    }
	    
		override public function execute(options : Array, args : Array) : Output{
		    try{
		        var toPath : PathPart = PathResolver.resolve(environment, args[0] || "/");            
                environment.currentDir = toPath;
                return new Output("", 0);
		    }catch(e : Error){
		        
		    }
            return new Output("No such display object.", 2);
		}

    
	}
	
}
