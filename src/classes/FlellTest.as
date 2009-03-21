package {
    import flash.display.Sprite;
    import flell.Shell;
    import flash.events.*;
    
    public class FlellTest extends Sprite
    {
        public function FlellTest()
        {
            addEventListener(Event.ADDED, basicRun);
        }
        
        public function basicRun() : void{
            var commands : Array = [
						"echo hello shell",
						"ls -l -r  ",
						"pwd ",
						"cd /root1/box1",
						"cd /badmovie/box1",
						"pwd "
						
];
for each (var raw :String in commands){
	execute(raw);
}
            var s : Shell = new Shell();
            s.init(stage);
                var completes : Array = [
                    "eh", "ech", "l", "p"
                ];
                for each (raw in completes){
	getCompletion(raw);
	
	var pathCompletes : Array = [
    "/ro", "/root1/in", "/root1/box"
];
for each (raw in pathCompletes){
	getCompletionsForPath(raw);
}
}

        }
        function execute(c : String){
        	trace(c , "->", s.executeRaw(c) + "\n\n");
        }
        

        function getCompletion(c : String){
        	trace(c , "->", s.getCompletionsForCommand(c) );
        }

        function getCompletionsForPath(c : String){
        	trace(c , "->", s.getCompletionsForPath(c) );
        }
    }
}
