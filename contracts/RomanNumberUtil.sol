// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {console2} from "forge-std/console2.sol";

contract RomanNumberUtil {
    mapping(string => uint) romanIntMapping;

    mapping(bytes1 => uint) romanIntMappingForBytes;
    mapping(uint => string) intRoamMapping;

    uint[] values = [1000, 900, 500, 400, 100, 90, 50, 40, 10, 9, 5, 4, 1];

    constructor() {
        intRoamMapping[1000] = "M";
        intRoamMapping[900] = "CM";
        intRoamMapping[500] = "D";
        intRoamMapping[400] = "CD";
        intRoamMapping[100] = "C";

        intRoamMapping[90] = "XC";
        intRoamMapping[50] = "L";
        intRoamMapping[40] = "XL";
        intRoamMapping[10] = "X";

        intRoamMapping[9] = "IX";
        intRoamMapping[5] = "V";
        intRoamMapping[4] = "IV";

        intRoamMapping[1] = "I";

        romanIntMapping["I"] = 1;
        romanIntMapping["V"] = 5;
        romanIntMapping["X"] = 10;
        romanIntMapping["L"] = 50;
        romanIntMapping["C"] = 100;
        romanIntMapping["D"] = 500;
        romanIntMapping["M"] = 1000;

        romanIntMappingForBytes[bytes1("I")] = 1;
        romanIntMappingForBytes[bytes1("V")] = 5;
        romanIntMappingForBytes[bytes1("X")] = 10;
        romanIntMappingForBytes[bytes1("L")] = 50;
        romanIntMappingForBytes[bytes1("C")] = 100;
        romanIntMappingForBytes[bytes1("D")] = 500;
        romanIntMappingForBytes[bytes1("M")] = 1000;
    }

    function RomanToInt(string memory _input) public view returns (uint) {
        uint total = 0;
        bytes memory chars = bytes(_input);
        console2.log("input", _input);
        for (uint i = 0; i < chars.length;) {
            uint currentVal = romanIntMappingForBytes[chars[i]];

            if (i + 1 < chars.length) {
                uint nextVal = romanIntMappingForBytes[chars[i + 1]];

                if (currentVal < nextVal) {
                    total += nextVal - currentVal;
                    i += 2;
                    continue; // 两个字符已处理，进入下一轮
                }
            }

            total += currentVal;
            i += 1;
        }
        return total;
    }

    // 转成罗马数字
    function IntToRoman(uint _num) public view returns (string memory) {
        require(_num > 0, "you must > 0");
        string memory result = "";
        for (uint i = 0; i < values.length; i++) {
            uint val = values[i];
            while (_num >= val) {
                result = string.concat(result, intRoamMapping[val]);
                _num -= val;
            }
        }
        return result;
    }
}
