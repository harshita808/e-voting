// SPDX-License-Identifier: MIT
pragma solidity ^0.8.12;

contract Election{
    //model a candidate
    struct Candidate {
        uint id;
        string name;
        uint voteCount;
    }

    //to know a particular address has votes or not
    mapping(address=>bool) public voters;

//store and fetch candidate
    mapping(uint=>Candidate) public candidates;


 // voted event
    event votedEvent(uint256 indexed _candidateId);

    constructor(){
        addCandidate("Candidate 1");
        addCandidate("Candidate 2");  
    }
    //store candidates count
    uint public noOfCandidates;
    function addCandidate(string memory _name) private{   //keeping private so that only contract can add candidates
        noOfCandidates++;
        candidates[noOfCandidates]=Candidate(noOfCandidates,_name,0);    //no of candidates will represent the id and thus used as index

    }

    // to vote for particular candidate
    function vote(uint _candidateId) public{
        //to check that voter cannot vote twice
        require(!voters[msg.sender],"you have already voted");

        //to check if voter is voting to a valid candidate
        require(_candidateId>0 && _candidateId<=noOfCandidates,"Vote for the given candidates only");
        //record that voter has voted
         voters[msg.sender]=true;

         //update candidate vote
        candidates[_candidateId].voteCount++;

         // trigger voted event
        emit votedEvent(_candidateId);
    }

    
       
    
}