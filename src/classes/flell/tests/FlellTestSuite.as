package flell.tests
{    
    import br.com.stimuli.kisstest.TestSuite;
    import flash.display.Stage;
    
    import flell.tests.bin.EcholTestCase;
    import flell.tests.paths.*;
     
    public class FlellTestSuite extends TestSuite
    {
        public static var stage : Stage;
        
        public var testClasses : Array;
        
        public function FlellTestSuite()
        {
            
        }
        
        public function init(stage : Stage) : void{
            FlellTestSuite.stage = stage;
            testClasses = [
                JoinStringTestCase,
                ChangeDirTestCase,
                EcholTestCase
                
            ];    
            
            testClasses.forEach(function (t : Class, ...rest) : void{
                addTestCase(t);
             });
        }

    }
}