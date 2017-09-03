pragma solidity ^0.4.11;

contract lottery{
    address public owner;
    bytes32 private answer;    
    bool public closedGame = false;    
    address private winner;
    mapping (address => uint256) public token;
    
    //Constructor
    function lottery(address _owner, uint256 _answer){
        if(_owner !=0)
            owner = _owner;
        // if owner is not specified, make contract deployer the owner.
        else
            owner = msg.sender;
        // check if anser lie in range iof 1-1000000
        if(_answer > 1000000 || _answer<1)
            throw;
        // get sha3 hash of ansewer.
        answer = sha3(_answer);
    }
    
    modifier onlyOwner {
        if (msg.sender != owner) throw;
         _;
    }
    
    modifier onlyWinner {
        if (msg.sender != winner) throw;
         _;
    }
    
     /* This unnamed function is called whenever someone tries to send ether to it */
    function () {
        // if game is closed- do not allow contract to recieve ethers
        if(closedGame)
            throw;     // Prevents accidental sending of ether
    }
    
    // user has to call this function in order to participate
    function participate() payable{
        if(closedGame) throw;
        uint256 amount = msg.value/(10**18);
        if(msg.value < 1) throw;
        uint256 decimalPart = msg.value%(10**18);
        // tarnsfer the decimal points back to user
        msg.sender.transfer(decimalPart);
    
        // give token to participant
        uint256 tokenAmount = amount;
        token[msg.sender] = token[msg.sender] + tokenAmount;
    }
    
    // this function is called by user to make guess of answer
    function makeGuess(uint256 guess){
        if(closedGame) throw;
        if(guess<1 || guess> 1000000) throw;
        if(token[msg.sender]<1) throw;
        token[msg.sender] = token[msg.sender]-1;
        // check if guess is correct - declare the msg.sender the winner
        if(sha3(guess)==answer){
            // reward last gusser
            winner = msg.sender;
        }
        
        
    }
    
    // owner can call this function to stop the game
    function closeGame() onlyOwner{
        // other way is killing contract
        closedGame = true;
    }
    
    // this is called by the winner to get the reward.
    function getPrice() onlyWinner{
        // if Game is not yet closed throw
        if(!closedGame) throw;
        uint256 contractBalance = this.balance;
        winner.transfer(contractBalance/2);
        owner.transfer(contractBalance- contractBalance/2);
    }
}
