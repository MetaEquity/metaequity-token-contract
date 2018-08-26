pragma solidity ^0.4.23;

//
// Standard ERC20 token with the ability to freeze and unfreeze token transfer
import '../common/token/ERC20/PausableToken.sol';

// Standard ERC20 token with the ability to burn tokens
import '../common/token/ERC20/BurnableToken.sol';

// Standard ERC20 token with the ability to mint tokens
import '../common/token/ERC20/MintableToken.sol';

// //
// // Blocks ERC223 tokens and allows the smart contract to transfer ownership of
// // ERC20 tokens that are sent to the contract address.
// import '../common/ownership/HasNoTokens.sol';

// //
// // Gives the owner the ability to transfer ownership of the contract to a new
// // address and it requires the owner of the new address to accept the transfer.
// import '../common/ownership/Claimable.sol';

/**
 * @title MetaCoinToken
 */
 contract MetaCoinToken is PausableToken, MintableToken, BurnableToken {

  string public constant name = "Meta Coin";
  string public constant symbol = "META"; 
  uint8 public constant decimals = 18;
  
  
  /**
   * @dev Constructor
   */
  constructor() public {
    balances[msg.sender] = 0;

    emit Transfer(0x0, msg.sender, 0);
  }
 
  function approveAndCall(address spender, uint _value, bytes data) public returns (bool success) {
    approve(spender, _value);
    ApproveAndCallFallBack(spender).receiveApproval(msg.sender, _value, address(this), data);
    return true;
  }

  event SpendMetaCoinEvent(address _contractAddressToSpend, uint _noOfCreditsToSpend, uint _operationID, uint256 _input1, uint256 _input2, uint256 _input3, string _input4);

  function spendMetaCoin(address _contractAddressToSpend, uint _noOfCoinsToSpend, uint _operationID, uint256 _input1, uint256 _input2, uint256 _input3, string _input4) public returns (bool success) {
    approve(_contractAddressToSpend, _noOfCoinsToSpend);
 
    emit SpendMetaCoinEvent(_contractAddressToSpend, _noOfCoinsToSpend, _operationID, _input1, _input2, _input3, _input4);
    MetaCoinTokenFallback(_contractAddressToSpend).receiveCoins(msg.sender, _noOfCoinsToSpend, address(this), _operationID, _input1, _input2, _input3, _input4);
    return true;
  }
}

//passing bytes
contract ApproveAndCallFallBack {
    function receiveApproval(address from, uint256 tokens, address token, bytes data) public;
}

//spend MetaCoin tokens
contract MetaCoinTokenFallback {
    function receiveCoins(address from, uint256 noOfCoinsToSpend, address metaCoinTokenAddress, uint operationID, uint256 input1, uint256 input2, uint256 input3, string input4) public;
}