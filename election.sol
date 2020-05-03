pragma solidity ^0.5.16;

contract Election {

	address internal election_owner;
	uint256 public election_EndDate;


	enum election_state{
		STARTED,CANCELLED
	}

	//
	//2-D arrays are not a thing, I forgot and we need to fix this
	//
	byte[25][] storage candidates;

	//mapping from candidate name to their number of votes
	mapping(byte[25] => uint256) private votes_byCandidate;
	//mapping that returns true if the address is registered
	mapping(address => bool) private registered_voters;
	//mapping that returns true if the address still has a vote to cast
	mapping(address => bool) private can_vote;

	election_state public STATE;

	modifier ongoing_election(){
		require(now < election_EndDate, "Sorry, the election has ended");
		_;
	}

	modifier election_ended(){
		require(now >= election_EndDate, "Sorry, the election is still ongoing");
		_;
	}

	modifier only_owner(){
		require(msg.sender==auction_owner);
		_;
	}

	modifier only_registered_voter(){
		require(registered_voters[msg.sender], "Sorry, you are not registered to vote in this election");
		_;
	}

	modifier can_still_vote(){
		require(can_vote[msg.sender], "Sorry, you have already voted. You can't vote twice");
		_;
	}

	modifier not_registered(){
		require(registered_voters[msg.sender] == false, "You are already registered");
		_;
	}

	function register() public returns (bool){}
	function vote() public returns (bool){}
	function cancel_election() external returns(bool){}

	event CancelledEvent(string message, uint256 time);

}


contract MyElection is Election {

	function () external {
	}

	constructor (uint _electionEndDate, address _owner, byte[25][] memory _candidates) public {
		election_owner = _owner;
		election_EndDate = _electionEndDate;
		STATE = election_state.STARTED;
		candidates = _candidates;
	}

	function register() public not_registered returns (bool){
		registered_voters[msg.sender] = true;
		can_vote[msg.sender] = true;

		return true;
	}

	function vote(byte[25] memory _candidate) public only_registered_voter can_still_vote returns (bool){
		votes_byCandidate[_candidate] += 1;
		can_vote[msg.sender] = false;
		
		return true;
	}

	function add_candidate(byte[25] memory _candidate) external only_owner returns(bool){
		bool already_added = false;
		for(uint i=0; i<candidates.length; i++) {
			if (_candidate == candidates[i]) {
				already_added = true;
			}
		}
		if (already_added) { return false;}
		candidates.push(_candidate);
		return true;
	}

	function get_candidates() external view returns (byte[25][]){
		return candidates;
	}

	function get_FinalVotes() external view election_ended returns (byte[25][], uint256[]){
		uint256[] memory votes = new uint256[]();
		for(uint i=0; i<candidates.length; i++) {
			votes.push(votes_byCandidate[candidates[i]]);
		}
		return (candidates, votes);
	}

	function cancel_election() external only_owner ongoing_election returns (bool){
		STATE = election_state.CANCELLED;
		election_EndDate = now;
		emit CancelledEvent("Election cancelled", now);
		return true;
	}

}
