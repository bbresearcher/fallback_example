// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;
import "forge-std/console2.sol";
import "src/Called.sol";

contract Caller {
    constructor(address _called) payable public{
        Called(_called).returnToSender{value: msg.value}();
    }

}
