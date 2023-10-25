// hardhat.config.js
require("dotenv").config();

require("@nomiclabs/hardhat-ethers");
require("@nomiclabs/hardhat-etherscan");
/**
 * @type import('hardhat/config').HardhatUserConfig
 */
module.exports = {
  networks: {
    testnet: {
      url: `https://data-seed-prebsc-1-s1.binance.org:8545`,
      accounts: [process.env.MNEMONIC],
    },
    mainnet: {
      url: `https://bsc-dataseed.binance.org/`,
      accounts: [process.env.MNEMONIC],
    },
  },

  etherscan: {
    // Your API key for Etherscan
    // Obtain one at https://bscscan.com/
    apiKey: process.env.BSCSCAN_API_KEY,
  },
  solidity: "0.8.10",
};
