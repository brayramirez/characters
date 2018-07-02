import DS from 'ember-data';

export default DS.Model.extend({
  adapter: 'application',
  name: DS.attr(),
  code: DS.attr()
});
