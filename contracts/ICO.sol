// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

contract ICO is ERC20{
    AggregatorV3Interface internal priceFeed;
    uint constant public TOKEN_PRICE_USD = 1 * 10**8; //10**8 decimals of USD

    event TokenMinted(
        uint tokenAmount,
        uint totalTokenPrice,
        uint remainingWeiAmount,
        address tokenReceiver
    );
    constructor() ERC20("Rapid Token", "RI"){
            priceFeed = AggregatorV3Interface(0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e);
    }
   
    function buyTokens(uint tokenAmount) public payable {

        uint totalTokenPrice = calculateTokensPrice(tokenAmount);

        require(msg.value >= totalTokenPrice,"Provide more value to get expected token amount");
        
        uint256 remainingBalance = 0;
        if(msg.value > totalTokenPrice){
            remainingBalance =  msg.value - totalTokenPrice;
            payable(msg.sender).transfer(remainingBalance);
        }

        _mint(msg.sender, tokenAmount);
        emit TokenMinted(tokenAmount, totalTokenPrice, remainingBalance, msg.sender);
    }

    function calculateTokensPrice(uint tokenAmount) public view returns (uint totalTokenPrice) {
        require(tokenAmount >= 10**decimals(),"use decimals with token amount");

        uint currentEthPrice = getLatestPrice();
        //1 RI token = 1 $
        //convert all tokenAmount into doller and divide by decimals
        uint tokenAmount_USD = (tokenAmount * TOKEN_PRICE_USD) / 10**decimals();  //10**18
       
        //calculate all token price in wei
        //calculate TOKEN(doller) value in wei = 1 ether * 1 token usd price / currentEthPrice
        totalTokenPrice = (1 ether*tokenAmount_USD)/currentEthPrice;    
    }

    function getLatestPrice() public view returns (uint) {
        (
            /*uint80 roundID*/,
            int etherPrice,
            /*uint startedAt*/,
            /*uint timeStamp*/,
            /*uint80 answeredInRound*/
        ) = priceFeed.latestRoundData();
        return uint(etherPrice);
    }
}