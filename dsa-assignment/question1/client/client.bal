import ballerina/http;

# dsa
#
# + clientEp - Connector http endpoint
public client class Client {
    http:Client clientEp;
    public isolated function init(http:ClientConfiguration clientConfig = {}, string serviceUrl = "http://localhost:8080/studentManagment") returns error? {
        http:Client httpEp = check new (serviceUrl, clientConfig);
        self.clientEp = httpEp;
    }
    #
    # + return - successfully added user
    remote isolated function add(LearnerProf payload) returns ResObject|error {
        string path = string `/user/add`;
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        request.setPayload(jsonBody);
        ResObject response = check self.clientEp->post(path, request, targetType = ResObject);
        return response;
    }
    #
    # + return - successfully updated learner
    remote isolated function update(LearnerProf payload) returns ResObject|error {
        string path = string `/user/update`;
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        request.setPayload(jsonBody);
        ResObject response = check self.clientEp->post(path, request, targetType = ResObject);
        return response;
    }
}
