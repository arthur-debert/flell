package flell
{
    public class CompletionResult
    {
        public var type : String;
        public static const TYPE_ERROR : String = "error";
        public static const TYPE_SINGLE : String = "single";
        public static const TYPE_MULTIPLE : String = "multiple";
        public var results : Array;
        public function CompletionResult(results : Array)
        {
            if (results.length == 0){
                type = TYPE_ERROR;
            }else if (results.length == 1){
                type = TYPE_SINGLE;
            }else{
                type = TYPE_MULTIPLE;
            }
            this.results = results;
        }

    }
}