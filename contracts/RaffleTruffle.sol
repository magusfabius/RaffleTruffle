pragma solidity ^0.4.2;

//import 'node_modules/zeppelin-solidity/contracts/ownership/Ownable.sol';
import "./usingOraclize.sol";
import "./Ownable.sol";

contract RaffleTruffle is Ownable, usingOraclize {
    //Only for Oraclize testing 
    //4460000 ropsten test net gas limit
    function RaffleTruffle() {
          OAR = OraclizeAddrResolverI(0x6f485C8BF6fc43eA212E93BBF8ce046C7f1cb475);
    }


    // ------------- Events --------------------
    event NewLottery(uint lotteryId, string name);
    event LotteryWinner(uint lotteryId, address winner, uint luckyTicket);
    //event PurchasedTicket(address player, uint lotteryId, uint[] ticketsId);

    // ------------- Variables -----------------
    uint public dailyJackpotRate = 5;     // 5% of jackpot price goes into the dailyLottery                    
    uint public creatorRate = 5;          // 5% of jackpot price is given to the creator of the lottery       
    uint public houseRate = 5;            // 5% of jackpot is given to the house                               
    uint public terminatorRate = 1;       // 1% of jackpot who terminates the lottery                         
    uint public maxDuration = 604800001;  // 7 days plus one millisecond, it could be incremented in future

    uint public houseBalance; // we need to mantain web server (sic!), pay Oraclize services and drink coffee
    uint public dailyJackpot; 
    uint public nextDailyJackpot; //jackpot accumolated today from tomorrow, it will become dailyJackpot

    uint public minTicketPrice = 2 finney;   
    uint public minLotteryPrice = 4 finney;

    struct Lottery {
        address creator;
        string name;
        uint jackpot;
        uint maxTickets; //if maxTicket is 0 there's no limit
        uint ticketPrice;
        uint ticketCount;
        uint endTime; //uint64 endTime;
        mapping(uint => address) ticketToAddress; //The index of an element in this array correspond to the ticket number
    }

    uint[] public endingLotteries; //id of lotteries that are waiting for the Oraclize callback function
    Lottery[] public lotteries;

    mapping (uint => address) public lotteryToWinner;
    mapping (uint => address) public lotteryToTerminator;
    mapping (address => uint) public playerLotteryCount;

    // ------------- Functions --------------------

    //fallback function
    function() public payable {}

    /*function _createDailyLottery(string _name, uint _initialOffer, uint64 _durationTime, uint _entry) internal {
        uint id = lotteries.push(Lottery(_creator, _name, _initialOffer, uint64(now + _durationTime), _entry)) - 1;
        NewLottery(id, _name);
    }*/

    function createLottery(string name, uint ticketPrice, uint maxTickets, uint duration) public payable {
        require(ticketPrice >= minTicketPrice);
        require(duration < maxDuration);
        require(msg.value == (minLotteryPrice + ticketPrice)); //to open a lottery you need to pay the minLotteryPrice and buy the first ticket which price will be entirely added to the jackpot
  
        Lottery memory newLottery;

        newLottery.creator = msg.sender;
        newLottery.name = name;
        newLottery.jackpot = minLotteryPrice/2 + ticketPrice;
        newLottery.maxTickets = maxTickets;
        newLottery.ticketPrice = ticketPrice;
        newLottery.ticketCount = 1;
        newLottery.endTime = now + duration;

        uint id = lotteries.push(newLottery) - 1;
        lotteries[id].ticketToAddress[1] = msg.sender;

        emit NewLottery(id, name);
    }

    function joinLottery(uint lotteryId) public payable {
        Lottery storage myLottery = lotteries[lotteryId];
        require(lotteries[lotteryId].endTime > now);     //check lottery is not finished
        require(myLottery.ticketPrice == msg.value);      //check the value sent by the user is equal or more than the requested value
        
        //for every ticket purchased increment the ticket number and add that number to the ticketToAddress mapping
        myLottery.ticketCount++;
        myLottery.ticketToAddress[myLottery.ticketCount] = msg.sender;
    }

    // finish a lottery and earn 1% of the jackpot with a death click!
    function endLottery(uint lotteryId) public {
      require(lotteries[lotteryId].endTime <= now); //lottery must be finished
      require(lotteryToTerminator[lotteryId] == address(0)); // require no one has already terminated the jackpot

      lotteryToTerminator[lotteryId] = msg.sender;
      msg.sender.transfer(lotteries[lotteryId].jackpot*1/100);
      lotteries[lotteryId].jackpot = lotteries[lotteryId].jackpot - lotteries[lotteryId].jackpot*1/100;

      if(lotteries[lotteryId].ticketCount == 1){
        lotteries[lotteryId].creator.transfer(lotteries[lotteryId].jackpot); // everything to the creator 
      }else{
        endingLotteries.push(lotteryId);
        _requestRandomNumber(); //call the random function
      }
    }

    //ORACLIZE
    // Oraclize random number functions
    // the callback function is called by Oraclize when the result is ready
    // the oraclize_randomDS_proofVerify modifier prevents an invalid proof to execute this function code:
    // the proof validity is fully verified on-chain

  function _requestRandomNumber() internal{
    oraclize_setProof(proofType_Ledger); // sets the Ledger authenticity proof in the constructor
    uint N = 4; // number of random bytes we want the datasource to return
    uint delay = 0; // number of seconds to wait before the execution takes place
    uint callbackGas = 200000; // amount of gas we want Oraclize to set for the callback function
    bytes32 queryId = oraclize_newRandomDSQuery(delay, N, callbackGas); // this function internally generates the correct oraclize_query and returns its queryId
  }

  function __callback(bytes32 _queryId, string _result, bytes _proof) {
      require(msg.sender == oraclize_cbAddress());
      require(oraclize_randomDS_proofVerify__returnCode(_queryId, _result, _proof) == 0); //must pass the proof verification
    
      uint lotteryId = endingLotteries[0]; //endingLotteries[0] is the first lotteryId that asked for a random number

      //this is the highest uint we want to get. It should never be greater than 2^(8*N), where N is the number of random bytes we had asked the datasource to return
      uint maxRange = lotteries[lotteryId].ticketCount; 
      uint randomNumber = uint(sha3(_result)) % maxRange; // this is an efficient way to get the uint out in the [0, maxRange] range
      
      //And the winner is ...
      address winner = lotteries[lotteryId].ticketToAddress[randomNumber];
      lotteryToWinner[lotteryId] = winner;
      emit LotteryWinner(lotteryId, lotteryToWinner[lotteryId], uint(randomNumber));

      //remove the lottery from the endingLotteries array
      delete endingLotteries[0];

      //increment the daily jackpot with the dailyJackpotFee*ticketsNumber of the amount sent by the address
      uint jackpot = lotteries[lotteryId].jackpot;

      //calculate the rates of the jackpot
      uint dailyJackpotPot = (jackpot * dailyJackpotRate) / 100;
      uint housePot = (jackpot * houseRate) / 100;
      uint creatorPot = (jackpot * creatorRate) / 100;

      //update balances
      nextDailyJackpot = nextDailyJackpot + dailyJackpotPot;
      houseBalance = houseBalance + housePot;

      //payments to creator and winner
      lotteries[lotteryId].creator.transfer(creatorPot);
      winner.transfer(jackpot - (dailyJackpotPot + housePot + creatorPot));

       //move the other elements of the array in order to avoid gaps
      if(endingLotteries.length > 1){
        for(uint i = 0; i < endingLotteries.length-1; i++){
            endingLotteries[i] = endingLotteries[i+1];
        }
        endingLotteries.length--;
      }

    }


    function jackpotDonation(uint lotteryId) public payable {   //everyone can make donations to jackpots without paying rates
        lotteries[lotteryId].jackpot = lotteries[lotteryId].jackpot + msg.value;
    }

    



    // cash stuff
    //we can only take the houseBalance, even if there's a high jackpot we cannot take the jackpot and fly away :(
    function withdrawHouse() external onlyOwner {
        owner.transfer(houseBalance);
    }



    // owner tools
    function setMinTicket(uint newTicketPrice) public onlyOwner {
        minTicketPrice = minTicketPrice;
    }

    function setMinLottery(uint newLotteryPrice) public onlyOwner {
        minTicketPrice = minTicketPrice;
    }

    function setJackpotRate(uint newJackpotRate) public onlyOwner {
        require(newJackpotRate > 1 && newJackpotRate < 21);
        dailyJackpotRate = newJackpotRate;
    }

    function setHouseRate(uint newHouseRate) public onlyOwner {
        require(newHouseRate < 21); //we cannot change that rate to be more of 20%
        houseRate = newHouseRate;
    }

    function setCreatorRate(uint newCreatorRate) public onlyOwner {
        require(newCreatorRate > 1 && newCreatorRate < 21);
        creatorRate = newCreatorRate;
    }

    function setTerminatorRate(uint newTerminatorRate) public onlyOwner {
        require(newTerminatorRate >= 1 && newTerminatorRate < 21);
        terminatorRate = newTerminatorRate;
    }

        
}
    

