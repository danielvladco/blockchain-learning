// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

contract FundMe {
    uint public minimumUsd = 50;

    // payable modifier to send money
    function fund() public payable {
        // how send ETH
        // each transaction has by default:
        // 1. Nonce
        // 2. Gas Price
        // 3. Gas Limit
        // 4. To
        // 5. Value -> msg.value
        // 6. Data
        // 7. v,r,s - some cryptographyc magic shit ????

        // require checks if a condition is true and throws error in not
        require(msg.value >= minimumUsd, "didn't send enough");

        // revert undoes all the actions before require and sends the remaining gas back

    }
    // function withdraw(){}
}