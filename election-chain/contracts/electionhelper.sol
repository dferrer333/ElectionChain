pragma solidity >=0.5.0 <0.7.0;

import "./election.sol";


contract MyElection is Election {
    constructor(uint256 _electionEnd, address _owner) public {
        election_owner = _owner;
        election_EndDate = now + _electionEnd * 1 hours;
        STATE = election_state.STARTED;
        candidates = [
            bytes25("Donald Trump"),
            bytes25("Joe Biden"),
            bytes25("Bernie Sanders")
        ];
    }

    function register() public not_registered returns (bool) {
        registered_voters[msg.sender] = true;
        can_vote[msg.sender] = true;

        return true;
    }

    function vote(bytes25 _candidate)
        public
        only_registered_voter
        can_still_vote
        returns (bool)
    {
        votes_byCandidate[_candidate] += 1;
        can_vote[msg.sender] = false;

        return true;
    }

    function add_candidate(bytes25 _candidate)
        public
        only_owner
        returns (bool)
    {
        bool already_added = false;
        for (uint256 i = 0; i < candidates.length; i++) {
            if (_candidate == candidates[i]) {
                already_added = true;
            }
        }
        require(!already_added, "This candidate has already been added");
        candidates.push(_candidate);
        return true;
    }

    function get_candidates() external view returns (bytes25[] memory) {
        return candidates;
    }

    function get_FinalVotes()
        external
        view
        election_ended
        returns (bytes25[] memory, uint256[] memory)
    {
        uint256[] memory votes = new uint256[](candidates.length);
        for (uint256 i = 0; i < candidates.length; i++) {
            votes[i] = votes_byCandidate[candidates[i]];
        }
        // returns both the list of candidates and the votes for each candidate in order
        return (candidates, votes);
    }

    function cancel_election()
        external
        only_owner
        ongoing_election
        returns (bool)
    {
        STATE = election_state.CANCELLED;
        election_EndDate = now;
        emit CancelledEvent("Election cancelled", now);
        return true;
    }

    function destruct_election() external only_owner returns (bool) {
        require(
            now >= election_EndDate,
            "You can't destruct the contract, The election is still going"
        );
        address payable _election_owner = address(uint160(election_owner));
        selfdestruct(_election_owner);
        return true;
    }
}
