<template>
  <div id="chat">
    <div id="messages">

    </div>
    <v-form @submit.prevent="sendMessage">
      <v-text-field v-model="message" placeholder="Type message..."/>
      <v-btn type="submit">Отправить</v-btn>
    </v-form>
  </div>
</template>

<script>
import ChatMessageComponent from "~/components/chat-message-component";
export default {
  name: "chat-component",
  data() {
    return {
      message: ''
    }
  },
  mounted() {
    this.$echo.channel('global.chat')
      .listen('ChatMessageEvent', (e) => {
        this.addMessage(e);
      });
  },
  methods: {
    sendMessage(){
      if(!this.message){
        return;
      }
      this.$axios.$post('/api/chat', {message: this.message})
      .then(r => {
        this.message = '';
      })
      .catch(e => console.log(e.response));
    },
    addMessage(event){
      console.log(event);
      const instance = new ChatMessageComponent({
        propsData:{
          userName: event.user.name,
          time: event.time,
          message: event.message
        }
      }).$mount();
      document.getElementById('messages').appendChild(instance.$el);
    }
  }
}
</script>

<style scoped>

</style>
