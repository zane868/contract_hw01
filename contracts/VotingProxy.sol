// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {ERC1967Proxy} from "@openzeppelin/contracts/proxy/ERC1967/ERC1967Proxy.sol";

/// @notice Voting 的 UUPS 代理合约。行为与 ERC1967Proxy 完全一致，
/// 只是作为一等源码放在 contracts/ 下以便 Hardhat 产出可部署的 artifact。
contract VotingProxy is ERC1967Proxy {
    constructor(
        address implementation,
        bytes memory data
    ) ERC1967Proxy(implementation, data) {}
}
