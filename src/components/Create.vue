<template>
  <section>

    <v-stepper v-model="step" v-if="loader == false">
      <v-stepper-header>
        <v-stepper-step step="1" :complete="step > 1">Basic info</v-stepper-step>
        <v-divider></v-divider>
        <v-stepper-step step="2" :complete="step > 2">Ticket Price</v-stepper-step>
        <v-divider></v-divider>
        <v-stepper-step step="3">Duration</v-stepper-step>
      </v-stepper-header>

      <v-stepper-items>

        <v-stepper-content step="1">
          <v-form v-model="forms.basic" lazy-validation>
             <p>Give a nice name and if you want describe what you'll do with the funds</p>
            <v-text-field label="Lottery Name" v-model="newLottery.name" :counter="10" required></v-text-field>
            <v-text-field label="Lottery Description" textarea light></v-text-field>
          </v-form>
          
          <div>
            <v-btn large right color="primary" @click.native="step = 2" :disabled="!forms.basic">Continue</v-btn>
          </div>
        </v-stepper-content>

        <v-stepper-content step="2">
          <v-form v-model="forms.basic" lazy-validation>
             <v-slider color="orange" label="Max ticket number" min="2" :max="Math.pow(2,256) - 1" thumb-label v-model="newLottery.maxTickets"></v-slider>
             <v-text-field label="Ticket Price" suffix="ETH" v-model.number="newLottery.ticketPrice"></v-text-field>
             <v-text-field label="Lottery Entry Price" suffix="ETH" v-model.number="lotteryPrice" disabled></v-text-field>
             <v-text-field label="Create Rate" suffix="%" v-model.number="creatorRate" disabled></v-text-field>
               
              <h3>If there will be more than {{ticketNumber}} ticket you will cover all the cost and earn {{creatorRate}}% for every new ticket (and you could win the lottery)</h3>
            
          </v-form>
          <v-btn color="primary" @click.native="step = 3" large>Continue</v-btn>
        </v-stepper-content>

        <v-stepper-content step="3">
          <p>Choose the duration of the lottery, from 1 day to 100 days</p>
           <v-slider color="orange" label="Duration" min="1" max="100" thumb-label v-model="newLottery.duration"></v-slider>
           <h3>Your lottery will last {{newLottery.duration}} day</h3>
          <v-btn color="primary" @click.native="createLottery" large>Create lottery!</v-btn>
        </v-stepper-content>
      </v-stepper-items>
    </v-stepper>

    <div v-else>
       <v-progress-circular indeterminate :size="70" :width="7" color="primary"></v-progress-circular>
    </div>

    <!--
    <div class='metamask-info'>
      <p>Metamask: {{ web3.isInjected }}</p>
      <p>Network: {{ web3.networkId }}</p>
      <p>Account: {{ web3.coinbase }}</p>
      <p>Balance: {{ web3.balance }}</p>
    </div>
    -->
          
  </section>
</template>

<script>

  export default {
    name: 'create',
    data () {
      return {
        step: 0,
        forms: {
          basic: false,
          price: false,
          duration: false
        },
        newLottery: {
          name: null,
          description: null,
          ticketPrice: 0.002,
          duration: 1,
          maxTickets: 2
        },
        lotteryPrice: 0.003,
        creatorRate: 5,
        loader: false,
        newLotteryEvent: null
      }
    },
    computed: {
      web3() {
        return this.$store.state.web3
      },
      ticketNumber() { 
        //calculate the number of tickets needed to earn
        let creatorCost = this.newLottery.ticketPrice + this.lotteryPrice
        return ((creatorCost * (100/this.creatorRate) - this.lotteryPrice) / this.newLottery.ticketPrice) - 1
      }
    },
    beforeCreate: function () {
      
    },
    methods: {
      createLottery() {
        this.loader = true
        // SOLIDITY FUNCTION: createLottery(string name, uint ticketPrice, uint maxTickets, uint duration) 
        this.$store.contractInstance().createLottery(this.newLottery.name, this.newLottery.ticketPrice, this.newLOttery.maxTickets, this.newLottery.duration, {
          gas: 300000,
          value: this.$store.state.web3.web3Instance().toWei(this.newLottery.ticketPrice + this.lotteryPrice, 'ether'),
          from: this.$store.state.web3.coinbase
        }, (err, result) => {
          if (err) {
            console.log(err)
            this.loader = false
          } else {
            // SOLIDITY EVENT: event NewLottery(uint lotteryId, string name);
            let CreatedLottery = this.$store.state.contractInstance().NewLottery()
            CreatedLottery.watch((err, result) => {
              if(err){
                console.log("could not get event NewLottery()")
              }else{
                this.newLotteryEvent = result.args
                this.loader = false
              }
            })

          }
        })
      }
    }
  }
</script>

<style lang="scss" scoped>

</style>
