

# 🧰 contracts
Deployed sample NFT contract can be viewed on [rinkeby.etherscan.io/address/](https://rinkeby.etherscan.io/address/#code)

## Prerequisites
1. Have access to the public (public wallet address) and private key to your Ethereum account.
2. Have an alchemy account set-up (the free one works!)
3. Have an etherscan account.

## Dependencies
Hardhat
```zsh
yarn add hardhat
```

Dotenv
```zsh
yarn add dotenv
```

Ethers.js
```zsh
yarn add @nomiclabs/hardhat-ethers ethers@^5.0.0
```
OpenZeppelin
```zsh
yarn add @openzeppelin/contracts
```
Alchemy Web3
```zsh
yarn add @alch/alchemy-web3
```
Hardhat-etherscan (to verify your contract)
```
yarn add @nomiclabs/hardhat-etherscan
```

## Steps to Deploy
1. Make a copy of `.sample-env` and fill it out
    ```
    cp .sample-env .env
    ```
    You should fill out at least the following fields: `RINKEBY_API_URL`, `ETHERSCAN_API_KEY`, `PRIVATE_KEY` and `PUBLIC_KEY`.

    The `CONTRACT_ADDRESS` field will be filled out after you deploy your smart contract!
2. Make any modifications the smart contract in `./contract` and deploy script in `./script/deploy.js`
3. Compile the contract
    ```
    npx hardhat compile
    ```
4. Edit the deploy script.

    Modify `scripts/deploy.js` to include the specific deploy arguments that you want your ERC721 contract to be deployed with.
5. Deploy the contract
    ```
    npx hardhat run scripts/deploy.js --network rinkeby
    ```

You should see a confirmation in your terminal like this:
```zsh
Compiling 1 file with 0.8.0
Compilation finished successfully
Contract deployed to address: 0x...
```

Check out your newly deployed contract on etherscan.
```
https://mumbai.polygonscan.com/address/0xa55f52461c265e9d838a37a2c886b16431b55661 Projects
https://mumbai.polygonscan.com/address/0xa5388013E0782862EC2134fE2f9DC5621B3699e2 Contrib
```

You should update your `.env`'s `CONTRACT_ADDRESS` to be your newly deployed contract address.

If you changed the name of your NFT contract, make sure you update the paths in your scripts [`contracts/scripts`](/contracts/scripts).

## Verify Your Contract
Verifying your contract is important for building trust. For transparency to your users, you should always verify your smart contracts so users can easily inspect the contracts they are interacting with.


Run the following command with your `DEPLOYED_CONTRACT_ADDRESS`, the network where it's deployed, and the constructor arguments that were used to deploy it.
```
npx hardhat verify --network mainnet DEPLOYED_CONTRACT_ADDRESS "Constructor argument 1"
```
Read this [tutorial](https://hardhat.org/plugins/nomiclabs-hardhat-etherscan.html) for more info.


https://mumbai.polygonscan.com/address/0x6d087c0c63255c37cd2a2af9e5b784830886bb0a
