import ballerina/io;

Client ep = check new;

public function main() {
    LearnerProf learner = {
        username: "era", 
        firstName: "era", 
        lastName: "matheus", 
        preferred_formats: ["text", "audio", "video"], 
        past_subjects: [
            {
                score: "A", 
                course: "DSA"
            }
        ]
    };

    ResObject|error res = ep->add(learner);
    if res is error {
        io:println("Error occured while adding user: ", res.message());
    } else {
        io:println("Successfully added user: ", res.message);
    }

    learner.firstName = "erastus";
    res = ep->update(learner);
    if res is error {
        io:println("Error occured while updating user: ", res.message());
    } else {
        io:println("Successfully updated user: ", res.message);
    }

}
