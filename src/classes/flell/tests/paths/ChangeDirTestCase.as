package flell.tests.paths
{
    import flell.tests.BaseFlellTestCase;

    public class ChangeDirTestCase extends BaseFlellTestCase
    {
        public function ChangeDirTestCase(name:String)
        {
            super(name);
        }
        
        override public function setUp() : void{
            super.setUp();
            onSetUpDone()
        }
        
        public function testRootNode() : void{
            trace("'" + shell.environment.currentDir.fullPath + "'");
            assertEquals(shell.environment.currentDir.fullPath, "/");
        }
        
    }
}