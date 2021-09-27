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
        foreach Fn fn in fns {

            if fn.name == value.funcName && reorder {
                int? index = fns.indexOf(fn);
                if index is int {
                    fns[index].versionNum -= 1;
                }
            }

            if fn.name == value.funcName && fn.versionNum == value.versionNum && !reorder {
                int? index = fns.indexOf(fn);
                if index is int {
                    Fn err = fns.remove(index);
                    reorder = true;
                }
            }

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

    remote function add_fns(stream<AddFnsReq, grpc:Error?> clientStream) returns AddFnRes|error {
        return error("Not implemented");
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
        return error("Not implemented");
    }
}
