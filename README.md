# RaffleTruffle
[UNDER DEVELOPMENT]

A decentralized game built with Vue and Solidity!

Create your own lottery and partecipate to other users lotteries using the power of the bockchain! Check the [live](http://raffletruffle.com) running on Ropsten Network! - Make sure to have [Metamask] installed and connected the Ropesten Network
RaffleTruffle is a midterm project for Siraj Raval's blockcahin course on [theschool.ai](https://theschool.ai) 

### Game description
RaffleTruffle is more than a raffle. You can earn in different ways:
  - Win a lottery by purchasing a ticket
  - Invite your friends to partecipate to a lottery (you will earn 1% of the ticket that has been purchased)
  - Create your own lottery and earn a percentage of the final jackpot
  - Terminate a lottery. The RaffleTruffle smart contract doesn't contain time callbacks from Oracles. When a lottery has run out of time, the function that will select the winner ticket is triggered by the first person who call that function (who is called the _Terminator_). The _terminator_ will earn 1% of the jackpot by making a transaction


### Building Tools!

  - Truffle
  - Ganache
  - Nodejs
  - Oraclize API
  

### Installation
RaffleTruffle requires [Node.js](https://nodejs.org/) v5+ to run.

Install [Truffle](http://truffleframework.com/docs/getting_started/installation) and [Ganache](http://truffleframework.com/ganache/).
Install the dependencies and start the server.

```sh
 npm install
 npm run dev
```




