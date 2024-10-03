// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Voting {
    struct Candidate {
        uint id;
        string name;
        uint voteCount;
    }

    struct Voter {
        bool isRegistered;
        bool hasVoted;
        uint vote;
    }

    address public manager;
    uint public candidatesCount;
    bool public votingEnded = false;

    mapping(address => Voter) public voters;
    mapping(uint => Candidate) public candidates;

    event CandidateAdded(uint id, string name);
    event Voted(address voter, uint candidateId);
    event VotingEnded();

    modifier onlyManager() {
        require(msg.sender == manager, "Only manager can perform this action");
        _;
    }

    modifier votingActive() {
        require(!votingEnded, "Voting has ended");
        _;
    }

    constructor() {
        manager = msg.sender;
    }

    // Register a voter
    function registerVoter(address _voter) public onlyManager {
        require(!voters[_voter].isRegistered, "Voter is already registered");
        voters[_voter].isRegistered = true;
    }

    // Add a candidate
    function addCandidate(string memory _name) public onlyManager votingActive {
        candidatesCount++;
        candidates[candidatesCount] = Candidate(candidatesCount, _name, 0);
        emit CandidateAdded(candidatesCount, _name);
    }

    // Cast a vote for a candidate
    function vote(uint _candidateId) public votingActive {
        require(voters[msg.sender].isRegistered, "You must be a registered voter to vote");
        require(!voters[msg.sender].hasVoted, "You have already voted");
        require(_candidateId > 0 && _candidateId <= candidatesCount, "Invalid candidate ID");

        voters[msg.sender].hasVoted = true;
        voters[msg.sender].vote = _candidateId;

        candidates[_candidateId].voteCount++;
        emit Voted(msg.sender, _candidateId);
    }

    // End the voting process
    function endVoting() public onlyManager votingActive {
        votingEnded = true;
        emit VotingEnded();
    }

    // View a candidate's vote count
    function getCandidateVoteCount(uint _candidateId) public view returns (uint) {
        require(_candidateId > 0 && _candidateId <= candidatesCount, "Invalid candidate ID");
        return candidates[_candidateId].voteCount;
    }

    // Get the winning candidate ID
    function getWinner() public view returns (uint) {
        require(votingEnded, "Voting is still ongoing");
        
        uint winningCandidateId;
        uint highestVoteCount = 0;

        for (uint i = 1; i <= candidatesCount; i++) {
            if (candidates[i].voteCount > highestVoteCount) {
                highestVoteCount = candidates[i].voteCount;
                winningCandidateId = i;
            }
        }
        return winningCandidateId;
    }
}
