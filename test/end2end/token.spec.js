const request = require('request');

const base_url = 'http://localhost:8888';

describe('Token', function () {
  it('should generate bearer token', function (done) {
    request.post({
      headers: { 'content-type': 'application/x-www-form-urlencoded' },
      url: base_url + '/auth/realms/master/protocol/openid-connect/token',
      body: 'grant_type=password&scope=openid&client_id=test&username=end2end&password=end2end'
    }, function (error, response, body) {
      expect(response.statusCode).toBe(200);
      expect(body).toBeDefined();
      const token = JSON.parse(body).access_token;
      expect(token).toBeDefined();
      done();
    });
  });
});
