// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

import "./PriceConverter.sol";

error NotOwner();

contract FundMe {
    // constants are more optimized
    uint constant public MINIMUM_USD = 50 * 1e18;
    AggregatorV3Interface internal priceFeed;
    using PriceConverter for uint;

    address[] funders;
    // immutable variables are also a way to set a value only once
    address immutable i_owner;

    constructor() {
        priceFeed = AggregatorV3Interface(0x8A753747A1Fa494EC906cE90E9f37563A8AF630e);
        i_owner = msg.sender;
    }

    // payable modifier to send money
    receive() external payable {
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
        require(msg.value.getConversionRate() >= MINIMUM_USD, "didn't send enough");
        funders.push(msg.sender);

        // revert undoes all the actions before require and sends the remaining gas back

    }

     function withdraw() public ownerOnly {
         // for loop example
         for (uint funderIndex; funderIndex < funders.length; funderIndex++) {
            address funder = funders[funderIndex];
         }

         payable(msg.sender).transfer(address(this).balance);
//         require(payable(msg.sender).send(address(this).balance), "send funds failed"); another way of sending funds
         // `(bool callSuccess, ) = call{value: balance}("")`
         // if (!callSuccess) { revert TransferFailed(); }

     }

    modifier ownerOnly {
        if (msg.sender == i_owner) { revert NotOwner(); }
        _;
    }
}