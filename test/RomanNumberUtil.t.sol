// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Test} from "forge-std/Test.sol";
import {RomanNumberUtil} from "../contracts/RomanNumberUtil.sol";
import {console2} from "forge-std/console2.sol";
import {Strings} from "@openzeppelin/contracts/utils/Strings.sol";
contract RomanNumberUtilTest is Test {
    RomanNumberUtil util;

    // 每个测试执行前，部署一个新的合约实例。
    function setUp() public {
        util = new RomanNumberUtil();
    }

    function test_IntToRoman_RevertsForZero() public {
        for (uint i = 1; i <= 3999; i++) {
            string memory romanResult = util.IntToRoman(i);
            uint intResult = util.RomanToInt(romanResult);
            string memory result = string.concat(
                Strings.toString(i),
                "=>",
                romanResult,
                "=>",
                Strings.toString(intResult)
            );
            console2.log(result);
        }
    }

    // 完成转换逻辑后，可按下面的格式添加测试：
    // function test_IntToRoman_One() public view {
    //     assertEq(util.IntToRoman(1), "I");
    // }
}
