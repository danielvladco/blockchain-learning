// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

library PriceConverter {
    AggregatorV3Interface internal constant priceFeed = AggregatorV3Interface(0x8A753747A1Fa494EC906cE90E9f37563A8AF630e);

    function getPrice() internal view returns (uint) {
        // ignore the rest of return parameters that we don't care about
        (,int price,,,) = priceFeed.latestRoundData();
        return uint(price * 1e10);
    }

    function getConversionRate(uint ethAmount) internal view returns (uint) {
        uint ethPrice = getPrice();
        return (ethAmount * ethPrice) / 1e18;
    }
}
