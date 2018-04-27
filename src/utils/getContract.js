import Web3 from 'web3'
import {address, ABI} from './constants/RaffleTruffleContract'

let getContract = new Promise(function (resolve, reject) {
 let web3 = new Web3(window.web3.currentProvider)
 let raffleTruffleContract = web3.eth.contract(ABI)
 let raffleTruffleContractInstance = raffleTruffleContract.at(address)
 resolve(raffleTruffleContractInstance)
})
export default getContract