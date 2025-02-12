import "@stdlib/deploy";
message Deposit{
    amount :Int as int32;
}

message Withdrawl{
    amount :Int as int32;
}
contract Bank with Deployable{
      value :map<Address, Int as int32 >; //persistemt data 
      
      init(){
        self.value = empty();
      }

      receive(msg : Deposit){
          let address = sender(); //local data
          if(self.value.exist(address)){
          let balance = self.value.set(address); 
          balance =balance +msg.amount;
          self.value.set(address,balance);
          self.reply("Deposit Done ".asComment());
          
          }
          else {
            self.value.set(address,msg.amount);
            self.reply("Deposit Done ".asComment());     
          }
      }
      
      receive(msg : Withdrawl){
        let address = sender();
        if(self.value.exist(address)) //here we check is user is valid or not
         { 

            if(self.value.get(address)>=msg.amount) //here we check is user have sufficient balance or not
            {
                    let balance =self.value.get(address);
                    balance=balance-msg.ammount;
                    self.value.set(address,balance);
                    self.reply("Withdrawl Successfully Done!".asComment()); // asComment converts a String to a Cell with a comment
            }
            else 
            {
                self.reply("Oh ! Sorry Insufficient balance ".asComment()); // asComment converts a String to a Cell with a comment
                
            }
        }
        else{
          
            self.reply("Oh ! Your Account not exist ".asComment()); // asComment converts a String to a Cell with a comment
        }  
  
      }
      get fun getValue(){
        return self.value;
      }

}