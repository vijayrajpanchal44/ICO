# Initial Coin Offering (ICO) contract
## Table of Content

- [Project Description](#project-description)
- [Technologies Used](#technologies-used)
- [Folder Structure](#a-typical-top-level-directory-layout)
- [Install and Run](#install-and-run)

## Project Description 
This Initial Coin Offering(ICO) project helps to buy Rapid tokens in exchange for Ether as per the current price of ether in the dollar. The rapid token price is 1 Dollar so if a user wants to buy the rapid token then he needs to pay 1 dollar of worth ether.

## Technologies Used 
- Soldity
- Openzepplein
- Chainlink
- Hardhat


## A typical top-level directory layout

    .
    ├── Contracts               # Contract files (alternatively `dist`)
    ├── Scripts                 # Script files (alternatively `deploy`)
    ├── test                    # Automated tests (alternatively `spec` or `tests`)
    ├── LICENSE
    └── README.md


## Install and Run
To run this project, you must have the following installed:
1.  [nodejs](https://nodejs.org/en/)
2. [npm](https://github.com/nvm-sh/nvm)

- Run `npm install` to install dependencies
```bash
$ npm install
```
- Run `npx hardhat compile` to compile all contracts.


```bash
$ npx hardhat compile
```
## Test  
For a unit testing smart contract using the command line.

```
$ npx hardhat test
```
Expecting `icoTest.js` result.
```bash

  Initial Coin Offering (ICO) contract
    ✔ Should revert if deploy on other then goerli network
    ✔ should revert if token amount is zero (49ms)
    ✔ should transfer rapid token to buyer (40ms)
    ✔ user should provide equal or more ether to buy rapid token
    ✔ should transfer wei amount if user provide more then needed
    ✔ Buy token with ether
    ✔ Do not have enough ether to buy token
    ✔ Withdraw ether from contract (43ms)
    ✔ Do not have permission to withdraw ether from contract 
(40ms)


  9 passing (4s)

```

After testing if you want to deploy the contract using the command line.

```bash

$ npx hardhat node
# Open another Terminal
$ npx hardhat run scripts/deploy.js

# result in npx hardhat node Terminal
web3_clientVersion
eth_chainId
eth_accounts
eth_chainId
eth_estimateGas
eth_gasPrice
eth_sendTransaction
  Contract deployment: <UnrecognizedContract>
  Contract address:    0x5fb...aa3
  Transaction:         0x4d8...945
  From:                0xf39...266
  Value:               0 ETH
  Gas used:            323170 of 323170
  Block #1:            0xee6...85d

eth_chainId
eth_getTransactionByHash
eth_blockNumber
eth_chainId (2)
eth_getTransactionReceipt

# result in npx hardhat run Terminal
Initial Coin Offering (ICO) contract deployed to: 0x5Fb...aa3

```
