import Component from '@ember/component';
import EmberObject from '@ember/object';

export default Component.extend({

  playerAttributes: EmberObject.create({
    name: ''
  }),

  actions: {
    save() {
      this.sendAction(
        'onSave',
        this.get('playerAttributes').getProperties('name')
      );
    }
  }

});
