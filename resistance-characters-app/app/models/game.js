import DS from 'ember-data';

export default DS.Model.extend({
  name: DS.attr('string'),
  code: DS.attr('string'),
  status: DS.attr('string'),
  commander: DS.attr('boolean'),
  false_commander: DS.attr('boolean'),
  bodyguard: DS.attr('boolean'),
  blind_spy: DS.attr('boolean'),
  deep_cover: DS.attr('boolean'),
  host: DS.belongsTo('player')
});
