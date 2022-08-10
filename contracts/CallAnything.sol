// SPDX-License-Identifier: MIT
pragma solidity ^0.8.12;

contract CallAnything {
    // function selector - fist 4 bytes of the function signature hash???
    // function signature - function name and parameters
    address public s_someAddress;
    uint public s_amount;

    function transfer(address addr, uint amount) public {
        s_someAddress = addr;
        s_amount = amount;
    }

    function getSelectorOne() public pure returns(bytes4 selector) {
        selector = bytes4(keccak256(bytes("transfer(address,uint)")));
    }
    function getDataToCallTransfer(address addr, uint amount) public pure returns(bytes memory) {
        // also abi.encodeWithSignature can be used: equivalent to: abi.encodeWithSelector(keccak256(bytes("transfer(address,uint)")), params...)
        return abi.encodeWithSelector(getSelectorOne(), addr, amount);
    }
    function callTransferFuncBinary(address addr, uint amount) public returns(bytes4, bool) {
        (bool success, bytes memory returnData) = address(this).call(getDataToCallTransfer(addr, amount));
        return (bytes4(returnData), success);
    }
}