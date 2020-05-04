const electionhelper = artifacts.require("./electionhelper.sol");

module.exports = function (deployer) {
  /* Deploy your contract here with the following command */
  deployer.deploy(electionhelper);
};
