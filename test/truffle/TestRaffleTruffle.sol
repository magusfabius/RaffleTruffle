/*pragma solidity ^0.4.19;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../../contracts/Ownable.sol";
import "../../contracts/RaffleTruffle.sol";

contract TestRaffleTruffle {
  RaffleTruffle game = RaffleTruffle(DeployedAddresses.RaffleTruffle());
  uint public initialBalance = 1 ether;

  function testCreateLottery() public {
      game.createLottery("Yeah Lottery", 2000000000000000, 2, 1, {value: 2000000000000000, from: accounts[1]});  

  }

}
*/