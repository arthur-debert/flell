package flell.tests.paths
{
    import flell.paths.PathPart;
    import flell.paths.PathResolver;
    import flell.tests.BaseFlellTestCase;
    import flell.tests.FlellTestSuite;
    
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
            assertEquals(shell.environment.currentDir.fullPath, "/");
        }
        
        public function testOneLevelChange() : void{
            var changedTo : PathPart = PathResolver.changeDir(shell.environment, BaseFlellTestCase.TREE_NODE_NAME);
            trace("changedTo", changedTo);
            assertNotNull(changedTo);
            assertEquals( changedTo.source, FlellTestSuite.stage.getChildByName(BaseFlellTestCase.TREE_NODE_NAME));
            assertEquals(PathResolver.getFrom(changedTo.source), changedTo);
            assertEquals(changedTo, shell.environment.currentDir);
        }
        
        public function testNullOnInvalidChange() : void{
            assertNull(PathResolver.changeDir(shell.environment, "this_does_not_exist"));
            assertNull(PathResolver.changeDir(shell.environment, BaseFlellTestCase.TREE_NODE_NAME + PathResolver.PATH_SEPARATOR + "this_does_not_exist"));
        }
    }
}