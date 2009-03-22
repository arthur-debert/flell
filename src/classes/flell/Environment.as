package flell {
    import flell.paths.*;
    import flash.display.DisplayObject 
	public class Environment extends Object {
	    public var stage : DisplayObject;
	    public var currentDir : PathPart;
	    public var commands : Object;
	    
	    
		public function Environment(stage : DisplayObject){
			this.stage = stage;
			currentDir = new PathPart(stage);
            commands = {}
		}
	}
	
}
