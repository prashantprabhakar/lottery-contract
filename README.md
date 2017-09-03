# lottery-contract
## This is a smart contract for lottery based system satisfying following criteria.
1 .In the constructor the owner of the contract sends a SHa3 hash of the winning guess between 1 and 1,000,000. <br/>
2. In order to participate a user sends 1 ETH to the contract and gets 1 participation token. <br/>
3. If the user sends more than 1 ETH the get 1 token per ETH sent. <br/>
4. If the user sends a fraction of ETH, the excess is returned to them. <br/>
5. The contract has a 'makeGuess' function which accepts a number between 1 and 1,000,000. <br/>
6. When makeGuess is called one token is deducted from the user's balance. <br/>
7. The call to makeGuess fails if the user has insufficient ballance. <br/>
8. The contract has a closeGame function that can only be called by the owner. <br/>
9. Calling the closeGame makes it impossible to send ETH to the contract or call makeGuess. <br/> 
10. The unused tokens are not reimbursed (for simplicity). <br/> 
11. A function winnerAddress will return the address of the winner once the game is closed. <br/>
12. Once the game is closed the winner can call getPrice to collect 50% of the ETH in the contract. <br/>
13. The getPrice function sends the remaining 50% of ETH to the owner of the contract 
