import Component from '@ember/component';
// import { inject as service } from '@ember/service';

export default Component.extend({

  // store: service('store'),
  // router: service('router'),
  gameId: null,

  actions: {
    findGame() {
      if (!this.gameId) return;

      console.log('gameId: ', this.gameId);

      // const game = this.store.findRecord('game', this.gameId);
      // this.router.transitionTo('games.show', game);
      this.sendAction(
        'onFindGame',
        this.gameId
      );
    }
  }

});
