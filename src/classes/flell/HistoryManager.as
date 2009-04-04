package flell
{
    /**
     * Keeps track of shell command history, does cursor movement on it and retrieves it's items.
     *  
     * @author arthur
     * 
     */    
    public class HistoryManager
    {
        
        public var data : Array;
        public static var NUM_HISTORY_ITEMS : int = 200;
        public var _index : int ;
        
        public function HistoryManager()
        {
            data = [];
        }
        
        public function get index() : int{
            return _index;
        } 
        
        public function set index(i : int):void{
            _index = i;
        }
        
        public function add(text : String) : void{
            if (!text || text.length == 0) return;
		    if (data.length >= NUM_HISTORY_ITEMS){
		        data.shift();
		    }
		    data.push(text);
		    index = data.length ;
		}
		
		public function get isFirst () : Boolean{
		    return index == 0;
		}
		
		public function get isLast() : Boolean{
		    return index == data.length ;
		}
		public function previous() : String{
		    index --;
		    if (index >= 0){
		        return data[index];
		    }else{
		        index = 0;
		    }
		    return "";
		}
		
		public function next() : String{
		    index ++;
		    if (index <= data.length -1){
		        return data[index];
		    }else {
		        index == data.length;
		        
		    }
		    return "";
		}
		
		public function get current () : String{
		    
		    var historyCommand : String =  data[index];
		    trace(index, historyCommand);
		    if(!historyCommand) return ""; 
		    return data[index];
		}

    }
}