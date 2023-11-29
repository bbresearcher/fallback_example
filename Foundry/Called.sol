// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;
import "forge-std/console2.sol";


contract Called {

    function sendMeMoney() external payable{
        console2.log("I just received : %s",msg.value);
    }
    function returnToSender() external payable {
        payable(address(msg.sender)).call{value: address(this).balance}("");
        
        }
}