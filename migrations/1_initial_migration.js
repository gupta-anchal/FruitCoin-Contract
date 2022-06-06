const FruitCoin = artifacts.require("FruitCoin");

module.exports = function (deployer) {
  deployer.deploy(FruitCoin);
};
