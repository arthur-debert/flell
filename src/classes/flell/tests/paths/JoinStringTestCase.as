package flell.tests.paths
{
    import flell.paths.joinStr;
    import flell.tests.BaseFlellTestCase;

    public class JoinStringTestCase extends BaseFlellTestCase
    {
        public function JoinStringTestCase(name:String)
        {
            super(name);
        }
        
        override public function setUp() : void{
            super.setUp();
            onSetUpDone()
        }
        
        public function testNoMeddlingWithOne() : void{
            assertEquals("something", joinStr("something"));
        }
        
        public function testNoMeddlingWithOneSlashAtStart() : void{
            assertEquals("/something", joinStr("/something"));
        }
        
        public function testNoMeddlingWithOneSlashAtEnd() : void{
            assertEquals("/something/", joinStr("/something/"));
        }
    }
}