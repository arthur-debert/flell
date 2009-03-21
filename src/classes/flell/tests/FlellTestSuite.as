package flell.tests
{    
    import br.com.stimuli.kisstest.TestSuite;
    import flell.tests.paths.ChangeDirTestCase;
    import flash.display.Stage;
    
    import flell.tests.bin.EcholTestCase;
     
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
                ChangeDirTestCase,
                EcholTestCase
                
            ];    
            
            testClasses.forEach(function (t : Class, ...rest) : void{
                addTestCase(t);
             });
        }

    }
}