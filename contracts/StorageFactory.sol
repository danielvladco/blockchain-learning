// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

import "./SimpleStorage.sol";

contract StorageFactory {
    SimpleStorage[] public storages; // contains all the addresses for the deployed storages


    function crateNewStorage() public {
        SimpleStorage s = new SimpleStorage();
        storages.push(s);
    }

    // To call a contract you need its address and ABI
    // ABI - Application Binary Interface (Since we import SimpleStorage this is automatically added)
    function store(uint _simpleStorageIndex, string memory _name) public {
        // If we had an array of addresses instead of array of contracts in "storages" we would need to cast it like:
        // SimpleStorage(storages[_simpleStorageIndex])
        storages[_simpleStorageIndex].store(_name);
    }

    function get(uint _simpleStorageIndex) public view returns (string memory) {
        return storages[_simpleStorageIndex].name();
    }
}