import ballerina/test;
import ballerina/http;

http:Client testClient = check new ("http://localhost:8080");

@test:Config {}
function testHelloEndpoint() returns error? {
    json response = check testClient->get("/hello");
    test:assertTrue(response.message is string, "Response should have a message field");
    test:assertEquals(response.message, "Hello from WSO2-style test Ballerina service");
}

@test:Config {}
function testSumEndpointValid() returns error? {
    json response = check testClient->get("/sum?a=5&b=7");
    test:assertTrue(response.sum is int, "Response should have a sum field");
    test:assertEquals(response.sum, 12);
}

@test:Config {}
function testSumEndpointLargeNumbers() returns error? {
    json response = check testClient->get("/sum?a=100&b=200");
    test:assertEquals(response.sum, 300);
}

@test:Config {}
function testSumEndpointMissingParams() returns error? {
    json response = check testClient->get("/sum?a=5");
    map<json> resp = <map<json>>response;
    test:assertTrue(resp.hasKey("error"), "Should return error for missing param");
    test:assertEquals(resp.get("error"), "Missing query params 'a' and/or 'b'");
}

@test:Config {}
function testSumEndpointInvalidInput() returns error? {
    json response = check testClient->get("/sum?a=abc&b=7");
    map<json> resp = <map<json>>response;
    test:assertTrue(resp.hasKey("error"), "Should return error for invalid input");
    test:assertEquals(resp.get("error"), "Invalid integer values for 'a' or 'b'");
}

@test:Config {}
function testEchoEndpoint() returns error? {
    json payload = {name: "TestUser", project: "Testing"};
    json response = check testClient->post("/echo", payload);
    test:assertTrue(response.received is json, "Response should have received field");
    json received = check response.received;
    test:assertEquals(received.name, "TestUser");
    test:assertEquals(received.project, "Testing");
}
