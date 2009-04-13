package {
    import flash.display.Sprite;
	import flell.terminal.*;
    import flell.terminal.FlellLauncher;
    import flash.events.*;
    
public class FlellRunner extends Sprite {

	public function FlellRunner()
	{

		addEventListener(Event.ADDED_TO_STAGE, onAddedToStage, false);
	}
	
	public function onAddedToStage(evt : Event) : void{
	    removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage, false);
        var launcher : FlellLauncher = new FlellLauncher(stage);
        launcher.loadTerminal();
	}

	
}

}

