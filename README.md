# DegenToken Smart Contract

The DegenToken is a Solidity smart contract that represents a simple ERC-20 token with additional functionality for a roulette-style item rewards system. This README provides an overview of the contract and instructions on how to use it.

## Introduction

The DegenToken smart contract is built on the Ethereum blockchain and utilizes the OpenZeppelin ERC-20 and Ownable libraries. It introduces an item-based rewards system where users can "spin" a roulette to win various items based on their token balance.

## Features

1. **ERC-20 Token**: DegenToken is a standard ERC-20 token, supporting typical token operations such as transfer, minting, and burning.

2. **Item Rewards**: Users can participate in a roulette-style game to win items such as Toy Cars, Board Games, Laptops, Tablets, and Cameras.

3. **Item Quantities**: The contract tracks the quantities of each item won by a user, allowing users to view their winnings.

4. **Owner Minting**: The contract owner has the exclusive ability to mint new tokens, ensuring controlled issuance.

## Getting Started

### Prerequisites

To use the DegenToken smart contract, you need:

- An Ethereum development environment such as Truffle or Hardhat, or a testnet like Ropsten or Rinkeby.
- A web3-compatible browser or wallet (e.g., MetaMask) to interact with the deployed contract.

### Installation

1. Clone the repository:
    ```sh
    git clone https://github.com/your-repo/degen-token.git
    cd degen-token
    ```

2. Compile and deploy the contract using a Solidity development environment or a tool like Remix:
    - **Using Remix**:
        1. Open [Remix](https://remix.ethereum.org/).
        2. Load the `DegenToken.sol` contract file.
        3. Compile the contract.
        4. Deploy the contract on an Ethereum testnet or the mainnet.

## Usage

The contract provides the following key functions:

- `mint(uint256 amount)`: Allows the contract owner to mint new tokens. This function can only be called by the owner.
    ```solidity
    function mint(uint256 amount) public onlyOwner {
        _mint(msg.sender, amount);
    }
    ```

- `burn(uint256 amount)`: Allows users to burn their own tokens, reducing the total supply.
    ```solidity
    function burn(uint256 amount) public {
        _burn(msg.sender, amount);
    }
    ```

- `transfer(address to, uint256 amount)`: Overrides the ERC-20 `transfer` function to enable token transfers between users.
    ```solidity
    function transfer(address to, uint256 amount) public override returns (bool) {
        return super.transfer(to, amount);
    }
    ```

- `spinRoulette()`: Allows users to participate in the roulette game by spending 500 tokens to potentially win items.
    ```solidity
    function spinRoulette() public {
        require(balanceOf(msg.sender) >= 500, "Not enough tokens to spin the roulette");
        _burn(msg.sender, 500);
        uint256 reward = _randomReward();
        _addItemToInventory(msg.sender, reward);
    }
    ```

- `getInventory(address user)`: Retrieves the items and their quantities owned by a user.
    ```solidity
    function getInventory(address user) public view returns (Item[] memory) {
        return userInventories[user];
    }
    ```

## Authors

Gerard Manzano  
[@Chill Code](https://www.youtube.com/channel/UCqnpVDK-Ym41W1WDvBMmN6w)

## License

This smart contract is licensed under the MIT License. You can find the full license text in the `LICENSE` file.
