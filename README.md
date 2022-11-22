# Initial Coin Offering (ICO) contract

Tutorial using Hardhat(Buidler) to complie, deploy and automated unit tests Solidity smart contract.  
you use this repository as Initial Coin Offering (ICO) contract template or ERC20 template.   
To run these tutorials, you must have the following installed:

- [nodejs](https://nodejs.org/en/)

- [npm](https://github.com/nvm-sh/nvm)

```bash
$ npm install
```

to compile your smart contract to get an ABI and artifact of a smart contract.

```bash
$ npx hardhat compile
```

for a unit testing smart contract using the command line.

```
$ npx hardhat test
```
expecting `icoTest.js` result.
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

after testing if you want to deploy the contract using the command line.

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
