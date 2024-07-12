// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "@openzeppelin/contracts@4.9.0/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts@4.9.0/access/Ownable.sol";

contract DegenToken is ERC20, Ownable {
    string[] private swords = [
        "Longclaw",
        "Ice",
        "Oathkeeper",
        "Widow's Wail",
        "Heartsbane",
        "Dawn",
        "Blackfyre",
        "Dark Sister",
        "Needle",
        "Lightbringer"
    ];

    mapping(string => uint256) public swordPrices;
    mapping(address => string) public redeemedItems;

    constructor() ERC20("Degen", "DGN") {
        _mint(msg.sender, 1000000 * 1 ** uint(decimals()));

        swordPrices["Longclaw"] = 100 * 1 ** uint(decimals());
        swordPrices["Ice"] = 200 * 1 ** uint(decimals());
        swordPrices["Oathkeeper"] = 150 * 1 ** uint(decimals());
        swordPrices["Widow's Wail"] = 180 * 1 ** uint(decimals());
        swordPrices["Heartsbane"] = 130 * 1 ** uint(decimals());
        swordPrices["Dawn"] = 210 * 10 ** uint(decimals());
        swordPrices["Blackfyre"] = 170 * 1 ** uint(decimals());
        swordPrices["Dark Sister"] = 160 * 1 ** uint(decimals());
        swordPrices["Needle"] = 90 * 1 ** uint(decimals());
        swordPrices["Lightbringer"] = 220 * 1 ** uint(decimals());
    }

    function checkBalance(address account) public view returns (uint256) {
        return balanceOf(account);
    }

    function burn(uint256 amount) public {
        _burn(_msgSender(), amount);
    }

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

    function transfer(address to, uint256 amount) public virtual override returns (bool) {
        _transfer(_msgSender(), to, amount);
        return true;
    }

    function redeem(string memory swordName) external {
        require(swordPrices[swordName] > 0, "Sword does not exist");
        uint256 swordPrice = swordPrices[swordName];
        require(balanceOf(msg.sender) >= swordPrice, "Insufficient balance to redeem this sword");

        _burn(msg.sender, swordPrice);

        redeemedItems[msg.sender] = swordName;
    }

    function getRedeemedItem(address account) external view returns (string memory) {
        return redeemedItems[account];
    }
}
