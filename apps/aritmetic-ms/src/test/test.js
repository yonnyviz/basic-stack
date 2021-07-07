var expect  = require('chai').expect;
var request = require('request');
var http = require('http');

const port = 3000;

it('Health Endpoint', function(done) {
    request('http://localhost:' + port + "/health", function(error, response, body) {
        expect(body).to.equal("OK");
        done();
    });
});
