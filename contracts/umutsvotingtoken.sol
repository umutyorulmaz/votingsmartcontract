// SPDX-License-Identifier: MIT

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
//import "hardhat/console.sol";

pragma solidity ^0.8.17;

contract umutsElection is ERC20 {
    struct Candidate {
        string title;
        uint voteCount;
    }
    struct Voter {
        uint voteIndex;
    }

    address public owner;
    string public title;
    mapping(address => Voter) public voters;
    Candidate[] public candidates;
    uint public electionEnd;

    constructor() ERC20("ElectionToken", "ET") {
        owner = msg.sender;
        _mint(owner, 1000000000000000000);
    }

    event electionResult(string title, uint voteCount);

    function election(
        string memory _name,
        uint durationMinutes,
        string memory candidate1,
        string memory candidate2,
        string memory candidate3,
        string memory candidate4,
        string memory candidate5
    ) public {
        owner = msg.sender;
        title = _name;
        electionEnd = block.timestamp + (durationMinutes * 1 minutes);

        candidates.push(Candidate(candidate1, 0));
        candidates.push(Candidate(candidate2, 0));
        candidates.push(Candidate(candidate3, 0));
        candidates.push(Candidate(candidate4, 0));
        candidates.push(Candidate(candidate5, 0));
    }

    modifier qualifiedVoter(address _voter) {
        uint balance = this.balanceOf(_voter);
        require(balance > 0, "Insufficient funds");
        _;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this function");
        _;
    }

    function vote(uint voteIndex) public qualifiedVoter(msg.sender) {
        require(block.timestamp < electionEnd);
        voters[msg.sender].voteIndex = voteIndex;
        transfer(address(this), 1);
    }

    function end() public {
        require(msg.sender == owner);
        require(block.timestamp >= electionEnd);
        for (uint i = 0; i < candidates.length; i++) {
            emit electionResult(candidates[i].title, candidates[i].voteCount);
        }
    }
}
