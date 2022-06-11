// SPDX-License-Identifier: None
pragma solidity <=0.8.4;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

contract FruitCoin is ERC20, Ownable {

    address[] public TokenList;
    uint private maxSupply = 10000 * (10**18);

    constructor(uint256 initialSupply) ERC20("FruitToken", "FRUIT") { 
        _mint(msg.sender, initialSupply); // Mints 100 tokens to wallet
    }


    function mint(address account, uint256 amount) external onlyOwner  {
        require(maxSupply > totalSupply() + amount, "Insufficient supply");
        _mint(account, amount);
    }

    function burn(uint256 amount) external onlyOwner {
        _burn(msg.sender, amount);
    }


    function _afterTokenTransfer(
        address from,
        address to
    ) internal virtual {
        
        if(balanceOf(from) == 0 && AddressExists(from)){  //from address is found in TokenList
            //Delete address from TokenList
            uint index = IndexOfAddress(from);
            delete TokenList[index];
        }
        else if(balanceOf(from) > 0 && !AddressExists(from)) { //from address is not found in TokenList
            //Add address to TokenList
            TokenList.push(from);
        }
        if(!AddressExists(to)){  //to address is not found in TokenList
            //Add Address to TokenList
            TokenList.push(to);
        }
    }

    function AddressExists(address addr) public view returns (bool) {
        for (uint i = 0; i < TokenList.length; i++) {
            if (keccak256(abi.encodePacked(TokenList[i])) == keccak256(abi.encodePacked(addr))) {
                return true;
            }
        }
        return false;
    }

    function IndexOfAddress(address addr) public view returns (uint) {
        for (uint i = 0; i < TokenList.length; i++) {
            if (keccak256(abi.encodePacked(TokenList[i])) == keccak256(abi.encodePacked(addr))) {
                return i;
            }
        }
    }


}
