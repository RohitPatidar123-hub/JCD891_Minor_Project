............................Race Condition in TON Smart Contracts................ 

TON smart contracts process messages asynchronously. This means that when multiple messages are sent to a contract, there is no guaranteed order in which they are processed. As a result, a race condition can occur if your contract’s logic depends on the order of message execution.


Q.1 ) How the Race Condition Can Occur ?
Ans .1)
1. Consider the following scenario:

Two Messages in Quick Succession:
A user (through a wallet contract) sends two messages to bank :

first messange is deposit() 
second mesage is withdraw()

2. Asynchronous Processing:

Because TON processes messages asynchronously, it is possible that the withdraw() message is included in a block before the deposit() message.

3. Outcome When withdraw() Arrives First:

State at Processing: The contract checks the sender’s balance. Since the deposit hasn’t been processed yet, the balance is still 0.

Failure:  if(self.value.get(address)>=msg.amount) fails because 0 < msg.amount .
Alternatively, in more complex scenarios, this out-of-order execution may lead to unexpected behavior.

Even though this situation might not occur frequently, it demonstrates that the final outcome depends on which message is processed first. In an asynchronous system like TON, this order is not guaranteed.

