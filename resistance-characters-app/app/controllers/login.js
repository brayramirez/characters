import Controller from '@ember/controller';
import { inject } from '@ember/service';

export default Controller.extend({
  session: inject('session'),

  actions: {
    authenticate: function() {
      const credentials = this.getProperties('code');
      const authenticator = 'authenticator:jwt';

      this.get('session').authenticate(authenticator, credentials);
    },

    createPlayer(attributes) {
      const newPlayer = this.get('store').createRecord('player', attributes);

      newPlayer.save().then((player) => {
        const credentials = {code: player.code};
        const authenticator = 'authenticator:jwt';

        this.get('session').authenticate(authenticator, credentials);
      });
    }
  }
});
