package flell.terminal {

    import flash.display.*;
    import flash.events.*;
    import  flash.net.*;
    
public class FlellLauncher extends Object {
	
	public var stage : Stage;
	public var triggerWord : String ;
	public var keyBuffer : Array ;
	public var termLoader : Loader;
	public var termURL : String;
	
	
	public function FlellLauncher(stageRef : Stage, termURL : String = "flell.swf", launchOnWord : String = "DEBUG")
	{
		triggerWord = launchOnWord.toLowerCase();
		this.stage = stageRef;
		keyBuffer = [];
		stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown, false);// true, int.MAX_VALUE, true);
		
		this.termURL = termURL;
	}
	
	public function onKeyDown(evt : KeyboardEvent) : void{
	    var char : String = String.fromCharCode(evt.keyCode).toLowerCase();
	    
	    keyBuffer.push(char);
	    if (triggerWord.indexOf(keyBuffer.join("")) == -1){
	        keyBuffer = [];
	    }else{
	        if (keyBuffer.length == triggerWord.length){
	            loadTerminal();
	        }
	    }
	}
	
	public function loadTerminal() : void{
	    if(termLoader) return;
	    termLoader = new Loader();
	    termLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoaded, false);
	    termLoader.load(new URLRequest(termURL));
	}
	
	public function onLoaded(evt : Event) : void{
	    var flell : MovieClip = termLoader.content as MovieClip ;
	    flell.addEventListener(Event.ENTER_FRAME, onInited);
	}
	
	public function onInited(evt : Event=null)  : void{
	    stage.addChild(termLoader);
	    evt.target.removeEventListener(Event.ENTER_FRAME, onInited);
	}
}

}

