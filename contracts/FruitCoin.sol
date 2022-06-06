// SPDX-License-Identifier: None
pragma solidity <=0.8.4;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract FruitCoin is ERC20 {
    constructor() ERC20("FruitToken", "FRUIT") {
        uint256 initialSupply = 100000 * 10**18;
        _mint(msg.sender, initialSupply);
    }
}
