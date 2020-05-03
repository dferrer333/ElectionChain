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
	bytes25[] public candidates;

	//mapping from candidate name to their number of votes
	mapping(bytes25 => uint256) public votes_byCandidate;
	//mapping that returns true if the address is registered
	mapping(address => bool) public registered_voters;
	//mapping that returns true if the address still has a vote to cast
	mapping(address => bool) public can_vote;

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
		require(msg.sender == election_owner);
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
	function vote(bytes25 _cadidate) public returns (bool){}
	function cancel_election() external returns(bool){}

	event CancelledEvent(string message, uint256 time);

}


contract MyElection is Election {

	function () external {
	}

	constructor (uint _electionEnd, address _owner) public {
		election_owner = _owner;
		election_EndDate = now + _electionEnd * 1 hours;
		STATE = election_state.STARTED;
		candidates = [bytes25("Donald Trump"), bytes25("Joe Biden"), bytes25("Bernie Sanders")];
	}

	function register() public not_registered returns (bool){
		registered_voters[msg.sender] = true;
		can_vote[msg.sender] = true;

		return true;
	}

	function vote(bytes25 _candidate) public only_registered_voter can_still_vote returns (bool){
		votes_byCandidate[_candidate] += 1;
		can_vote[msg.sender] = false;
		
		return true;
	}

	function add_candidate(bytes25 _candidate) public only_owner returns(bool){
		bool already_added = false;
		for(uint i=0; i<candidates.length; i++) {
			if (_candidate == candidates[i]) {
				already_added = true;
			}
		}
		require(!already_added, "This candidate has already been added");
		candidates.push(_candidate);
		return true;
	}

	function get_candidates() external view returns (bytes25[] memory){
		return candidates;
	}

	function get_FinalVotes() external view election_ended returns (bytes25[] memory, uint256[] memory){
		uint256[] memory votes = new uint256[](candidates.length);
		for(uint i=0; i<candidates.length; i++) {
			votes[i] = votes_byCandidate[candidates[i]];
		}
		// returns both the list of candidates and the votes for each candidate in order
		return (candidates, votes);
	}

	function cancel_election() external only_owner ongoing_election returns (bool){
		STATE = election_state.CANCELLED;
		election_EndDate = now;
		emit CancelledEvent("Election cancelled", now);
		return true;
	}
	
	function destruct_election() external only_owner returns (bool){
	    require(now >= election_EndDate, "You can't destruct the contract, The election is still going");
	    address payable _election_owner = address(uint160(election_owner));
	    selfdestruct(_election_owner);
	    return true;
	}

}
