pragma solidity >=0.5.0 <0.7.0;

contract Election {
	function () external payable {}

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
	mapping(bytes25 => uint256) internal votes_byCandidate;
	//mapping that returns true if the address is registered
	mapping(address => bool) internal registered_voters;
	//mapping that returns true if the address still has a vote to cast
	mapping(address => bool) internal can_vote;

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

	function register() public returns (bool);
	function vote(bytes25 _cadidate) public returns (bool);
	function cancel_election() external returns(bool);

	event CancelledEvent(string message, uint256 time);

}
