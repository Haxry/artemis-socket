// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract MyToken {
    string public name = "Tether";
    string public symbol = "USDT";
    uint8 public decimals = 18;
    uint256 public totalSupply = 1000000 * (10 ** uint256(decimals));

    // Mapping from address to balance
    mapping(address => uint256) public balanceOf;

    // Mapping from owner to spender to allowance
    mapping(address => mapping(address => uint256)) public allowance;

    // Events
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);
    
    // Constructor to set initial supply
    constructor() {
        //totalSupply = _initialSupply * (10 ** uint256(decimals));
        balanceOf[msg.sender] = totalSupply;
        emit Transfer(address(0), msg.sender, totalSupply);
    }

    // Transfer tokens to a specified address
    function transfer(address _to, uint256 _value) public returns (bool success) {
        balanceOf[msg.sender] -= _value;
        balanceOf[_to] += _value;
        emit Transfer(msg.sender, _to, _value);
        return true;
    }

    // Approve the passed address to spend the specified amount of tokens on behalf of msg.sender
    function approve(address _spender, uint256 _value) public returns (bool success) {
        allowance[msg.sender][_spender] = _value;
        emit Approval(msg.sender, _spender, _value);
        return true;
    }

    // Transfer tokens from one address to another
    function transferFrom(address _from, address _to, uint256 _value) public returns (bool success) {
        balanceOf[_from] -= _value;
        balanceOf[_to] += _value;
        allowance[_from][msg.sender] -= _value;
        emit Transfer(_from, _to, _value);
        return true;
    }

    // Mint new tokens and assign them to a specified address
    function mint(address _to, uint256 _value) public  {
        totalSupply += _value;
        balanceOf[_to] += _value;
        emit Transfer(address(0), _to, _value);
        
    }

    // Burn tokens from the caller's account
    function burn(uint256 _value) public  {
        balanceOf[msg.sender] -= _value;
        totalSupply -= _value;
        emit Transfer(msg.sender, address(0), _value);
        
    }
}


