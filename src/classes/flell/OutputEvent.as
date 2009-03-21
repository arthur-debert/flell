/* AS3
	Copyright 2008 __MyCompanyName__.
*/
package flell {
	import flash.events.Event;
	
	/*
	*	Event subclass description.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Arthur Debert
	*	@since  19.01.2008
	*/
	public class OutputEvent extends Event {
		
		//--------------------------------------
		// CLASS CONSTANTS
		//--------------------------------------
		
		public static const OUTPUT : String = "output";
		
		//--------------------------------------
		//  CONSTRUCTOR
		//--------------------------------------
		public var output : String
		public function OutputEvent( type:String, bubbles:Boolean=true, cancelable:Boolean=false, output :String = "" ){
			super(type, bubbles, cancelable);		
			this.output = output;
		}
		
		override public function clone() : Event {
			return new OutputEvent(type, bubbles, cancelable, output);
		}
		
		
	}
	
}
