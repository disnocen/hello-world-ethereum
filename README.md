# One-click Ethereum Hello world

Objective: to create a script that gives the possibility of:

+ start a (local) blockchain
+ deploy a smart contract
+ interact with a smart contract

The intention is to give the person who approaches the enormous and
non-intuitive complexity of Ethereum for the first time the possibility of
knowing what it is. 

**With this repository you won't need to waste hours on bad Medium posts without understanding what's going on.**

In particular I have tried to use the most lightweight tools among all the
tools available. This is another key difference between this repository and
the average internet post.

The steps to reproduce this repository (other than simply cloning it):

+ `truffle init`: Creates all the directories and files needed to start a new
  smart contract or set of smart contracts
+ uncommented the development network details in `truffle-config.js`
+ copy the `contracts-copy/simple-storage.sol` in `contracts/SimpleStorage.sol`
+ follow the script `run.sh`

## Interact with the smart contract

The  the `run` function of the `run.sh` script automatically copies the ABI of
the SimpleStorage contract. Then to interact withe smart contract you need his
ABI and the address of the smart contract. After you get it (from the
ganache-cli output) you:

1. In the `geth` console write:
```
> SimpleStorageABI=
```
and then paste the ABI and press Enter

2. In the `geth` console write the smart contract address from the `ganache-cli` output:
```
> SimpleStorageAddress="put_the_smart_contract_addresss_here"
```

3. Press Enter and then do this command:
```
> SimpleStorageContract=eth.contract(SimpleStorageABI).at(SimpleStorageAddres)
```

The contract has two functions:

+ `set()`: sets a number in the storage (this requires eth)
+ `get()`: reads from the blockchain the value (this is free)

You can use the `set` function of the smart contract in the `geth` console and
put the number 10 by doing:
```
> SimpleStorageContract.set(10, {from: eth.account[0]})
```

You can use the `get` function of the smart contract in the `geth` console
```
> SimpleStorageContract.get()
```
which should return `10`

## Conclusions

There you have it: you created a local blockchain, deployed a Smart contract
and interacted with it

## Notes
Filenames are bad: you should never start a file with a capital letter. Also,
the convention of using `_` instead of spaces is inconvenient. It is much
better to use `-`. I preferred to keep the convention anyway.
