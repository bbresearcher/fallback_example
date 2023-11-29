// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "./Called.sol";
import "hardhat/console.sol";
contract CallerWithRevert {
    constructor(address _called) payable public{
        Called(_called).returnToSender{value: msg.value}();
    }

    /*fallback() external {
        console.log("YOU CALLED ME???");
        revert("YOU MAY NOT CALL ME!!!!");
        
    }*/

    fallback(bytes calldata inbytes) external returns(bytes memory outbytes){
        console.log("YOU CALLED ME???");
        revert("YOU MAY NOT CALL ME!!!!");
        
    }
}