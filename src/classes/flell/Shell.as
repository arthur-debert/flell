package flell {
    import flash.display.*;
    import flash.events.*;
    
    import flell.bin.*;
    import flell.paths.*;
    
	public class Shell extends EventDispatcher {
		
        public var environment : Environment;
        public  var defaultCommands : Array = [Echo, Ls, Cd, Pwd];
        public var stage : Stage;
        public static var NUM_HISTORY_ITEMS : int = 200;
        public var history : Array = [];
        public var historyCursor : int;
        
		public function Shell(){
			super();
		}
		
		public function init(stage : Stage) : void{
		    this.stage  = stage;
		    environment = new Environment(stage);
		    var commandClass: Class;
		    for (var i:int = 0; i<defaultCommands.length; i++){
		        
		        commandClass = defaultCommands[i];
		        
		        environment.commands[commandClass["NAME"]] = commandClass;
		    }
		    dispatchEvent(new Event("initDone"));
		}
		
		public function executeRaw(text : String) : String{;
		    //var COMMAND_RE : RegExp = /^\b(P?<name>[\w\d]+)\b\b(P?<flag>-[\w\d]+)()
		    var COMMAND_RE : RegExp = /^\b(?P<name>[\w\d]+)\b\s*/g;
		    var match : Object = COMMAND_RE.exec(text);
            /*for (var prop in match){
                trace(prop, ":", match[prop]);
            }*/
		    var name :  String  = match.name;
		    var commandClass : Class = environment.commands[name];
		    if(!commandClass){
		        return name + " is not a known command";
		    }
		    var command : Command = new commandClass(environment);
		    var rest : String = text.substr(match.index + name.length +1);
		    var output : String  = String(command.executeRaw(rest));
		    dispatchEvent(new OutputEvent(OutputEvent.OUTPUT, true, false, output));
		    addToHistory(text);
		    historyCursor = history.length -1;
		    return output;
		}
		
		public function getCompletionsForCommand(textToComplete : String) : Array{
		    var matching : Array = [];
		    for(var n : String in environment.commands){
		        if(n.substr(0, textToComplete.length) == textToComplete) matching.push(n);
		    }
		    return matching;
		}
		
		public function getCompletionsForPath(path : String) : Array{
		    
		    if (path.charAt(0) != "/"){
		        path = environment.currentDir + "/" + path;
		    }
		    var basePath : String = split(path)[0];
		    if(!basePath){
		        return [];
		    }
		    trace("{Shell}::method() basePath", path);
		    var baseDisplayObject  : PathPart = resolvePath(environment, basePath);
		    return  baseDisplayObject.children.filter(function(pathPart : PathPart, ...rest) : Boolean{
		        trace(pathPart, path);
		        return pathPart.nameMatches(path);
		    });
		}
		
		public function addToHistory(text : String) : void{
		    if (history.length >= NUM_HISTORY_ITEMS){
		        history.shift();
		    }
		    history.push(text);
		}
		
		public function historyBack() : String{
		    historyCursor --;
		    if (historyCursor >= 0){
		        return history[historyCursor];
		    }else{
		        historyCursor = 0;
		    }
		    return null;
		}
		
		public function historyForwards() : String{
		    historyCursor ++;
		    if (historyCursor < history.length){
		        return history[historyCursor];
		    }else{
		        historyCursor = history.length;
		    }
		    return null;
		}
	}	
}