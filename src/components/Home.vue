<template>
  <div>
    <v-jumbotron color="primary" dark>

      <v-container fill-height>
        <v-layout align-center>
          <v-flex text-xs-center>
            <h3 class="display-3">RaffleTruffle</h3>
            <h5 class="display-1">Start your lottery in a click</h5>
            <br>
            <v-btn large color="amber darken-1" light to="/create">Create a lottery</v-btn>
          </v-flex>
        </v-layout>
      </v-container>
    </v-jumbotron>

  <section color="amber darken-1" dark>
      <v-container fill-height fluid grid-list-md>
        <v-layout fill-height align-center>
          <v-flex text-xs-center xs12 md4>
             <v-card color="blue" dark>
                <v-card-text><h3>Total Wins</h3></v-card-text>
                <v-card-text><h1>12.435 ETH</h1> <span>123.4 $</span> </v-card-text>
                <v-card-text>
                 <h3> Users can partecipate to the daily lottery and custom lotteries created by other users.
                  You just need to buy a ticket and you are in! </h3>
                </v-card-text>
             </v-card>
          </v-flex>

          <v-flex text-xs-center xs12 md4>
             <v-card color="blue" dark>
                <v-card-text><h3>Top Jackpot</h3></v-card-text>
                <v-card-text><h1>12.435 ETH</h1> <span>123.4 $</span> </v-card-text>
                <v-card-text>
                 <h3> Users can partecipate to the daily lottery and custom lotteries created by other users.
                  You just need to buy a ticket and you are in! </h3>
                </v-card-text>
             </v-card>
          </v-flex>

          <v-flex text-xs-center xs12 md4>
             <v-card color="blue" dark>
                <v-card-text><h3>Cretors Earnings</h3></v-card-text>
                <v-card-text><h2>12.435 ETH</h2> <span>123.4 $</span></v-card-text>
                <v-card-text>
                 <h3> Users can partecipate to the daily lottery and custom lotteries created by other users.
                  You just need to buy a ticket and you are in! </h3>
                </v-card-text>
             </v-card>
          </v-flex>
        </v-layout>
        
      </v-container>
  </section>


  <!-- HOUSE LOTTERIES -->
  <section color="primary" >
    <v-container fill-height fluid grid-list-md>
        <v-layout align-center row wrap>
          <v-flex text-xs-center xs12>
            <h1 style="color: white; font-size: 40px;">House Raffles</h1>
          </v-flex>
          <v-flex text-xs-center xs10 offset-xs1>
             <v-card>
               <v-card-media height="300px" src="https://proshots-2.s3.amazonaws.com/552be85de4295f63572a93d54c9ac8f4b700ad674aef2169f469edb81396f16d/640x480.jpg">
                <v-container fill-height fluid>
                    <v-layout fill-height>
                      <v-flex xs6 align-end flexbox>
                        <span class="headline white--text"><h1>Daily Jackpot!</h1></span>
                      </v-flex>
                       <v-flex xs6 align-end flexbox>
                        <span class="headline white--text"><h1>12.435 ETH</h1> <span>123.4 $</span> </span>
                      </v-flex>
                    </v-layout>
                  </v-container>
               </v-card-media>
                <v-card-text>
                  <h1> Take a ticket!</h1>
                </v-card-text>
             </v-card>
          </v-flex>
        </v-layout>   
    </v-container>
  </section>

  <!-- CREATED LOTTERIES -->
  <section color="blue">
    
    <v-container fill-height fluid grid-list-md>

        <v-layout fill-height align-center row wrap>
           <v-flex text-xs-center xs12>
            <h1 style="color: white; font-size: 40px;">Community Raffles</h1>
          </v-flex>
          <v-flex text-xs-center xs4>
             <v-card color="purple">
                <v-card-text><h3>Total Wins</h3></v-card-text>
                <v-card-text><h1>12.435 ETH</h1> <span>123.4 $</span> </v-card-text>
                <v-card-text>
                 <h3> Users can partecipate to the daily lottery and custom lotteries created by other users.
                  You just need to buy a ticket and you are in! </h3>
                </v-card-text>
             </v-card>
          </v-flex>

          <v-flex text-xs-center xs4>
             <v-card color="purple">
                <v-card-text><h3>Top Jackpot</h3></v-card-text>
                <v-card-text><h1>12.435 ETH</h1> <span>123.4 $</span> </v-card-text>
                <v-card-text>
                 <h3> Users can partecipate to the daily lottery and custom lotteries created by other users.
                  You just need to buy a ticket and you are in! </h3>
                </v-card-text>
             </v-card>
          </v-flex>

          <v-flex text-xs-center xs4>
             <v-card color="purple">
                <v-card-text><h3>Cretors Earnings</h3></v-card-text>
                <v-card-text><h2>12.435 ETH</h2> <span>123.4 $</span></v-card-text>
                <v-card-text>
                 <h3> Users can partecipate to the daily lottery and custom lotteries created by other users.
                  You just need to buy a ticket and you are in! </h3>
                </v-card-text>
             </v-card>
          </v-flex>

          <v-flex text-xs-center xs4>
             <v-card color="purple">
                <v-card-text><h3>Total Wins</h3></v-card-text>
                <v-card-text><h1>12.435 ETH</h1> <span>123.4 $</span> </v-card-text>
                <v-card-text>
                 <h3> Users can partecipate to the daily lottery and custom lotteries created by other users.
                  You just need to buy a ticket and you are in! </h3>
                </v-card-text>
             </v-card>
          </v-flex>

          <v-flex text-xs-center xs4>
             <v-card color="purple">
                <v-card-text><h3>Top Jackpot</h3></v-card-text>
                <v-card-text><h1>12.435 ETH</h1> <span>123.4 $</span> </v-card-text>
                <v-card-text>
                 <h3> Users can partecipate to the daily lottery and custom lotteries created by other users.
                  You just need to buy a ticket and you are in! </h3>
                </v-card-text>
             </v-card>
          </v-flex>

          <v-flex text-xs-center xs4>
             <v-card color="purple">
                <v-card-text><h3>Cretors Earnings</h3></v-card-text>
                <v-card-text><h2>12.435 ETH</h2> <span>123.4 $</span></v-card-text>
                <v-card-text>
                 <h3> Users can partecipate to the daily lottery and custom lotteries created by other users.
                  You just need to buy a ticket and you are in! </h3>
                </v-card-text>
             </v-card>
          </v-flex>

          

        </v-layout>
    </v-container>
  </section>




  </div>


</template>

<script>

export default {
  name: 'home',
  data () {
    return {
      
    }
  },
  computed: {
    web3() {
      return this.$store.state.web3
    }
  },
  beforeCreate: function () {
    this.$store.dispatch('registerWeb3') 
  },
  methods: {
  }
}
</script>


<style scoped>

</style>
