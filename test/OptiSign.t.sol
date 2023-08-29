// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/OptiSign.sol";

contract OptiSignTest is Test {
    OptiSign public optiSign;

    function setUp() public {
        optiSign = new OptiSign();
    }

    function testSigning() public {
        optiSign.signContent("Abc efg content");
        assertEq(optiSign.verifySignature("Abc efg content",address(this)), true);
    }
    
    function testGetSignaturesBySigner() public {
         optiSign.signContent("Abc efg content");
         optiSign.signContent("Abc efg content 2");
         optiSign.signContent("Abc efg content 3");
         optiSign.signContent("Abc efg content 4");
         
        (bytes32[] memory signatures, uint256[] memory timestamps, uint pages) = optiSign.getSignaturesByAddress(address(this), 0, 2);

        console.log(pages);

        for (uint i = 0; i < signatures.length; i++) {
            console.logBytes32(signatures[i]);
            console.log(timestamps[i]);
        }
    }

}
