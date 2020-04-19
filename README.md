# ElectionChain
A basic implementation of a Primary Election process using a React.js frontend and an Ethereum backend.  This app will have a voting phase, in which qualified voters can submit a vote for a candidate, and an analysis phase, in which anyone can view statistics and results of the election.

A big focus of this project will be the various security issues that need to be considered, as well as the logic and flow of the election itself.

## Problems to Consider:
- How will the state ensure that only qualified voters are participating?
  - Maybe an array of hashes could be stored in the contract, in which those hashes were created using personally identifiable information of qualified voters.
- What will the authentication process look like, how will the state ensure that the person voting is who they say they are?
  - We need to use multi-factor authentication through the front end to ensure this.
- Would the voter need to be on a Virtual Private Network, administered by the government to ensure network and browser security?
- How should the hyperlink to the application be securely distributed and verified?  How will phishing and fake voting systems be avoided?

## React.js Frontend
We will be building the frontend application for the voters using React.js.  There will be two phases for the voting process:

#### Phase 1: Voting Functionality
- When the Voting Phase is active, the app will show the voting screen, in which the voter must verify their identity and input their vote at the same time.
- Maybe the front end should have a list of which hashes have voted (not who they voted for, just voted or not voted), so that people trying to double vote get denied at the front end level, not the contract level

#### Phase 2: Post-voting Analysis
- When the Analysis Phase is active, the app will show a graph of some sort (a bar char?) of how many votes were given to each candidate, and which candidate won the election.

## Ethereum Solidity Backend
The backend election logic will be build using Solidity, most likely on the Rinkeby Ethereum Test Network.  The functionality of the backend is as follows:

- store a list of the voters hashes and their associated votes.
- a mechanism to verify that an incoming vote transaction is valid:
  - the voter's authenticity is valid.
  - the voter has not already voted.
- a mechanism to either end the voting process after a given time, or end it when all voters have voted.
