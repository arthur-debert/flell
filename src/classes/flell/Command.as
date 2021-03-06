/* AS3
	Copyright 2007 Arthur Debert.
*/
package flell {
	import flash.utils.Dictionary;
	import flell.dump;
	import flell.Output;
	import flell.errors.*;
	public class Command {
		//public var name : String  = "Command";
		public var doc : String;
		public var args : Array = [];
		public var options : Array = [];
		public var baseOptions : Array = [];
		public var environment : Environment;
        public var defaultArg : *;
        public var theClass : Class;
		public function Command(environment : Environment, theClass :Class){
		    this.environment = environment;
		    this.theClass = theClass;
		}
        
        public function parseOptions(text : String) : void{
            // parses matches into results object 
            var option_re : RegExp = /-(?P<optionname>[\w\d]+)\s+(?P<argument>[\w\d\.\/]+)?/g;
		    var match : * = option_re.exec(text);
		    var matches : Array = [];
		    if(!match){
		        args[0] = text;
		        return;
		    }
		    while(Boolean(match)){
		        //dump("match..", match);
		        matches.push(match);
		        match = option_re.exec(text);
		    }

		    //if(match)trace("{Command}::method() match[argument]", match["argument"]);
		    var argsIndex : int = 0;
		    if (matches.length >0){
		        var last : Object = matches[matches.length -1];
		        var optionHasArgument : Boolean = false;
		        argsIndex = last.index + matches[matches.length -1].toString().length;
		    }
            /*trace("{Command}::method() argsIndex", argsIndex);
            trace("{Command}::method() text.substr(argsIndex)", text.substr(argsIndex));*/
		    // now loops through each command and try to apply it to this options
		    var chainedOptions : Array ;
		    var optionName :String;
		    var option : CommandOption;
		    var errors : Array = [] ;
		    var optionTemplate : CommandOption;
		    var optionsPresent : Array;
		    for (var i:int = 0; i<matches.length; i++){
		        match = matches[i];
		        // are we "joining multiple options together?"
		        chainedOptions = match.optionname.split("");
		        
		        for (var k:int = 0; k<chainedOptions.length; k++){
		           optionName = chainedOptions[k];
		           try{
		              optionTemplate = getOptionTemplateByName(optionName);
		           }catch(e : InvalidOptionError){
		                errors.push(e);
		                continue;
		           }
		           optionsPresent = getOptionsByName(optionName);
		           
		           if (optionsPresent.length == 0 || optionsPresent.length > 0 && optionsPresent[0].multiple ){
                       // did we pass a value to this?
                       option = optionTemplate;
                       if (match.argument && option.takesArgument){
       		               option.value = match.argument;
       		           }
       		           options.push(option);
                   }

		           
		        }
		    if (errors.length > 0){
		        throw new Error(errors.join("\n"));
		    }
		    // check we have an argument to the command:

		    if (matches.length >0 ){
		        var lastOption : CommandOption = options[options.length -1]
		        if (!lastOption || (!lastOption.takesArgument)){
                    args.push(matches[matches.length -1]["argument"]);
		        }
		    }
	    }
	    
        }
        
        public function getOptionTemplateByName(optionName : String) : CommandOption{
            for (var i:int = 0; i<baseOptions.length; i++){
                if (baseOptions[i].shortName == optionName){
                    return baseOptions[i].clone()
                }
            }
            throw new InvalidOptionError(theClass["NAME"] + " does not accept the '" +optionName + "' option" );
        };
        public function getOptionsByName(optionName : String) : Array{
            // is this option already set?
            //trace("{Command}::method() options", options);
            var present : Array = options.filter(function(o : CommandOption, ...i) : Boolean{
                //trace("{Command}::method() o", o);
                return o.shortName == optionName;
            });
            return present;
            
        }
		 public function executeRaw(text : String) : Output{
		     var o : Output;
		    try{
		         parseOptions(text);
		    }catch(e : Error){
		        o = new Output(e.message, -1);
		        return o;
		    }
		    
		    return execute(options, args);
		}
		
		public function getOptionValues(optionName : String) : Array{
		    return getOptionsByName(optionName).map(function(o:*, ...r):*{
		        return o.value;
		    });
		}
		
		public function execute(options : Array,arguments : Array ) : Output{
		    throw new Error("Each command should implement this");
		    return new Output("null", 0);
		}
		
		public function printOptions() : void{
		    options.forEach(function(o :*, ...i):void{trace(i.toString())});
		    trace("args", args);
		}
		public function toString() : String{
		    return "abstract command ";
		}
	}
}
