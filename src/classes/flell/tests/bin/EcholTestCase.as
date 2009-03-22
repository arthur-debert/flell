package flell.tests.bin
{
    import flash.events.Event;
    
    import flell.tests.BaseFlellTestCase;

    public class EcholTestCase extends BaseFlellTestCase
    {
        public function EcholTestCase(name :String)
        {
            super(name);
        }
        
        override public function setUp() : void{
            super.setUp();
            dispatchEvent(new Event(Event.INIT, false, false));
        }
        
        public function testPlainEcho():void{
            assertEquals(shell.executeRaw("echo hello world"), "hello world");
        }
        
        public function testPlainEcho2():void{
            assertEquals(shell.executeRaw("echo hello worlds"), "hello worlds");
        }
    }
}