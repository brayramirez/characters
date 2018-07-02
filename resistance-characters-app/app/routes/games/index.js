import Route from '@ember/routing/route';

export default Route.extend({

  actions: {
    findGame(gameId) {
      const game = this.get("store").findRecord('game', gameId);
      this.transitionTo('games.show', game);
    }
  }

});
