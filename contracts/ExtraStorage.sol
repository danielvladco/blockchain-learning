// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

import "./SimpleStorage.sol";

contract ExtraStorage is SimpleStorage {

    // can override only virtual functions
    function store(string memory _name) public override {
        name = "My name is: " + _name;
    }
}