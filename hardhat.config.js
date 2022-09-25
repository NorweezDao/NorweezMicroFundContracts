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
      hardhat: {},
      mumbai: {
         url: 'https://polygon-mumbai.infura.io/v3/e4fa10cddeaf401698a3ae52121cdd79',
         accounts: [`0x406daf084ae582b75ba5293d2b796093090196d5ddefb9437a497b1b01858237`]
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
