// SPDX-License-Identifier: None
pragma solidity <=0.8.4;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

contract FruitCoin is ERC20, Ownable {

    // mapping(address => uint256) balances;
    uint256 public _totalSupply;
    uint public maxSupply;

    constructor(uint256 initialSupply) ERC20("FruitToken", "FRUIT") {
        maxSupply = 10000 * 10**18; 
        _mint(msg.sender, initialSupply); // Mints 100 tokens to wallet
    }


    function totalSupply() public view virtual override returns (uint256) {
        return _totalSupply;
    }

    function mint(address account, uint256 amount) external onlyOwner  {
        require(maxSupply > _totalSupply + amount, "Insufficient supply");

      _totalSupply += amount;
      _mint(account, amount);
  }

    function burn(uint256 amount) external {
        _burn(msg.sender, amount);
    }
  

}
