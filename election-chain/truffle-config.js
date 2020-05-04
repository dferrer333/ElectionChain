const HDWalletProvider = require("truffle-hdwallet-provider");
const mnemonic =
  "coil example stomach square case famous medal addict course ice buffalo curve";

module.exports = {
  migrations_directory: "./migrations",
  networks: {
    development: {
      host: "localhost",
      port: 8545,
      network_id: "*", // Match any network id
    },
    rinkeby: {
      provider: function () {
        return new HDWalletProvider(
          mnemonic,
          " https://rinkeby.infura.io/v3/4f043234a7754f3ab9adaab98ff64181"
        );
      },
      network_id: 4,
    },
  },
};
