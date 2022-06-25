pragma solidity >=0.7.0 <0.9.0;

contract DeadManSwitch {
  address private owner;
  uint private last_active_in_block;
  address payable private backup_address = payable(0x23A97813Bbd072d9C066E439DcFb18eD02d85002);

  modifier IsContractOnwer {
    require(owner == msg.sender);
    _;
  }

  constructor() public {
    owner = msg.sender;
    last_active_in_block = block.number;
  }

  function still_alive () public IsContractOnwer {
    require(block.number - last_active_in_block <= 10);
    last_active_in_block = block.number;
  }

  function transfer_to() public payable {
    require(block.number - last_active_in_block >= 10);
    backup_address.transfer(msg.value);
  }
}