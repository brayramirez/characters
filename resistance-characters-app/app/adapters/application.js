import DS from 'ember-data';
import TokenAuthorizerMixin from 'ember-simple-auth-token/mixins/token-authorizer';
import { computed } from '@ember/object';

export default DS.RESTAdapter.extend(TokenAuthorizerMixin, {
  host: 'http://192.168.56.101:3000',
  namespace: 'api/v1',
  headers: computed(() => {
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    }
  })
});
