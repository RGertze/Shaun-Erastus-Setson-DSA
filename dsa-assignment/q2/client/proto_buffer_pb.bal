import ballerina/grpc;

public isolated client class ReposityOfFunctionsClient {
    *grpc:AbstractClientEndpoint;

    private final grpc:Client grpcClient;

    public isolated function init(string url, *grpc:ClientConfiguration config) returns grpc:Error? {
        self.grpcClient = check new (url, config);
        check self.grpcClient.initStub(self, ROOT_DESCRIPTOR, getDescriptorMap());
    }

    isolated remote function add_new_fn(AddFnReq|ContextAddFnReq req) returns (AddFnRes|grpc:Error) {
        map<string|string[]> headers = {};
        AddFnReq message;
        if (req is ContextAddFnReq) {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("ReposityOfFunctions/add_new_fn", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <AddFnRes>result;
    }

    isolated remote function add_new_fnContext(AddFnReq|ContextAddFnReq req) returns (ContextAddFnRes|grpc:Error) {
        map<string|string[]> headers = {};
        AddFnReq message;
        if (req is ContextAddFnReq) {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("ReposityOfFunctions/add_new_fn", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <AddFnRes>result, headers: respHeaders};
    }

    isolated remote function delete_fn(DeleteFnReq|ContextDeleteFnReq req) returns (DeleteFnRes|grpc:Error) {
        map<string|string[]> headers = {};
        DeleteFnReq message;
        if (req is ContextDeleteFnReq) {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("ReposityOfFunctions/delete_fn", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <DeleteFnRes>result;
    }

    isolated remote function delete_fnContext(DeleteFnReq|ContextDeleteFnReq req) returns (ContextDeleteFnRes|grpc:Error) {
        map<string|string[]> headers = {};
        DeleteFnReq message;
        if (req is ContextDeleteFnReq) {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("ReposityOfFunctions/delete_fn", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <DeleteFnRes>result, headers: respHeaders};
    }

    isolated remote function show_fn(ShowFnReq|ContextShowFnReq req) returns (ShowFnRes|grpc:Error) {
        map<string|string[]> headers = {};
        ShowFnReq message;
        if (req is ContextShowFnReq) {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("ReposityOfFunctions/show_fn", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <ShowFnRes>result;
    }

    isolated remote function show_fnContext(ShowFnReq|ContextShowFnReq req) returns (ContextShowFnRes|grpc:Error) {
        map<string|string[]> headers = {};
        ShowFnReq message;
        if (req is ContextShowFnReq) {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("ReposityOfFunctions/show_fn", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <ShowFnRes>result, headers: respHeaders};
    }

    isolated remote function add_fns() returns (Add_fnsStreamingClient|grpc:Error) {
        grpc:StreamingClient sClient = check self.grpcClient->executeClientStreaming("ReposityOfFunctions/add_fns");
        return new Add_fnsStreamingClient(sClient);
    }

    isolated remote function show_all_fns(ShowAllFnsReq|ContextShowAllFnsReq req) returns stream<ShowAllFnsRes, grpc:Error?>|grpc:Error {
        map<string|string[]> headers = {};
        ShowAllFnsReq message;
        if (req is ContextShowAllFnsReq) {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeServerStreaming("ReposityOfFunctions/show_all_fns", message, headers);
        [stream<anydata, grpc:Error?>, map<string|string[]>] [result, _] = payload;
        ShowAllFnsResStream outputStream = new ShowAllFnsResStream(result);
        return new stream<ShowAllFnsRes, grpc:Error?>(outputStream);
    }

    isolated remote function show_all_fnsContext(ShowAllFnsReq|ContextShowAllFnsReq req) returns ContextShowAllFnsResStream|grpc:Error {
        map<string|string[]> headers = {};
        ShowAllFnsReq message;
        if (req is ContextShowAllFnsReq) {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeServerStreaming("ReposityOfFunctions/show_all_fns", message, headers);
        [stream<anydata, grpc:Error?>, map<string|string[]>] [result, respHeaders] = payload;
        ShowAllFnsResStream outputStream = new ShowAllFnsResStream(result);
        return {content: new stream<ShowAllFnsRes, grpc:Error?>(outputStream), headers: respHeaders};
    }

    isolated remote function show_all_with_criteria() returns (Show_all_with_criteriaStreamingClient|grpc:Error) {
        grpc:StreamingClient sClient = check self.grpcClient->executeBidirectionalStreaming("ReposityOfFunctions/show_all_with_criteria");
        return new Show_all_with_criteriaStreamingClient(sClient);
    }
}

public client class Add_fnsStreamingClient {
    private grpc:StreamingClient sClient;

    isolated function init(grpc:StreamingClient sClient) {
        self.sClient = sClient;
    }

    isolated remote function sendAddFnsReq(AddFnsReq message) returns grpc:Error? {
        return self.sClient->send(message);
    }

    isolated remote function sendContextAddFnsReq(ContextAddFnsReq message) returns grpc:Error? {
        return self.sClient->send(message);
    }

    isolated remote function receiveAddFnsRes() returns AddFnsRes|grpc:Error? {
        var response = check self.sClient->receive();
        if response is () {
            return response;
        } else {
            [anydata, map<string|string[]>] [payload, headers] = response;
            return <AddFnsRes>payload;
        }
    }

    isolated remote function receiveContextAddFnsRes() returns ContextAddFnsRes|grpc:Error? {
        var response = check self.sClient->receive();
        if response is () {
            return response;
        } else {
            [anydata, map<string|string[]>] [payload, headers] = response;
            return {content: <AddFnsRes>payload, headers: headers};
        }
    }

    isolated remote function sendError(grpc:Error response) returns grpc:Error? {
        return self.sClient->sendError(response);
    }

    isolated remote function complete() returns grpc:Error? {
        return self.sClient->complete();
    }
}

public class ShowAllFnsResStream {
    private stream<anydata, grpc:Error?> anydataStream;

    public isolated function init(stream<anydata, grpc:Error?> anydataStream) {
        self.anydataStream = anydataStream;
    }

    public isolated function next() returns record {|ShowAllFnsRes value;|}|grpc:Error? {
        var streamValue = self.anydataStream.next();
        if (streamValue is ()) {
            return streamValue;
        } else if (streamValue is grpc:Error) {
            return streamValue;
        } else {
            record {|ShowAllFnsRes value;|} nextRecord = {value: <ShowAllFnsRes>streamValue.value};
            return nextRecord;
        }
    }

    public isolated function close() returns grpc:Error? {
        return self.anydataStream.close();
    }
}

public client class Show_all_with_criteriaStreamingClient {
    private grpc:StreamingClient sClient;

    isolated function init(grpc:StreamingClient sClient) {
        self.sClient = sClient;
    }

    isolated remote function sendShowAllWithCritReq(ShowAllWithCritReq message) returns grpc:Error? {
        return self.sClient->send(message);
    }

    isolated remote function sendContextShowAllWithCritReq(ContextShowAllWithCritReq message) returns grpc:Error? {
        return self.sClient->send(message);
    }

    isolated remote function receiveShowAllWithCritRes() returns ShowAllWithCritRes|grpc:Error? {
        var response = check self.sClient->receive();
        if response is () {
            return response;
        } else {
            [anydata, map<string|string[]>] [payload, headers] = response;
            return <ShowAllWithCritRes>payload;
        }
    }

    isolated remote function receiveContextShowAllWithCritRes() returns ContextShowAllWithCritRes|grpc:Error? {
        var response = check self.sClient->receive();
        if response is () {
            return response;
        } else {
            [anydata, map<string|string[]>] [payload, headers] = response;
            return {content: <ShowAllWithCritRes>payload, headers: headers};
        }
    }

    isolated remote function sendError(grpc:Error response) returns grpc:Error? {
        return self.sClient->sendError(response);
    }

    isolated remote function complete() returns grpc:Error? {
        return self.sClient->complete();
    }
}

public client class ReposityOfFunctionsAddFnResCaller {
    private grpc:Caller caller;

    public isolated function init(grpc:Caller caller) {
        self.caller = caller;
    }

    public isolated function getId() returns int {
        return self.caller.getId();
    }

    isolated remote function sendAddFnRes(AddFnRes response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendContextAddFnRes(ContextAddFnRes response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendError(grpc:Error response) returns grpc:Error? {
        return self.caller->sendError(response);
    }

    isolated remote function complete() returns grpc:Error? {
        return self.caller->complete();
    }

    public isolated function isCancelled() returns boolean {
        return self.caller.isCancelled();
    }
}

public client class ReposityOfFunctionsAddFnsResCaller {
    private grpc:Caller caller;

    public isolated function init(grpc:Caller caller) {
        self.caller = caller;
    }

    public isolated function getId() returns int {
        return self.caller.getId();
    }

    isolated remote function sendAddFnsRes(AddFnsRes response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendContextAddFnsRes(ContextAddFnsRes response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendError(grpc:Error response) returns grpc:Error? {
        return self.caller->sendError(response);
    }

    isolated remote function complete() returns grpc:Error? {
        return self.caller->complete();
    }

    public isolated function isCancelled() returns boolean {
        return self.caller.isCancelled();
    }
}

public client class ReposityOfFunctionsShowAllWithCritResCaller {
    private grpc:Caller caller;

    public isolated function init(grpc:Caller caller) {
        self.caller = caller;
    }

    public isolated function getId() returns int {
        return self.caller.getId();
    }

    isolated remote function sendShowAllWithCritRes(ShowAllWithCritRes response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendContextShowAllWithCritRes(ContextShowAllWithCritRes response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendError(grpc:Error response) returns grpc:Error? {
        return self.caller->sendError(response);
    }

    isolated remote function complete() returns grpc:Error? {
        return self.caller->complete();
    }

    public isolated function isCancelled() returns boolean {
        return self.caller.isCancelled();
    }
}

public client class ReposityOfFunctionsShowFnResCaller {
    private grpc:Caller caller;

    public isolated function init(grpc:Caller caller) {
        self.caller = caller;
    }

    public isolated function getId() returns int {
        return self.caller.getId();
    }

    isolated remote function sendShowFnRes(ShowFnRes response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendContextShowFnRes(ContextShowFnRes response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendError(grpc:Error response) returns grpc:Error? {
        return self.caller->sendError(response);
    }

    isolated remote function complete() returns grpc:Error? {
        return self.caller->complete();
    }

    public isolated function isCancelled() returns boolean {
        return self.caller.isCancelled();
    }
}

public client class ReposityOfFunctionsDeleteFnResCaller {
    private grpc:Caller caller;

    public isolated function init(grpc:Caller caller) {
        self.caller = caller;
    }

    public isolated function getId() returns int {
        return self.caller.getId();
    }

    isolated remote function sendDeleteFnRes(DeleteFnRes response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendContextDeleteFnRes(ContextDeleteFnRes response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendError(grpc:Error response) returns grpc:Error? {
        return self.caller->sendError(response);
    }

    isolated remote function complete() returns grpc:Error? {
        return self.caller->complete();
    }

    public isolated function isCancelled() returns boolean {
        return self.caller.isCancelled();
    }
}

public client class ReposityOfFunctionsShowAllFnsResCaller {
    private grpc:Caller caller;

    public isolated function init(grpc:Caller caller) {
        self.caller = caller;
    }

    public isolated function getId() returns int {
        return self.caller.getId();
    }

    isolated remote function sendShowAllFnsRes(ShowAllFnsRes response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendContextShowAllFnsRes(ContextShowAllFnsRes response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendError(grpc:Error response) returns grpc:Error? {
        return self.caller->sendError(response);
    }

    isolated remote function complete() returns grpc:Error? {
        return self.caller->complete();
    }

    public isolated function isCancelled() returns boolean {
        return self.caller.isCancelled();
    }
}

public type ContextShowAllFnsResStream record {|
    stream<ShowAllFnsRes, error?> content;
    map<string|string[]> headers;
|};

public type ContextShowAllWithCritReqStream record {|
    stream<ShowAllWithCritReq, error?> content;
    map<string|string[]> headers;
|};

public type ContextShowAllWithCritResStream record {|
    stream<ShowAllWithCritRes, error?> content;
    map<string|string[]> headers;
|};

public type ContextAddFnsReqStream record {|
    stream<AddFnsReq, error?> content;
    map<string|string[]> headers;
|};

public type ContextDeleteFnReq record {|
    DeleteFnReq content;
    map<string|string[]> headers;
|};

public type ContextShowAllFnsRes record {|
    ShowAllFnsRes content;
    map<string|string[]> headers;
|};

public type ContextDeleteFnRes record {|
    DeleteFnRes content;
    map<string|string[]> headers;
|};

public type ContextShowFnReq record {|
    ShowFnReq content;
    map<string|string[]> headers;
|};

public type ContextShowFnRes record {|
    ShowFnRes content;
    map<string|string[]> headers;
|};

public type ContextAddFnReq record {|
    AddFnReq content;
    map<string|string[]> headers;
|};

public type ContextAddFnRes record {|
    AddFnRes content;
    map<string|string[]> headers;
|};

public type ContextShowAllWithCritReq record {|
    ShowAllWithCritReq content;
    map<string|string[]> headers;
|};

public type ContextAddFnsRes record {|
    AddFnsRes content;
    map<string|string[]> headers;
|};

public type ContextShowAllFnsReq record {|
    ShowAllFnsReq content;
    map<string|string[]> headers;
|};

public type ContextShowAllWithCritRes record {|
    ShowAllWithCritRes content;
    map<string|string[]> headers;
|};

public type ContextAddFnsReq record {|
    AddFnsReq content;
    map<string|string[]> headers;
|};

public type DeleteFnReq record {|
    string funcName = "";
    int versionNum = 0;
|};

public type ShowFnReq record {|
    string funcName = "";
    int versionNum = 0;
|};

public type DeleteFnRes record {|
    string message = "";
|};

public type ShowFnRes record {|
    Fn fn = {};
|};

public type Fn record {|
    string name = "";
    int versionNum = 0;
    string lang = "";
    string[] keywords = [];
    string devName = "";
    string devEmail = "";
    string fnDef = "";
|};

public type ShowAllWithCritReq record {|
    string lang = "";
    string[] keywords = [];
|};

public type AddFnsRes record {|
    string[] funcNames = [];
|};

public type ShowAllWithCritRes record {|
    Fn[] fns = [];
|};

public type AddFnsReq record {|
    Fn fn = {};
|};

public type ShowAllFnsRes record {|
    Fn fn = {};
|};

public type AddFnReq record {|
    Fn fn = {};
|};

public type AddFnRes record {|
    string message = "";
|};

public type ShowAllFnsReq record {|
    string funcName = "";
|};

const string ROOT_DESCRIPTOR = "0A1270726F746F5F6275666665722E70726F746F22B4010A02466E12120A046E616D6518012001280952046E616D65121E0A0A76657273696F6E4E756D180220012805520A76657273696F6E4E756D12120A046C616E6718032001280952046C616E67121A0A086B6579776F72647318042003280952086B6579776F72647312180A076465764E616D6518052001280952076465764E616D65121A0A08646576456D61696C1806200128095208646576456D61696C12140A05666E4465661807200128095205666E446566221F0A08416464466E52657112130A02666E18012001280B32032E466E5202666E22200A09416464466E7352657112130A02666E18012001280B32032E466E5202666E22490A0B44656C657465466E526571121A0A0866756E634E616D65180120012809520866756E634E616D65121E0A0A76657273696F6E4E756D180220012805520A76657273696F6E4E756D22470A0953686F77466E526571121A0A0866756E634E616D65180120012809520866756E634E616D65121E0A0A76657273696F6E4E756D180220012805520A76657273696F6E4E756D222B0A0D53686F77416C6C466E73526571121A0A0866756E634E616D65180120012809520866756E634E616D6522440A1253686F77416C6C576974684372697452657112120A046C616E6718012001280952046C616E67121A0A086B6579776F72647318022003280952086B6579776F72647322240A08416464466E52657312180A076D65737361676518012001280952076D65737361676522290A09416464466E73526573121C0A0966756E634E616D6573180120032809520966756E634E616D657322270A0B44656C657465466E52657312180A076D65737361676518012001280952076D65737361676522200A0953686F77466E52657312130A02666E18012001280B32032E466E5202666E22240A0D53686F77416C6C466E7352657312130A02666E18012001280B32032E466E5202666E222B0A1253686F77416C6C576974684372697452657312150A03666E7318012003280B32032E466E5203666E7332A4020A135265706F736974794F6646756E6374696F6E7312220A0A6164645F6E65775F666E12092E416464466E5265711A092E416464466E52657312230A076164645F666E73120A2E416464466E735265711A0A2E416464466E73526573280112270A0964656C6574655F666E120C2E44656C657465466E5265711A0C2E44656C657465466E52657312210A0773686F775F666E120A2E53686F77466E5265711A0A2E53686F77466E52657312300A0C73686F775F616C6C5F666E73120E2E53686F77416C6C466E735265711A0E2E53686F77416C6C466E73526573300112460A1673686F775F616C6C5F776974685F637269746572696112132E53686F77416C6C57697468437269745265711A132E53686F77416C6C576974684372697452657328013001620670726F746F33";

isolated function getDescriptorMap() returns map<string> {
    return {"proto_buffer.proto": "0A1270726F746F5F6275666665722E70726F746F22B4010A02466E12120A046E616D6518012001280952046E616D65121E0A0A76657273696F6E4E756D180220012805520A76657273696F6E4E756D12120A046C616E6718032001280952046C616E67121A0A086B6579776F72647318042003280952086B6579776F72647312180A076465764E616D6518052001280952076465764E616D65121A0A08646576456D61696C1806200128095208646576456D61696C12140A05666E4465661807200128095205666E446566221F0A08416464466E52657112130A02666E18012001280B32032E466E5202666E22200A09416464466E7352657112130A02666E18012001280B32032E466E5202666E22490A0B44656C657465466E526571121A0A0866756E634E616D65180120012809520866756E634E616D65121E0A0A76657273696F6E4E756D180220012805520A76657273696F6E4E756D22470A0953686F77466E526571121A0A0866756E634E616D65180120012809520866756E634E616D65121E0A0A76657273696F6E4E756D180220012805520A76657273696F6E4E756D222B0A0D53686F77416C6C466E73526571121A0A0866756E634E616D65180120012809520866756E634E616D6522440A1253686F77416C6C576974684372697452657112120A046C616E6718012001280952046C616E67121A0A086B6579776F72647318022003280952086B6579776F72647322240A08416464466E52657312180A076D65737361676518012001280952076D65737361676522290A09416464466E73526573121C0A0966756E634E616D6573180120032809520966756E634E616D657322270A0B44656C657465466E52657312180A076D65737361676518012001280952076D65737361676522200A0953686F77466E52657312130A02666E18012001280B32032E466E5202666E22240A0D53686F77416C6C466E7352657312130A02666E18012001280B32032E466E5202666E222B0A1253686F77416C6C576974684372697452657312150A03666E7318012003280B32032E466E5203666E7332A4020A135265706F736974794F6646756E6374696F6E7312220A0A6164645F6E65775F666E12092E416464466E5265711A092E416464466E52657312230A076164645F666E73120A2E416464466E735265711A0A2E416464466E73526573280112270A0964656C6574655F666E120C2E44656C657465466E5265711A0C2E44656C657465466E52657312210A0773686F775F666E120A2E53686F77466E5265711A0A2E53686F77466E52657312300A0C73686F775F616C6C5F666E73120E2E53686F77416C6C466E735265711A0E2E53686F77416C6C466E73526573300112460A1673686F775F616C6C5F776974685F637269746572696112132E53686F77416C6C57697468437269745265711A132E53686F77416C6C576974684372697452657328013001620670726F746F33"};
}

