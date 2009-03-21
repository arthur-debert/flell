package flell.bin {
    import flell.paths.*;
    import flash.utils.Dictionary;
	import flell.Command;
	import flell.CommandOption;
    import flell.Output;
    import flell.Environment
	public class Pwd extends Command {
	    public static var NAME :String = "pwd";
	    
		public function Pwd(environment : Environment){
            super(environment, Cd);
		    baseOptions  = [];
		}
		
		override public function executeRaw(text : String) : Output{
		    return super.executeRaw(text);
	    }
	    
		override public function execute(options : Array, args : Array) : Output{
            return new Output(String(environment.currentDir.fullPath), 0);
		}

    
	}
	
}
