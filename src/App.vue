<template>
  <v-app>

    <v-navigation-drawer fixed v-model="drawer" app>
      <v-list dense>
        <v-subheader>Running Raffles</v-subheader>
        <v-list-tile @click="">
          <v-list-tile-action>
            <v-icon>home</v-icon>
          </v-list-tile-action>
          <v-list-tile-content>
            <v-list-tile-title>SuperLottery</v-list-tile-title>
          </v-list-tile-content>
          <v-list-tile-action>
            <v-icon v-if="uprising" color="green">arrow_drop_up</v-icon>
            <v-icon v-else color="red">arrow_drop_down</v-icon>
          </v-list-tile-action>
        </v-list-tile>
      </v-list>
    </v-navigation-drawer>

      <v-toolbar app>
        <v-toolbar-side-icon @click.stop="drawer = !drawer"></v-toolbar-side-icon>
        <v-spacer></v-spacer>
        <v-toolbar-title>RaffleTruffle</v-toolbar-title>
        <v-spacer></v-spacer>
        <v-btn v-if="web3.isInjected" color="green">
          Metamask connected
        </v-btn>
        <v-btn v-else color="red">
          Metamask disconnected
        </v-btn>

      </v-toolbar>
      
      <v-content app>
        <section centered align-center >

        

          <!-- navigation -->
          <v-layout>
            <v-flex xs12>

              <v-tabs icons-and-text centered dark color="blue">
                
                  <v-tab href="#tab-play" to="/home">
                    Play <v-icon>local_play</v-icon>
                  </v-tab>
                  <v-tab href="#tab-create" to="/create">
                    Create <v-icon>stars</v-icon>
                  </v-tab>
                  <v-tab href="#tab-wall">
                    Winners <v-icon>mood</v-icon>
                  </v-tab>
                  <v-tab href="#tab-guide">
                    Guide <v-icon>help_outline</v-icon>
                  </v-tab>

              </v-tabs>

              <router-view></router-view>

            </v-flex>
          </v-layout>
        
        </section>
      </v-content>

      <v-footer>2018 - RaffleTruffle</v-footer>

  </v-app>
</template>

<script>
export default {
  name: 'app',
  data() {
    return {
      drawer: null,
      uprising: true //to change
    }
  },
  computed: {
    web3() {
      return this.$store.state.web3
    }
  },
  mounted() {
    console.log("dispatch getContractInstance")
    this.$store.dispatch('getContractInstance')
  }
}
</script>

<style>
</style>
