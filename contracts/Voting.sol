// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "@openzeppelin/contracts/proxy/utils/UUPSUpgradeable.sol";
import "@openzeppelin/contracts/proxy/utils/Initializable.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
contract Voting is UUPSUpgradeable, OwnableUpgradeable {
    event Voted(address indexed voter, string candidate);
    event CandidateAdded(string candidate);
    event CandidateRemoved(string candidate);

    //候选人名称
    string[] candidateNames;

    //候选人得票数
    mapping(string => uint) votesByCandidate;

    //用户投票记录
    mapping(address => bool) voteUserMapping;

    address[] voteUsers;

    constructor() {
        _disableInitializers();
    }

    function initialize(address initialOwner) public initializer {
        __Ownable_init(initialOwner);
        candidateNames.push("A1");
        candidateNames.push("A2");
        candidateNames.push("A3");
    }

    function Vote(string memory candidateName) public {
        require(candidateExists(candidateName), "candidateName not exists");
        require(!voteUserMapping[_msgSender()], "You have already voted");
        votesByCandidate[candidateName]++;
        voteUsers.push(_msgSender());
        voteUserMapping[_msgSender()] = true;
        emit Voted(_msgSender(), candidateName);
    }

    function GetVotes(string memory candidateName) public view returns (uint) {
        return votesByCandidate[candidateName];
    }

    //重置候选人所有票数
    function ResetVotes() public onlyOwner {
        //清理票数
        for (uint i = 0; i < candidateNames.length; i++) {
            votesByCandidate[candidateNames[i]] = 0;
        }
        //清理投票记录
        for (uint i = 0; i < voteUsers.length; i++) {
            delete voteUserMapping[voteUsers[i]];
        }
        delete voteUsers;
    }

    //增加候选人
    function AddCandidate(string memory _name) public onlyOwner {
        require(!candidateExists(_name), "candidateName is exists");
        require(bytes(_name).length < 10, "name is too long");
        require(bytes(_name).length > 0, "name is empty");
        candidateNames.push(_name);
        votesByCandidate[_name] = 0;
        emit CandidateAdded(_name);
    }

    //移除掉候选人
    function RemoveCandidate(string memory _name) public onlyOwner {
        require(candidateExists(_name), "candidateName not exists");

        uint removeIndex;
        bool needRemove = false;
        for (uint i = 0; i < candidateNames.length; i++) {
            if (Strings.equal(candidateNames[i], _name)) {
                removeIndex = i;
                needRemove = true;
                break;
            }
        }

        if (needRemove) {
            candidateNames[removeIndex] = candidateNames[
                candidateNames.length - 1
            ];
            candidateNames.pop();
        }
        emit CandidateRemoved(_name);
    }

    function GetAllCandidate() public view returns (string[] memory) {
        return candidateNames;
    }

    function hasVoted() public view returns (bool) {
        return voteUserMapping[_msgSender()];
    }

    function candidateExists(
        string memory candidateName
    ) public view returns (bool) {
        for (uint i = 0; i < candidateNames.length; i++) {
            if (
                keccak256(bytes(candidateNames[i])) ==
                keccak256(bytes(candidateName))
            ) {
                return true;
            }
        }
        return false;
    }
    function _authorizeUpgrade(
        address newImplementation
    ) internal override onlyOwner {}

    uint256[50] private __gap;
}
