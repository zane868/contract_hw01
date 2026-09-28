// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Test} from "forge-std/Test.sol";
import {RomanNumberUtil} from "../contracts/RomanNumberUtil.sol";

contract RomanNumberUtilTest is Test {
    RomanNumberUtil util;

    function setUp() public {
        util = new RomanNumberUtil();
    }

    // ---- IntToRoman ----

    function test_IntToRoman_ZeroReverts() public {
        vm.expectRevert(bytes("you must > 0"));
        util.IntToRoman(0);
    }

    function test_IntToRoman_One() public view {
        assertEq(util.IntToRoman(1), "I");
    }

    function test_IntToRoman_Four() public view {
        assertEq(util.IntToRoman(4), "IV");
    }

    function test_IntToRoman_Nine() public view {
        assertEq(util.IntToRoman(9), "IX");
    }

    function test_IntToRoman_58() public view {
        assertEq(util.IntToRoman(58), "LVIII");
    }

    function test_IntToRoman_1994() public view {
        assertEq(util.IntToRoman(1994), "MCMXCIV");
    }

    // ---- RomanToInt ----

    function test_RomanToInt_III() public view {
        assertEq(util.RomanToInt("III"), 3);
    }

    function test_RomanToInt_LVIII() public view {
        assertEq(util.RomanToInt("LVIII"), 58);
    }

    function test_RomanToInt_MCMXCIV() public view {
        assertEq(util.RomanToInt("MCMXCIV"), 1994);
    }

    // ---- 往返一致性（fuzz）----

    function testFuzz_RoundTrip(uint256 n) public view {
        n = bound(n, 1, 3999);
        assertEq(util.RomanToInt(util.IntToRoman(n)), n);
    }
}
