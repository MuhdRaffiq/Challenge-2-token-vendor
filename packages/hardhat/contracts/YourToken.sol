pragma solidity >=0.6.0 <0.9.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

// learn more: https://docs.openzeppelin.com/contracts/3.x/erc20

contract YourToken is ERC20 {
    //ToDo: add constructor and mint tokens for deployer,
    //you can use the above import for ERC20.sol. Read the docs ^^^

    constructor() public ERC20("Raffiq", "RAF") {
        uint256 initialSupply = 1000 * (10**18);
        _mint(msg.sender, initialSupply);
    }
}
