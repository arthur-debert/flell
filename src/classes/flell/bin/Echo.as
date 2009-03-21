package flell.bin {
    import flash.utils.Dictionary;
    import flell.Environment;
	import flell.Command;
    import flell.Output;
	public class Echo extends Command {
	    public static var NAME :String = "echo";
	    
		public function Echo(environment : Environment){
			super(environment, Echo);
			
		}
		
		override public function execute(options : Array, args : Array) : Output{
		    return new Output(String(args), 0);
		}
	}
	
}
