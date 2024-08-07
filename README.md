# DegenToken Smart Contract

The DegenToken is a Solidity smart contract that represents a simple ERC-20 token

## Introduction

The DegenToken smart contract is built on the Ethereum blockchain and utilizes the OpenZeppelin ERC-20 and Ownable libraries. It introduces an item-based rewards system where you can redeem swords from Westeros randomly based on your token balance.

## Features

1. **ERC-20 Token**: DegenToken is a standard ERC-20 token, supporting typical token operations such as transfer, minting, and burning.

2. **Item Rewards**: Users can participate in a roulette-style game to win swords such as Longclaw, Ice, Oathkeeper, and more.

3. **Item Tracking**: The contract tracks the redeemed sword for each user, allowing users to view their winnings.

4. **Owner Minting**: The contract owner has the exclusive ability to mint new tokens, ensuring controlled issuance.

## Getting Started

### Prerequisites

To use the DegenToken smart contract, you need:

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
        2. Load the `Degen.sol` contract file.
        3. Compile the contract.
        4. Deploy the contract on an Ethereum testnet or the mainnet.

## Usage

The contract provides the following key functions:

- `checkBalance(address account)`: Returns the token balance of the specified account.
    ```solidity
    function checkBalance(address account) public view returns (uint256) {
        return balanceOf(account);
    }
    ```

- `burn(uint256 amount)`: Allows users to burn their own tokens, reducing the total supply.
    ```solidity
    function burn(uint256 amount) public {
        _burn(_msgSender(), amount);
    }
    ```

- `mint(address to, uint256 amount)`: Allows the contract owner to mint new tokens. This function can only be called by the owner.
    ```solidity
    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }
    ```

- `transfer(address to, uint256 amount)`: Overrides the ERC-20 `transfer` function to enable token transfers between users.
    ```solidity
    function transfer(address to, uint256 amount) public virtual override returns (bool) {
        _transfer(_msgSender(), to, amount);
        return true;
    }
    ```

- `redeem(string memory swordName)`: Allows users to participate in the roulette game by spending tokens to potentially win swords.
    ```solidity
    function redeem(string memory swordName) external {
        require(swordPrices[swordName] > 0, "Sword does not exist");
        uint256 swordPrice = swordPrices[swordName];
        require(balanceOf(msg.sender) >= swordPrice, "Insufficient balance to redeem this sword");

        _burn(msg.sender, swordPrice);

        redeemedItems[msg.sender] = swordName;
    }
    ```

- `getRedeemedItem(address account)`: Retrieves the sword redeemed by a user.
    ```solidity
    function getRedeemedItem(address account) external view returns (string memory) {
        return redeemedItems[account];
    }
    ```

## Authors

Gerard Manzano  
[@Chill Code](https://www.youtube.com/channel/UCqnpVDK-Ym41W1WDvBMmN6w)

## License

This smart contract is licensed under the MIT License. You can find the full license text in the `LICENSE` file.
