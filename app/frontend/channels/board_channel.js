// import CableReady from 'cable_ready';
import consumer from './consumer';

consumer.subscriptions.create({channel: "BoardChannel", board_id: 1}, {
  connected() {
    console.log("connected...")
  },
  received(data) {
    console.log("received!!!!!!")
    console.log(data)
    // if (data.cableReady) CableReady.perform(data.operations);
  },
});
