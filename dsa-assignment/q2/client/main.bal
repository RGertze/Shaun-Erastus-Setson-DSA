import ballerina/io;
import ballerina/grpc as grpc;

ReposityOfFunctionsClient ep = check new ("http://localhost:9090");

public function main() {
    io:print();
    AddFnReq addFnReq = {
        fn: {
            name: "helloWorld",
            versionNum: 1,
            lang: "python",
            fnDef: "print('hello world!')",
            keywords: ["beginner"],
            devName: "test",
            devEmail: "test@test"
        }
    };
    AddFnRes|grpc:Error addFnsRes = ep->add_new_fn(addFnReq);
    if addFnsRes is error {
        io:println("Error adding new fn: ", addFnsRes.message());
    } else {
        io:println("Success: ", addFnsRes.message);
    }

    ShowFnReq showFnReq = {
        funcName: "helloWorld",
        versionNum: 1
    };
    ShowFnRes|grpc:Error showFnRes = ep->show_fn(showFnReq);
    if showFnRes is error {
        io:println("Error retrieving fn: ", showFnRes.message());
    } else {
        io:println("Success: ", showFnRes);
    }

    DeleteFnReq delFnReq = {
        funcName: "helloWorld",
        versionNum: 1
    };
    DeleteFnRes|grpc:Error delRes = ep->delete_fn(delFnReq);
    if delRes is error {
        io:println("Error deleting fn: ", delRes.message());
    } else {
        io:println("Success: ", delRes.message);
    }
}
