// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract ZeppelinToken is ERC20 {
    constructor(uint initialSupply) ERC20("ZeppelinToken", "ZT") {
        _mint(msg.sender, initialSupply);
    }
}