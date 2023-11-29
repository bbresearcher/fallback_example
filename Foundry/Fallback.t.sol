// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console2} from "forge-std/Test.sol";
import "../src/Caller.sol";
import "../src/Called.sol";
import "../src/CallerWithRevert.sol";

contract FallbackTest is Test {
    Caller public caller;
    Called public called;
    CallerWithRevert public callerWithRevert;
    function setUp() public {
       called = new Called(); 
        
    }

    function test_NoFallback() public {
        caller = new Caller{value: 1 ether}(address(called));
        assertEq(address(caller).balance,1 ether);
    }

    function test_FallbackWithRevert() public {
        callerWithRevert = new CallerWithRevert{value: 1 ether}(address(called));
        assertEq(address(callerWithRevert).balance,1 ether);
    }

    function test_FallbackSecondCall() public {
        called.sendMeMoney{value: 1 ether}();
        callerWithRevert = new CallerWithRevert(address(called));
        assertEq(address(callerWithRevert).balance,1 ether);
    }

}
