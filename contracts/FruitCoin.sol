// SPDX-License-Identifier: None
pragma solidity <=0.8.4;
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

contract FruitCoin is ERC20, Ownable {

    using SafeMath for uint256;
    address[] public TokenList;
    uint private maxSupply = (10000 * (10**18));
    uint256 initialSupply = (100 * (10**18));

    constructor() ERC20("FruitToken", "FRUIT") { 
        _mint(msg.sender, initialSupply); // Mints 100 tokens to wallet
    }


    function mint(address account, uint256 amount) external onlyOwner  {
        require(maxSupply > totalSupply() + amount, "Insufficient supply");
        _mint(account, amount);
    }

    function burn(uint256 amount) external onlyOwner {
        _burn(msg.sender, amount);
    }

    function burnFrom(address account, uint256 amount) external onlyOwner {
        uint256 currentAllowance = allowance(account, _msgSender());
        require(currentAllowance >= amount, "ERC20: burn amount exceeds allowance");
        unchecked {
            _approve(account, _msgSender(), currentAllowance - amount);
        }
        _burn(account, amount);
    }

    function _afterTokenTransfer(
        address from,
        address to
    ) internal virtual {
        
        if(balanceOf(from) == 0 && AddressExists(from) > -1){  //from address is found in TokenList but balance becomes 0
            //Delete address from TokenList
            delete TokenList[uint256(AddressExists(from))];
        }
        else if(balanceOf(from) > 0 && AddressExists(from) == -1) { //from address is not found in TokenList and balance is greater than 0
            //Add address to TokenList
            TokenList.push(from);
        }
        if(AddressExists(to) == -1){  //to address is not found in TokenList, balance will always be greater than 0 as transfer is being done to this address
            //Add Address to TokenList
            TokenList.push(to);
        }
    }

    function AddressExists(address addr) public view returns (int) {
        for (uint i = 0; i < TokenList.length; i++) {
            if (keccak256(abi.encodePacked(TokenList[i])) == keccak256(abi.encodePacked(addr))) {
                return int256(i);
            }
        }
        return -1;
    }


}
