var Ownable = artifacts.require("./Ownable.sol");
var RaffleTruffle = artifacts.require("./RaffleTruffle.sol");

module.exports = function(deployer) {
  deployer.deploy(RaffleTruffle);
  /*deployer.deploy(Ownable).then(
    () => {
      deployer.deploy(RaffleTruffle);
    }
  ).catch(
    error => {
      console.log(error);
    }
  )*/
};
