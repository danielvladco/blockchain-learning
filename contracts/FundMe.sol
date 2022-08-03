// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

contract FundMe {
    uint public minimumUsd = 50 * 1e18;
    AggregatorV3Interface internal priceFeed;

    constructor() {
        priceFeed = AggregatorV3Interface(0x8A753747A1Fa494EC906cE90E9f37563A8AF630e);
    }

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
        require(getConversionRate(msg.value) >= minimumUsd, "didn't send enough");

        // revert undoes all the actions before require and sends the remaining gas back

    }

    function getPrice() public view returns (uint) {
        // ignore the rest of return parameters that we don't care about
        (,int price,,,) = priceFeed.latestRoundData();
        return uint(price * 1e10);
    }

    function getConversionRate(uint ethAmount) public view returns (uint) {
        uint ethPrice = getPrice();
        return (ethAmount * ethPrice) / 1e18;
    }
    // function withdraw(){}
}