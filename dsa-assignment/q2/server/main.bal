import ballerina/grpc;

listener grpc:Listener ep = new (9090);

@grpc:ServiceDescriptor {descriptor: ROOT_DESCRIPTOR, descMap: getDescriptorMap()}
service "ReposityOfFunctions" on ep {
    remote function add_new_fn(AddFnReq value) returns AddFnRes|error {
        return error("Not implemented");
    }
    remote function delete_fn(DeleteFnReq value) returns DeleteFnRes|error {
        return error("Not implemented");
    }
    remote function show_fn(ShowFnReq value) returns ShowFnRes|error {
        return error("Not implemented");
    }
    remote function add_fns(stream<AddFnsReq, grpc:Error?> clientStream) returns AddFnRes|error {
        return error("Not implemented");
    }
    remote function show_all_fns(ShowAllFnsReq value) returns stream<ShowAllFnsRes, error?>|error {
        return error("Not implemented");
    }
    remote function show_all_with_criteria(stream<ShowAllWithCritReq, grpc:Error?> clientStream) returns stream<ShowAllWithCritRes, error?>|error {
        return error("Not implemented");
    }
}
