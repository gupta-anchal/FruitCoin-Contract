const FruitCoin = artifacts.require("FruitCoin");

module.exports = function (deployer) {
  deployer.deploy(FruitCoin, 100);  //mint 100 tokens intially
};
