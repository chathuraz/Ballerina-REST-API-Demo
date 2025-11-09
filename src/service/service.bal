import ballerina/http;

listener http:Listener httpListener = new(8080);

service / on httpListener {
    resource function get hello(http:Request req) returns json {
        return {message: "Hello from WSO2-style test Ballerina service"};
    }

    resource function get sum(http:Caller caller, http:Request req) returns error? {
        string? a = req.getQueryParamValue("a");
        string? b = req.getQueryParamValue("b");
        if a is string && b is string {
            int|error ai = int:fromString(a);
            int|error bi = int:fromString(b);
            if ai is int && bi is int {
                json response = {sum: ai + bi};
                check caller->respond(response);
            } else {
                json errResponse = {"error": "Invalid integer values for 'a' or 'b'"};
                check caller->respond(errResponse);
            }
        } else {
            json errResponse = {"error": "Missing query params 'a' and/or 'b'"};
            check caller->respond(errResponse);
        }
    }

    // A simple POST echo that returns the received JSON
    resource function post echo(http:Caller caller, http:Request req) returns error? {
        json|error payload = req.getJsonPayload();
        if payload is json {
            check caller->respond({received: payload});
        } else {
            http:Response res = new;
            res.statusCode = 400;
            res.setPayload("Expected JSON payload");
            check caller->respond(res);
        }
    }
}
