var RaffleTruffle = artifacts.require("./RaffleTruffle.sol");

contract('RaffleTruffle', function(accounts) {

    it("should start a lottery", function() {
        return RaffleTruffle.deployed().then(function(instance) {
          return instance.createLottery.call("Yeah Lottery", 2000000000000000, 2, 1, {value: 6000000000000000, from: accounts[1]});  
        }).then(function() {
            RaffleTruffle.deployed().then(function(instance) {
                assert.equal(instance.lotteries.length, 1, "Lotteries array is empty");
            })
        });
      });

      it("should get the address of the first ticket", function() {
        return RaffleTruffle.deployed().then(function(instance) {
          return instance.createLottery.call("Yeah Lottery", 2000000000000000, 2, 1, {value: 6000000000000000, from: accounts[1]});  
        }).then(function() {
            RaffleTruffle.deployed().then(function(instance) {
                assert.equal(instance.lotteries[0].ticketToAddress[1], accounts[0], "Lotteries array is empty");
            })
        });
      });

      it("should join a lottery", function() {
            var raffle;
            RaffleTruffle.deployed().then(function(instance) {
                raffle = instance;
                instance.createLottery.call("Yeah Lottery", 2000000000000000, 2, 10000, {value: 6000000000000000, from: accounts[1]});  
            }).then(function() {
                raffle.joinLottery.call(0, {value: 2000000000000000, from: accounts[2]});
            }).then(function() {
                assert.equal(instance.lotteries[0].ticketToAddress[2], accounts[2], "not added second ticket");
            });
      });

      
      /*it("should end a lottery", function() {
            var raffle;
            RaffleTruffle.deployed().then(function(instance) {
                raffle = instance;
                return instance.createLottery.call("Yeah Lottery", 2000000000000000, 2, 10000, {value: 6000000000000000, from: accounts[1]});  
            }).then(function() {
                return raffle.joinLottery.call(0, {value: 2000000000000000, from: accounts[2]});
            }).then(function() {
                raffle.endLottery(0);
            }).then(function() {
                assert.equal(raffle.endingLotteries.length, 1, "not added secon ticket");
            })
        });*/

    

});
