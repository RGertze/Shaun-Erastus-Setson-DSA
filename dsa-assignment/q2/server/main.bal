import ballerina/grpc;

listener grpc:Listener ep = new (9090);

Fn[] fns = [];

@grpc:ServiceDescriptor {descriptor: ROOT_DESCRIPTOR, descMap: getDescriptorMap()}
service "ReposityOfFunctions" on ep {
    remote function add_new_fn(AddFnReq value) returns AddFnRes|error {
        int currVersion = 0;
        foreach Fn fn in fns {
            if fn.name == value.fn.name {
                currVersion = fn.versionNum;
                if fn.versionNum == value.fn.versionNum {
                    return error("Version of fn already exists");
                }
            }
        }
        int expectedVersion = currVersion + 1;
        if value.fn.versionNum != expectedVersion {
            return error("Wrong version number! Expected: " + expectedVersion.toString());
        }
        fns.push(value.fn);
        return {message: "Successfully added fn: " + value.fn.name};
    }

    remote function delete_fn(DeleteFnReq value) returns DeleteFnRes|error {
        boolean reorder = false;
        int i = 0;
        while i < fns.length() {
            if fns[i].name == value.funcName && reorder {
                fns[i].versionNum -= 1;
            }

            if fns[i].name == value.funcName && fns[i].versionNum == value.versionNum && !reorder {
                Fn err = fns.remove(i);
                reorder = true;
                i -= 1;
            }

            i += 1;
        }
        if reorder {
            return {message: "Successfully deleted fn"};
        }
        return error("Function not found");
    }

    remote function show_fn(ShowFnReq value) returns ShowFnRes|error {
        foreach Fn fn in fns {
            if fn.name == value.funcName && fn.versionNum == value.versionNum {
                return {fn: fn};
            }
        }
        return error("Function not found");
    }

    remote function add_fns(stream<AddFnsReq, grpc:Error?> clientStream) returns AddFnsRes|error {
        Fn[] fnsToPush = [];
        AddFnsRes res = {
            funcNames: []
        };
        error? e = clientStream.forEach(function(AddFnsReq req) {
            boolean multipleVals = false;
            foreach Fn fn in fnsToPush {
                if fn.name == req.fn.name {
                    res.funcNames.push("Failed to add fn: " + fn.name + ", ,multiple versions detected");
                    multipleVals = true;
                    break;
                }
            }
            if !multipleVals {
                fnsToPush.push(req.fn);
                res.funcNames.push("Successfully added fn: " + req.fn.name);
            }
        });
        foreach Fn fn in fnsToPush {
            fns.push(fn);
        }

        return res;
    }

    remote function show_all_fns(ShowAllFnsReq value) returns stream<ShowAllFnsRes, error?>|error {
        ShowAllFnsRes[] resToReturn = [];
        foreach Fn fn in fns {
            if fn.name == value.funcName {
                ShowAllFnsRes res = {
                    fn: fn
                };
                resToReturn.push(res);
            }
        }
        if resToReturn.length() == 0 {
            return error("No fn versions found");
        }
        return resToReturn.toStream();
    }

    remote function show_all_with_criteria(stream<ShowAllWithCritReq, grpc:Error?> clientStream) returns stream<ShowAllWithCritRes, error?>|error {
        ShowAllWithCritRes[] responses = [];
        error? e = clientStream.forEach(function(ShowAllWithCritReq req) {
            ShowAllWithCritRes resToPush = {
                fns: []
            };
            map<Fn> latestVersions = {};
            foreach Fn fn in fns {
                boolean found = false;
                if fn.lang == req.lang && req.lang != "" {
                    latestVersions[fn.name] = fn;
                    found = true;
                }
                if !found {
                    boolean keywordMatch = false;
                    foreach string fnKeyword in fn.keywords {
                        foreach string keyword in req.keywords {
                            if fnKeyword == keyword {
                                latestVersions[fn.name] = fn;
                                keywordMatch = true;
                                break;
                            }
                        }
                        if keywordMatch {
                            break;
                        }
                    }
                }
            }

            latestVersions.forEach(function(Fn fn) {
                resToPush.fns.push(fn);
            });

            responses.push(resToPush);
        });
        if e is error {
            return error("Failed to read requests");
        }
        return responses.toStream();
    }
}
