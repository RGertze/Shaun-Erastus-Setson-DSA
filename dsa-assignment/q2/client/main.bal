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

    AddFnsReq[] addFnsReq = [
        { // should succeed
        fn: {
            devEmail: "test@test",
            keywords: ["testing", "test"],
            versionNum: 1,
            name: "test1",
            lang: "test1",
            devName: "test1",
            fnDef: "test1"
        }
    }, 
        { // should fail
        fn: {
            devEmail: "test@test",
            keywords: ["testing", "test"],
            versionNum: 1,
            name: "test1",
            lang: "test1",
            devName: "test1",
            fnDef: "test1"
        }
    }, 
        { // should succeed
        fn: {
            devEmail: "test@test",
            keywords: ["testing", "test"],
            versionNum: 1,
            name: "test2",
            lang: "test2",
            devName: "test2",
            fnDef: "test2"
        }
    }
    ];
    Add_fnsStreamingClient|grpc:Error addFnsStream = ep->add_fns();
    if addFnsStream is error {
        io:println("error added fns: ", addFnsStream.message());
    } else {
        foreach AddFnsReq aFReq in addFnsReq {
            grpc:Error? err = addFnsStream->sendAddFnsReq(aFReq);
            if err is error {
                io:println("Failed to send addFns req");
            }
        }

        grpc:Error? err = addFnsStream->complete();
        if err is error {
            io:println("Failed to send complete message");
        } else {
            AddFnsRes|grpc:Error? fnsRes = addFnsStream->receiveAddFnsRes();
            if fnsRes is error {
                io:println("Failed to retrieve addFnsRes: ", fnsRes.message());
            } else {
                if fnsRes is AddFnsRes {
                    foreach string msg in fnsRes.funcNames {
                        io:println(msg);
                    }
                }
            }
        }

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

    ShowAllFnsReq showAllFnsReq = {
        funcName: "helloWorld"
    };
    stream<ShowAllFnsRes, grpc:Error?>|grpc:Error showAllFnsStream = ep->show_all_fns(showAllFnsReq);
    if showAllFnsStream is error {
        io:println("Failed to show all fns: ", showAllFnsStream.message());
    } else {
        error? e = showAllFnsStream.forEach(function(ShowAllFnsRes res) {
            io:println("Successfully retrieved fn: ", res.fn.name);
        });
    }

    ShowAllWithCritReq[] showAllWithCritReqs = [{
        keywords: ["testing", "beginner"],
        lang: ""
    }];
    Show_all_with_criteriaStreamingClient|grpc:Error showAllWithCritStream = ep->show_all_with_criteria();
    if showAllWithCritStream is error {
        io:println("error occured setting up showAllWithCrit stream: ", showAllWithCritStream.message());
    } else {
        foreach ShowAllWithCritReq showAllWithCritReq in showAllWithCritReqs {
            error? err = showAllWithCritStream->sendShowAllWithCritReq(showAllWithCritReq);
            if err is error {
                io:println("failed to send showAllWithCriteria req: ", err.message());
            }
        }
        error? err = showAllWithCritStream->complete();
        if err is error {
            io:println("failed to send showAllWithCriteria complete message: ", err.message());
        }

        ShowAllWithCritRes|grpc:Error? showAllWithCritRes = showAllWithCritStream->receiveShowAllWithCritRes();
        while true {
            if showAllWithCritRes is error {
                io:println("failed to send showAllWithCriteria complete message: ", showAllWithCritRes.message());
                break;
            } else {
                if showAllWithCritRes is () {
                    break;
                } else {
                    io:println("showAllWithCriteria response: ", showAllWithCritRes.fns);
                    showAllWithCritRes = showAllWithCritStream->receiveShowAllWithCritRes();
                }
            }
        }
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
