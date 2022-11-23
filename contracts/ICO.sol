// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

/**
 * @title ICO contract
 * @author Vijay Raj Panchal
 * @notice This contract can be used for ICO purpose
 * @dev All function calls are currently implemented without side effects
 */

contract ICO is ERC20, Ownable {
    AggregatorV3Interface public immutable priceFeed;
    uint256 public constant TOKEN_PRICE_USD = 1 * 10**8; //10**8 decimals of USD

    event TokenBought(
        uint256 tokenAmount,
        uint256 totalTokenPrice,
        uint256 remainingWeiAmount,
        address beneficiary
    );

    /**
     * Network: Goerli
     * Aggregator: ETH/USD
     * Address: 0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e
     */
    constructor() ERC20("Rapid Innovation", "RI") {
        require(block.chainid == 5, "ICO: Please deploy on Goerli testnet");
        priceFeed = AggregatorV3Interface(
            0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e
        );
    }

    /**
     * @notice User can buy rapid token with exchange of ethers
     * @param tokenAmount Amount of Rapid token
     * @dev User needs to provide sufficient amount of wei as per the rapid tokens Price in dollar
     */
    function buyRapidTokens(uint256 tokenAmount) external payable {
        uint256 totalTokenPrice = calculateTokensPrice(tokenAmount);

        require(
            msg.value >= totalTokenPrice,
            "ICO: Insufficient ether amount"
        );

        uint256 remainingBalance;
        if (msg.value > totalTokenPrice) {
            remainingBalance = msg.value - totalTokenPrice;
            payable(msg.sender).transfer(remainingBalance);
        }

        _mint(msg.sender, tokenAmount);

        emit TokenBought(
            tokenAmount,
            totalTokenPrice,
            remainingBalance,
            msg.sender
        );
    }

    /**
     * @param amount (type uint256) amount of ether
     * @dev function use to withdraw ether from contract
     */
    function withdraw(uint256 amount) external onlyOwner returns (bool success) {
        require(
            amount <= address(this).balance,
            "ICO: function withdraw invalid input"
        );
        payable(_msgSender()).transfer(amount);
        return true;
    }

    /**
     * @notice Calculates price of rapid tokens in wei as per current ether price in dollar
     * @param tokenAmount Amount of Rapid token
     * @return Returns the price of desired token amount in wei
     */

    function calculateTokensPrice(uint256 tokenAmount)
        public
        view
        returns (uint256)
    {
        require(tokenAmount != 0, "ICO: tokenAmount must be greater than 0");

        uint256 currentEthPrice = getLatestPrice();
        // uint256 currentEthPrice = 1200*10**8; //testing
        //1 RI token = 1 $
        //convert all tokenAmount into dollar
        uint256 tokenAmount_USD = (tokenAmount * TOKEN_PRICE_USD) /
            10**decimals(); //10**18

        //calculate all token price in wei
        //calculate TOKEN(dollar) value in wei = 1 ether * 1 token usd price / currentEthPrice
        uint256 totalTokenPrice = (1 ether * tokenAmount_USD) / currentEthPrice;
        return totalTokenPrice;
    }

    /**
     * @notice This function get ethers price from chainlink.
     * @dev Its workes only on Goerli test network
     * @return Returns current price of Ether in dollar
     */
    function getLatestPrice() public view returns (uint256) {
        (, int256 etherPrice, , , ) = priceFeed.latestRoundData();
        return uint256(etherPrice);
    }
}
