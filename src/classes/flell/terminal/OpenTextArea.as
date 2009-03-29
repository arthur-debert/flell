package flell.terminal
{
    import mx.controls.TextArea;
    import mx.core.IUITextField;
    
    public class OpenTextArea extends TextArea
    {
        public function OpenTextArea()
        {
            super();
        }
        
        public function get field () : IUITextField{
            return this.textField;
        }
        
        
    }
}