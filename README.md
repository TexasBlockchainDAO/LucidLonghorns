# LucidLonghorns
NFT smart contract for Texas Blockchain @UT

To test this code for yourself, first clone the repo with

`git clone --recursive https://github.com/Beasley9/LucidLonghorns`

Once finished, unless already downloaded globally, you will need to download
openzeppelin's required contracts with

`npm install @openzeppelin/contracts`

From here, feel free to tweak the code to perform whatever task you want.

# Running on a testnet

Once the source code is downloaded, to interact with the front end, you will need to
host a website from your computer. First, in a new terminal, go to the `website` directory
and run

`sudo python3 -m http.server 80` for linux or 
`python3 -m http.server 80` for any other OS.
*Note that administrator privileges are required to start a service, like a http webserver.

Now that the website is up and running, going to your internet browser and typing `localhost`, `127.0.0.1` or your internal ip will bring you to
the basic Lucid Longhorn minting page. Before we can do anything, though, we need to deploy the contract. In this example, we will be deploying to Ropsten.

In order to deploy the contract, run 

`npx hardhat run scripts/deploy.js --network ropsten`

on an open terminal while in the `LucidLonghorns` directory.

Feel free to visit a faucet, like this one: https://faucet.ropsten.be/ to get some testnet ETH.

Congrats! Now you can mint any Lucid Longhorn you want, test the source code, and write new functions. Welcome to UT Blockchain!
