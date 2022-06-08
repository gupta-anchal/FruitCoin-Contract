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
    

    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 amount
    ) internal virtual {
        
    }



    function _afterTokenTransfer(
        address from,
        address to,
        uint256 amount
    ) internal virtual {
        //if(_balances[from] == 0 && _balaces[from] is found in TokenList){
            // Delete address from TokenList
        // }
        // else if(_balances[from] > 0 && _balances[from] is not found in TokenList) {
            // Add _balances[from] to TokenList
        // }


        // if(_balances[to] is not present in TokenList){
            // Add balances[to] to TokenList
        // }
    }

}
