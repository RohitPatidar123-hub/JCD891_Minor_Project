............................Race Condition in TON Smart Contracts................ 

TON smart contracts process messages asynchronously. This means that when multiple messages are sent to a contract, there is no guaranteed order in which they are processed. As a result, a race condition can occur if your contract’s logic depends on the order of message execution.

Q) How TON Bolckchain is Asynchronous ..?

The TON blockchain is asynchronous because smart contracts communicate via delayed message passing instead of instant function calls.

1. Message-Driven Asynchronous Execution
In TON, smart contracts do not call each other directly (like in Ethereum). Instead, they send messages to one another.
These messages are processed asynchronously, meaning that when a contract sends a message to another contract, it does not wait for an immediate response.
The receiving contract processes the message later when the message reaches it in the blockchain's transaction processing.

2. Why is it Asynchronous?
Parallel Processing: The TON blockchain is sharded, meaning that different contracts may be running on different shards (segments of the blockchain). Since these shards operate independently, messages between them cannot be executed instantly.
Transactions Are Bundled into Blocks: A message is processed only when the transaction containing it is included in a new block. This means there is a delay between sending a message and it being executed.

3. How Does It Work?
A contract sends a message.
The message is queued in the blockchain.
When the recipient contract is ready (in its next transaction cycle), it receives and processes the message.
If the recipient needs to send a response, it will send another asynchronous message.

4. Analogy: Email vs. Phone Call
Ethereum (Synchronous Calls): Like a phone call—you send a request, and the receiver responds instantly.
TON (Asynchronous Messages): Like sending an email—you send it, but the recipient might read and reply later

5. Implications of Asynchronous Execution
Pros:
Scalability: Since contracts don’t block each other while waiting for responses, more operations can be processed in parallel.
Efficiency: Reduces network congestion by not forcing instant execution.
Cons:
More Complex Logic: Developers must design contracts carefully to handle delayed responses and message sequencing properly.
No Instant Execution Guarantees: You must handle cases where a contract has to wait for another contract’s response.


Q) How the Race Condition Can Occur in our smart contracts?

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

Q) Why Do Race Conditions Occur?
1. Asynchronous Message Passing
In TON, contracts don’t call each other synchronously (directly). They send messages that are processed later when the blockchain includes them in a block. Therefore, two or more messages can be “in flight” at the same time, and you don’t control the exact order in which they will be included and processed.

2. No Guaranteed Ordering
Even if you (the sender) send Message A first and Message B second, the blockchain might end up processing Message B before Message A (depending on the validators, network conditions, block timings, etc.).

3. Shared State
A contract might store data that gets read and then updated. If multiple messages arrive close together, the state read by the second message might still be the “old” state if the first message hasn’t been processed yet. This mismatch is often called a “race condition” because the outcome depends on which message is processed first

