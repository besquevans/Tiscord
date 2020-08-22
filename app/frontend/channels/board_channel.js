import CableReady from 'cable_ready';
import consumer from './consumer';

consumer.subscriptions.create('BoardChannel', {
  received(data) {
    console.log("received!!!!!!")
    if (data.cableReady) CableReady.perform(data.operations);
  },
});
