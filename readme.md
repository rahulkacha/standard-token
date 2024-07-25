# StandardToken Contract

## Overview

The `StandardToken` contract is a simple implementation of an ERC20-like token with minting capability. It inherits from OpenZeppelin's `Ownable` contract to ensure that only the owner can mint new tokens.

## Contract Details

### Interface: `IToken`

The `IToken` interface defines the basic functions required for a token contract:

- `transfer(address _receipient, uint256 _amount)`: Transfers `_amount` of tokens to `_receipient`.
- `totalSupply()`: Returns the total supply of tokens.
- `balanceOf(address _owner)`: Returns the balance of the specified address.

### Contract: `StandardToken`

The `StandardToken` contract implements the `IToken` interface and provides additional functionality:

#### State Variables

- `mapping(address => uint256) private _balances`: Tracks the token balance of each address.
- `uint256 private _totalSupply`: The total supply of tokens.
- `string public _name`: The name of the token.
- `string public _symbol`: The symbol of the token.

#### Constructor

```solidity
constructor() Ownable(msg.sender) {
    _totalSupply = 0;
    _name = "Ether";
    _symbol = "Xi";
}
