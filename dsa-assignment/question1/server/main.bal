import ballerina/http;

listener http:Listener ep0 = new (8080, config = {host: "localhost"});

LearnerProf[] learners = [];

service /studentManagment on ep0 {
    resource function post user/add(@http:Payload {} LearnerProf payload) returns ResObject|record {|*http:BadRequest; ResObject body;|} {
        foreach LearnerProf learner in learners {
            if learner.username == payload.username {
                return {message: "user already exists"};
            }
        }
        learners.push(payload);
        return {message: "successfully added user"};
    }

    resource function post user/update(@http:Payload {} LearnerProf payload) returns ResObject|record {|*http:BadRequest; ResObject body;|} {
        foreach LearnerProf learner in learners {
            if learner.username == payload.username {
                int? index = learners.indexOf(learner);
                if index is int {
                    learners[index] = payload;
                    return {message: "successfully updated user"};
                }else{
                    return {message: "failed updated user"};
                }
            }
        }
        return {message: "user not found"};
    }
}
