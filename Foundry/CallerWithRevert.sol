// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;
import "forge-std/console2.sol";
import "src/Called.sol";

contract CallerWithRevert {

    address owner;
    constructor(address _called) payable public{
        owner = msg.sender;
        Called(_called).returnToSender{value: msg.value}();
    }

    fallback() external {
        console2.log("YOU CALLED ME???");
        revert("YOU MAY NOT CALL ME!!!!");
        
    }

    /*fallback(bytes calldata inbytes) external returns(bytes memory outbytes){
        console2.log("YOU CALLED ME???");
        revert("YOU MAY NOT CALL ME!!!!");
        
    }*/

    function randomCall() external {
        require(msg.sender == owner, "Not Owner");
        console2.log("Caller was owner");
    }
}