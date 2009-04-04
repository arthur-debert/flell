package flell {
    import flash.display.*;
    import flash.events.*;
    
    import flell.bin.*;
    import flell.paths.*;
    
	public class Shell extends EventDispatcher {
		
        public var environment : Environment;
        public  var defaultCommands : Array = [Echo, Ls, Cd, Pwd];
        public var stage : Stage;
        
        public var history : HistoryManager;
        
        
		public function Shell(){
			super();
		}
		
		public function init(stage : Stage) : void{
		    this.stage  = stage;
		    environment = new Environment(stage);
		    history = new HistoryManager();
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
		    history.add(text);
		    return output;
		}
		
		public function getCompletionsForCommand(textToComplete : String) : Array{
		    var matching : Array = [];
		    for(var n : String in environment.commands){
		        if(n.substr(0, textToComplete.length) == textToComplete) matching.push(n);
		    }
		    return matching;
		}
		
		public function getCompletion (input : String) : CompletionResult {
		    var raw : Array = input.split(" ");
		    var result : CompletionResult;
		    if (raw.length == 1 && raw[0].length == 0){
		        // nothing to complete here, backoff
		        result = new CompletionResult([]);
		    }else if(raw.length == 1){
		        // trying a command:
		        var possibleCommands : Array = getCompletionsForCommand(raw[0]);
		        result = new CompletionResult(possibleCommands);
		    }else{
		        // should be a path:
		        var partialInput : String = raw[raw.length -1];
		        //trace('"' + partialInput + '"');
		        if( partialInput == ""){
		            result = new CompletionResult([]);
		        }else{
		            var possiblePaths : Array = getCompletionsForPath(partialInput);
		            result = new CompletionResult(possiblePaths);
		        }
		        
		        
		        
		    }
		    return result;
		}
		public function getCompletionsForPath(path : String) : Array{
		    
		    //var pathStart : PathPart = environment.currentDir;
		    var pathParts : Array = path.split("/");
		    var searchFrom : PathPart = environment.currentDir;
		    if(path.charAt(0) == PathResolver.PATH_SEPARATOR){
		        searchFrom = PathResolver.getFrom(environment.stage);
		    }
		    
		    var basePath : PathPart = null;
		    if (pathParts.length > 1){
		        basePath = resolvePath(environment,  pathParts.slice(0, -1).join(PathResolver.PATH_SEPARATOR ) ); 
		        if (!basePath){
		            return []; 
		        }
		    }else{
		        basePath = environment.currentDir;
		    }

		    return  basePath.children.filter(function(pathPart : PathPart, ...rest) : Boolean{
		        return pathPart.nameMatches(path);
		    }).map(function ( p : PathPart, ...rest) : String{
		       return p.fullPath; 
		    });
		}
		
		
	}	
}