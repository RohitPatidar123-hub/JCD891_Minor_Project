import "@stdlib/deploy";
contract user with Deployable {
    
    init() {
    }
    
    reveive("Transection"){
        let VALUE: Int = ton("100");
       
        send(SendParameters{
       
        to: sender(), 
        value: VALUE, 
        mode: SendRemainingValue | SendIgnoreErrors, // ...except for ones received from the sender due to SendRemainingValue
        body: "Deposit".asComment(), // asComment converts a String to a Cell with a comment
        });
   
        
        send(SendParameters{
       
        to: sender(),
        value: VALUE, 
        mode: SendRemainingValue | SendIgnoreErrors, // SendIgnoreErrors that would ignore errors during message sending and would continue to the next action.
        body: "Withdrwal".asComment(), // asComment converts a String to a Cell with a comment
        
        });
        receive(str: String){
            dump(str);
        }



    }
}
