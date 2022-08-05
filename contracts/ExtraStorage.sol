// SPDX-License-Identifier: MIT
pragma solidity ^0.8.12;

import "./SimpleStorage.sol";

contract ExtraStorage is SimpleStorage {

    // can override only virtual functions
    function store(string memory _name) public override {
        name = string.concat("My name is: ", _name);
    }
}