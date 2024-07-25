// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.2 <0.9.0;

import "@openzeppelin/contracts/access/Ownable.sol";

/// @title StandardToken
/// @author Rahul Kacha
/// @notice A simple implementation of a standard token with minting capability.
/// @dev Implements the IToken interface and uses OpenZeppelin's Ownable contract.
interface IToken {
    /// @notice Transfers `_amount` of tokens to `_receipient`.
    /// @param _receipient The address to receive the tokens.
    /// @param _amount The amount of tokens to transfer.
    /// @return Returns true if the transfer was successful.
    function transfer(address _receipient, uint256 _amount)
        external
        returns (bool);

    /// @notice Returns the total supply of tokens.
    /// @return The total supply of tokens.
    function totalSupply() external returns (uint256);

    /// @notice Returns the balance of the specified address.
    /// @param _owner The address to query the balance of.
    /// @return The balance of the specified address.
    function balanceOf(address _owner) external returns (uint256);
}

contract StandardToken is IToken, Ownable {
    mapping(address => uint256) private _balances;
    uint256 private _totalSupply;
    string public _name;
    string public _symbol;

    /// @notice Constructor that initializes the token with name and symbol.
    /// @dev The initial supply is set to zero and can be minted using the mint function.
    constructor() Ownable(msg.sender) {
        _totalSupply = 0;
        _name = "Ether";
        _symbol = "Xi";
    }

    /// @notice Modifier that checks if the sender's balance is at least `amount`.
    /// @param amount The minimum amount required in the sender's balance.
    modifier at_least(uint256 amount) {
        require(_balances[msg.sender] >= amount, "Insufficient balance.");
        _;
    }

    /// @notice Mints new tokens and adds them to the total supply and the owner's balance.
    /// @param _supply The amount of tokens to mint.
    function mint(uint256 _supply) external onlyOwner {
        _totalSupply += _supply;
        _balances[msg.sender] += _supply;
    }

    /// @notice Returns the total supply of tokens.
    /// @return The total supply of tokens.
    function totalSupply() external view returns (uint256) {
        return _totalSupply;
    }

    /// @notice Returns the balance of the specified address.
    /// @param _owner The address to query the balance of.
    /// @return The balance of the specified address.
    function balanceOf(address _owner) external view returns (uint256) {
        return _balances[_owner];
    }

    /// @notice Transfers tokens from the sender's account to `_receipient`.
    /// @dev Requires that the sender's balance is at least `_amount` tokens.
    /// @param _receipient The address to receive the tokens.
    /// @param _amount The amount of tokens to transfer.
    /// @return Returns true if the transfer is successful.
    function transfer(address _receipient, uint256 _amount)
        external
        at_least(_amount)
        returns (bool)
    {
        _balances[msg.sender] -= _amount;
        _balances[_receipient] += _amount;
        return true;
    }
}