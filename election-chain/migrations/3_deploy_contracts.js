const MyElection = artifacts.require("MyElection");

module.exports = function (deployer) {
  /* Deploy your contract here with the following command */
  deployer.deploy(MyElection, 1, '0x45Cb03e3d22afE32e9249fb9bFf5D4C71109275C');
};
