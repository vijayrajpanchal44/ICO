// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

contract ICO is ERC20{
    AggregatorV3Interface internal priceFeed;
    constructor() ERC20("Rapid Token", "RI"){
            priceFeed = AggregatorV3Interface(0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e);
    }

    function buyToken() public payable returns (uint) {
        require(msg.value >= 1 ether,"Minimum deposit amount is 1 ether");
        uint etherAmount = msg.value / 10**18;
        
        uint ETHPriceInDoller = getLatestPrice();
        // uint ETHPriceInDoller = 1500;   

        uint tokenAmount = ETHPriceInDoller * etherAmount;

        _mint(msg.sender, tokenAmount);
        return tokenAmount;
    }    

    function decimals() public pure override returns (uint8) {
        return 0;
    }

    function getLatestPrice() internal view returns (uint) {
        (
            /*uint80 roundID*/,
            int price,
            /*uint startedAt*/,
            /*uint timeStamp*/,
            /*uint80 answeredInRound*/
        ) = priceFeed.latestRoundData();
        uint priceInDoller = uint(price) / 10**8;
        return priceInDoller;
    }

}