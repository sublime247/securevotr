# Voting Smart Contract

## Overview
The `Voting` smart contract allows for a simple and transparent voting system where a manager can register voters, add candidates, and control the voting process. Registered voters can cast their vote for one of the candidates, and once voting is complete, the contract allows for the election results to be displayed.

## Features
- **Register Voters**: The manager can register voters for participation.
- **Add Candidates**: The manager can add candidates to the election.
- **Cast a Vote**: Registered voters can vote for their preferred candidate.
- **End Voting**: The manager can end the voting process.
- **View Results**: Anyone can view the vote counts of candidates once the voting has ended.
- **Determine the Winner**: The contract can calculate and display the winning candidate.

---

## Contract Functions

### `registerVoter`
- **Description**: Registers a voter for the election.
- **Parameters**:
  - `_voter` (address): The address of the voter to be registered.
- **Requirements**:
  - Only the manager can call this function.
  - The voter must not already be registered.
- **Effects**: Marks the voter as registered in the `voters` mapping.
- **Returns**: None.

### `addCandidate`
- **Description**: Adds a new candidate to the election.
- **Parameters**:
  - `_name` (string): The name of the candidate.
- **Requirements**:
  - Only the manager can add candidates.
  - The voting process must not have ended.
- **Effects**:
  - Increments the `candidatesCount`.
  - Adds a new `Candidate` struct to the `candidates` mapping.
  - Emits the `CandidateAdded` event.
- **Returns**: None.

### `vote`
- **Description**: Allows a registered voter to vote for a candidate.
- **Parameters**:
  - `_candidateId` (uint): The ID of the candidate to vote for.
- **Requirements**:
  - The caller must be a registered voter.
  - The caller must not have voted before.
  - The `_candidateId` must be a valid candidate ID.
- **Effects**:
  - Marks the caller as having voted.
  - Records the candidate ID in the voter’s `vote` attribute.
  - Increments the `voteCount` for the selected candidate.
  - Emits the `Voted` event.
- **Returns**: None.

### `endVoting`
- **Description**: Ends the voting process.
- **Requirements**:
  - Only the manager can call this function.
  - The voting process must not have ended.
- **Effects**:
  - Sets the `votingEnded` flag to true.
  - Emits the `VotingEnded` event.
- **Returns**: None.

### `getCandidateVoteCount`
- **Description**: Returns the total vote count for a given candidate.
- **Parameters**:
  - `_candidateId` (uint): The ID of the candidate.
- **Requirements**:
  - The `_candidateId` must be a valid candidate ID.
- **Returns**: 
  - `uint`: The vote count of the specified candidate.

### `getWinner`
- **Description**: Returns the ID of the winning candidate.
- **Requirements**:
  - The voting process must have ended.
- **Returns**: 
  - `uint`: The ID of the candidate with the highest number of votes.

---

## Contract Variables

### `manager`
- **Type**: `address`
- **Description**: The address of the manager (contract owner) who controls the voting process.

### `candidatesCount`
- **Type**: `uint`
- **Description**: The total number of candidates in the election.

### `votingEnded`
- **Type**: `bool`
- **Description**: Indicates whether the voting process has ended.

### `voters`
- **Type**: `mapping(address => Voter)`
- **Description**: A mapping of voter addresses to their voting status and selected candidate.

### `candidates`
- **Type**: `mapping(uint => Candidate)`
- **Description**: A mapping of candidate IDs to their respective `Candidate` struct.

---

## Structs

### `Candidate`
- **Description**: Represents a candidate in the election.
- **Variables**:
  - `id` (uint): The ID of the candidate.
  - `name` (string): The name of the candidate.
  - `voteCount` (uint): The total number of votes received by the candidate.

### `Voter`
- **Description**: Represents a voter in the election.
- **Variables**:
  - `isRegistered` (bool): Indicates if the voter is registered.
  - `hasVoted` (bool): Indicates if the voter has already voted.
  - `vote` (uint): The ID of the candidate the voter has selected.

---

## Events

### `CandidateAdded`
- **Emitted When**: A new candidate is added to the election.
- **Parameters**:
  - `id` (uint): The ID of the newly added candidate.
  - `name` (string): The name of the newly added candidate.

### `Voted`
- **Emitted When**: A voter casts their vote.
- **Parameters**:
  - `voter` (address): The address of the voter.
  - `candidateId` (uint): The ID of the candidate the voter has selected.

### `VotingEnded`
- **Emitted When**: The manager ends the voting process.

---


## License
This contract is licensed under the **MIT License**.
