

# Sample Hardhat Project

This project demonstrates a basic Hardhat use case. It comes with a sample contract, a test for that contract, and a script that deploys that contract.

Try running some of the following tasks:

```shell
npx hardhat help
npx hardhat test
REPORT_GAS=true npx hardhat test
npx hardhat node
npx hardhat run scripts/deploy.js
```
Code explanation : 

Voting smart contract;
 Users can vote more than one time as long as they have sufficient tokens (balance).
 Voting is open for a set of time.
 Owner of the contract can end and start voting. 
