# Units and Globally Available Variables - Solidity
There are special variables and functions which always exist in the global namespace and are mainly used to provide information about the blockchain or are general-use utility functions.
## Special Variables and Functions

| No. | **Status** |     **Global Variables**    | **Return Type** |
|-----|:----------:|:---------------------------:|:---------------:|
| 1   |    Done    | blockhash(uint blockNumber) | bytes32         |
| 2   |    Done    | block.basefee               | uint            |
| 3   |    Done    | block.chainid               | uint            |
| 4   |    Done    | block.coinbase              | address payable |
| 5   |    Done    | block.difficulty            | uint            |
| 6   |    Done    | block.gaslimit              | uint            |
| 7   |    Done    | block.number                | uint            |
| 8   |    Done    | block.timestamp             | uint            |
| 9   |    Done    | gasleft()                   | uint256         |
| 10  |    Done    | msg.data                    | bytes calldata  |
| 11  |    Done    | msg.sender                  | address         |
| 12  |    Done    | msg.sig                     | bytes4          |
| 13  |    Done    | msg.value                   | uint            |
| 14  |    Done    | tx.gasprice                 | uint            |
| 15  |    Done    | tx.origin                   | address         |

## ABI Encoding and Decoding Functions
| No. | **Status** |                  **Global Variables**                 | **Return Type** |
|-----|:----------:|:-----------------------------------------------------:|:---------------:|
|  16 |    Done    | abi.decode(bytes memory encodedData)                  | Any type        |
|  17 |    Done    | abi.encode                                            | bytes memory    |
|  18 |    Done    | abi.encodePacked                                      | bytes memory    |
|  19 |    Done    | abi.encodeWithSelector(bytes4 selector, ...)          | bytes memory    |
|  20 |    Done    | abi.encodeWithSignature(string memory signature, ...) | bytes memory    |
|  21 |    Done    | abi.encodeCall(function functionPointer, (...))       | bytes memory    |


## Members of Address Types 

| No. | **Status** |            **Global Variables**            |   **Return Type**  |
|-----|:----------:|:------------------------------------------:|:------------------:|
|  22 |    Done    | (address).balance                          | uint256            |
|  23 |    Done    | (address).code                             | bytes memory       |
|  24 |    Done    | (address).codehash                         | bytes32            |
|  25 |    Done    | (address payable).transfer(uint256 amount) | uint256 amount     |
|  26 |    Done    | (address payable).send(uint256 amount)     | bool               |
|  27 |    Done    | (address).call(bytes memory)               | bool, bytes memory |
|  28 |    Done    | (address).delegatecall(bytes memory)       | bool, bytes memory |
|  29 |    Done    | (address).staticcall(bytes memory)         | bool, bytes memory |

## Type Information

| No. | **Status** | **Global Variables** |
|-----|:----------:|:--------------------:|
|  30 |    Done    | type(C).name         |
|  31 |    Done    | type(C).creationCode |
|  32 |    Done    | type(C).runtimeCode  |
|  33 |    Done    | type(I).interfaceId  |
|  34 |    Done    | type(T).min          |
|  35 |    Done    | type(T).min          |

## Other

| No. | **Status** |                    **Global Variables**                    | **Return Type** |
|-----|:----------:|:----------------------------------------------------------:|:---------------:|
|  36 |   Done     | bytes.concat(...)                                          | bytes memory    |
|  37 |   Done     | string.concat(...)                                         | string memory   |
|  38 |   Done     | addmod(uint x, uint y, uint k)                             | uint            |
|  39 |   Done     | mulmod(uint x, uint y, uint k)                             | uint            |
|  40 |   Done     | keccak256(bytes memory)                                    | bytes32         |
|  40 |   Done     | sha256(bytes memory)                                       | bytes32         |
|  42 |   Done     | ripemd160(bytes memory)                                    | bytes20         |
|  43 |   Done     | ecrecover(bytes32 hash, uint8 v, <br>bytes32 r, bytes32 s) | address         |

## How can I use it?

1. Install `Hardhat` with `npm install -g hardhat`.
2. Install dependencies with `npm install`.
3. Compile code with `npx hardhat compile`.
4. Start the test suite with `npx hardhat test`

```
