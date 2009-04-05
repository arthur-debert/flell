package flell
{
    import flash.net.SharedObject;
    
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
        public var persistToSharedObject : Boolean = true;
        public var sharedObjectIdentifier : String = "shell";
        
        public function HistoryManager()
        {
            data = persistToSharedObject ? retrieveLocalHistory() : [];
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
		    if(persistToSharedObject){
		        writeToDisk();
		    }
		}
		
		public function writeToDisk() : void{
		    try{
		        var so : SharedObject = SharedObject.getLocal("flell");
		        so.data.history = data;
		        so.flush();
		    }catch(e : Error){
		        // do nothing
		    }
		    
		}
		
		public function retrieveLocalHistory() : Array{
		    try{
		        var so : SharedObject = SharedObject.getLocal("flell");
		        if (so.data.history){
		          return so.data.history
		        } 
		    }catch(e : Error){
		        // do nothing
		    }
		    return [];
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
		    if(!historyCommand) return ""; 
		    return data[index];
		}

    }
}