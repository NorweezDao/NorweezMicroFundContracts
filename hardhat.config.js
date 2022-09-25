/**
* @type import('hardhat/config').HardhatUserConfig
*/
require('dotenv').config();
require("@nomiclabs/hardhat-ethers");
require("@nomiclabs/hardhat-etherscan");
require("@nomiclabs/hardhat-waffle");

const {MAINNET_API_URL, POLYGON_API_URL, MUMBAI_API_URL, RINKEBY_API_URL ,ROPSTEN_API_URL ,KOVAN_API_URL  ,ETHERSCAN_API_KEY, LOCALHOST } = process.env;
const PRIVATE_KEY = '';
module.exports = {
   defaultNetwork: "mumbai",
   networks: {
      localhost: {
         url: "http://localhost:8545"
      },
      hardhat: {},
      mumbai: {
         url: 'https://polygon-mumbai.infura.io/v3/e4fa10cddeaf401698a3ae52121cdd79',
         accounts: [`f00fcb3f201b2ab13e6554d1085c9e3c26060ea245ad551ef79d2d1a1f4c8901`]
      },
   },
   etherscan: {
      apiKey: ETHERSCAN_API_KEY,
    },
   solidity: {
      version: "0.8.17",
      settings: {
         optimizer: {
            enabled: true,
            runs: 200
         }
      }
   },
}
