// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

contract ManualToken {
    mapping (address => uint) public balanceOf;
    mapping (address => mapping(address => uint)) public allowance;

    // transfer tokens
    function _transfer(address from, address to, uint256 amount) public {
        balanceOf[from] -= amount;
        balanceOf[to] += amount;
    }
    // transfer tokens
    function transfer(address from, address to, uint256 amount) public {
        _transfer(from, to, amount);
    }

    function transferFrom(
        address _from,
        address _to,
        uint256 _value
    ) public returns (bool success) {
        require(_value <= allowance[_from][msg.sender]); // Check allowance
        allowance[_from][msg.sender] -= _value;
        _transfer(_from, _to, _value);
        return true;
    }

}