package flell.tests
{
    import br.com.stimuli.kisstest.TestCase;
    
    import flash.display.Sprite;
    import flash.display.Stage;
    
    import flell.Shell;

    public class BaseFlellTestCase extends TestCase
    {
        public var shell : Shell;
        public var testSpriteCreated : int  = 0;
        public static const TREE_NODE_NAME : String = "testTree";
        
        public function BaseFlellTestCase(name : String)
        {
            
            super(name);
        }
        
        override public function setUp() : void{
            shell = new Shell();
            shell.init(FlellTestSuite.stage);
            var stage : Stage = FlellTestSuite.stage;
            var rootNode : Sprite = stage.getChildByName(TREE_NODE_NAME) as Sprite;
            if (rootNode) { stage.removeChild(rootNode)};
            rootNode = new Sprite();
            rootNode.name = TREE_NODE_NAME;
            stage.addChild(rootNode);
            testSpriteCreated = 0;
            createTestDisplayTree(rootNode, 0, 3);
        }
        
        public function createTestDisplayTree(node : Sprite, depth : int, maxDepth : int) :void{
            var stage : Stage = FlellTestSuite.stage;
            var childsPerDepth : int = 4;
            for(var childIndex : int = 0; childIndex < childsPerDepth ; childIndex++){
                    var child : Sprite  = new Sprite();
                    child.name = "sp_" + depth + "_" + childIndex;
                    node.addChild(child);
                    testSpriteCreated ++;
                    if (depth < maxDepth){
                        createTestDisplayTree(child, depth + 1, maxDepth);
                    }
            }
        }
       
       
        
    }
}