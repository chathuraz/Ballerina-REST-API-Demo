import ballerina/http;
import ballerina/io;

public function main() returns error? {
    http:Client httpClient = check new ("http://localhost:8080");

    // Call GET /hello
    json helloResp = check httpClient->get("/hello");
    io:println("GET /hello -> ", helloResp.toJsonString());

    // Call GET /sum?a=5&b=7
    json sumResp = check httpClient->get("/sum?a=5&b=7");
    io:println("GET /sum?a=5&b=7 -> ", sumResp.toJsonString());

    // Call POST /echo with a sample JSON
    json sample = {name: "Test", project: "WSO2-style"};
    json echoResp = check httpClient->post("/echo", sample);
    io:println("POST /echo -> ", echoResp.toJsonString());
}
