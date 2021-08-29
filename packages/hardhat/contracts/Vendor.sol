pragma solidity >=0.6.0 <0.9.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "./YourToken.sol";

contract Vendor is Ownable {
    YourToken yourToken;

    constructor(address tokenAddress) public {
        yourToken = YourToken(tokenAddress);
    }

    modifier checkBalance(uint256 balance) {
        require(balance > 0, "balance ETH must be more than 0");
        _;
    }

    modifier checkTokenBalance(address addressToken) {
        require(
            yourToken.balanceOf(addressToken) > 0,
            "balance token must be more than 0"
        );
        _;
    }

    modifier checkAmountIn(uint256 amountIn) {
        require(amountIn > 0, "amount in input must be greater than 0");
        _;
    }

    uint256 public constant tokensPerEth = 100;

    event BuyTokens(address buyer, uint256 amountOfETH, uint256 amountOfTokens);

    //ToDo: create a payable buyTokens() function:
    function buyTokens()
        public
        payable
        checkBalance(msg.sender.balance)
        checkTokenBalance(address(this))
    {
        address buyer = msg.sender;
        uint256 amountOfETH = msg.value;
        uint256 amountOfTokens = amountOfETH * tokensPerEth;
        require(amountOfETH > 0);

        yourToken.transfer(buyer, amountOfTokens);
        emit BuyTokens(buyer, amountOfETH, amountOfTokens);
    }

    //ToDo: create a sellTokens() function:
    function sellTokens(uint256 tokenSell)
        public
        checkTokenBalance(msg.sender)
        checkBalance(address(this).balance)
        returns (bool)
    {
        uint256 allowance = yourToken.allowance(msg.sender, address(this));
        require(allowance > tokenSell, "need to approve higher token number");
        address payable seller = msg.sender;
        uint256 amountETH = tokenSell / tokensPerEth;
        yourToken.transferFrom(msg.sender, address(this), tokenSell);

        seller.transfer(amountETH);

        return true;
    }

    //ToDo: create a withdraw() function that lets the owner, you can
    //use the Ownable.sol import above:
    function withdraw(uint256 amountToWithdraw)
        public
        onlyOwner
        checkBalance(address(this).balance)
    {
        address payable recipient = msg.sender;
        recipient.transfer(amountToWithdraw);
    }
}
