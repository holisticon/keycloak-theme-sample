const request = require("request");

const base_url = "http://localhost:8888";

describe("Static URLs", function () {
  it("should show welcome page", function (done) {
    request.get(base_url + "/auth", function (error, response, body) {
      expect(response.statusCode).toBe(200);
      done();
    });
  });

  it("should show login page", function (done) {
    request.get(base_url + "/auth/realms/master/", function (error, response, body) {
      expect(response.statusCode).toBe(200);
      done();
    });
  });

});
