// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Voting {
    struct Candidate {
        uint id;
        string name;
        uint voteCount;
    }
    mapping(uint => Candidate) public candidates;
    mapping(address => bool) public hasVoted;
    uint public candidatesCount;
    address public owner;

    event Voted(address indexed voter, uint indexed candidateId);

    constructor(string[] memory _candidateNames) {
        owner = msg.sender;
        for (uint i = 0; i < _candidateNames.length; i++) {
            candidatesCount++;
            candidates[candidatesCount] = Candidate(candidatesCount, _candidateNames[i], 0);
        }
    }

    function vote(uint _candidateId) external {
        require(_candidateId > 0 && _candidateId <= candidatesCount, "Invalid candidate");
        require(!hasVoted[msg.sender], "Already voted");
        hasVoted[msg.sender] = true;
        candidates[_candidateId].voteCount++;
        emit Voted(msg.sender, _candidateId);
    }

    function getAllCandidates() external view returns (Candidate[] memory) {
        Candidate[] memory items = new Candidate[](candidatesCount);
        for (uint i = 1; i <= candidatesCount; i++) {
            items[i-1] = candidates[i];
        }
        return items;
    }

    function getWinner() external view returns (string memory winnerName, uint winnerVotes) {
        uint highestVotes = 0;
        uint winnerId = 0;
        for (uint i = 1; i <= candidatesCount; i++) {
            if (candidates[i].voteCount > highestVotes) {
                highestVotes = candidates[i].voteCount;
                winnerId = i;
            }
        }
        winnerName = candidates[winnerId].name;
        winnerVotes = highestVotes;
    }
}
