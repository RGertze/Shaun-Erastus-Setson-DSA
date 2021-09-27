import ballerina/http;

listener http:Listener ep0 = new (8080, config = {host: "localhost"});

map<string> difficultyMap = {
    "A": "hard",
    "B": "hard",
    "C": "medium",
    "D": "medium",
    "E": "easy",
    "F": "easy"
};

LearnerProf[] learners = [];
LearningMaterial[] materials = [{
    course: "dsa",
    learning_objects: {
        audio: [{
            difficulty: "easy",
            name: "intro",
            description: "introduction to dsa"
        }],
        video: [{
            difficulty: "easy",
            name: "intro",
            description: "introduction to dsa"
        }],
        text: [{
            difficulty: "easy",
            name: "intro",
            description: "introduction to dsa"
        }]
    }
}, 
    {
    course: "ice",
    learning_objects: {
        audio: [{
            difficulty: "hard",
            name: "lesson1",
            description: "ice lesson 1"
        }],
        video: [{
            difficulty: "hard",
            name: "lesson1",
            description: "ice lesson 1"
        }],
        text: [{
            difficulty: "hard",
            name: "lesson1",
            description: "ice lesson 1"
        }]
    }
}];

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
                } else {
                    return {message: "failed updated user"};
                }
            }
        }
        return {message: "user not found"};
    }

    resource function get learningMaterials/[string learner]() returns TopicResObject[]|record {|*http:BadRequest; ResObject body;|} {
        foreach LearnerProf learnerProf in learners {
            if learnerProf.username == learner {
                // find lowest mark of past subjects
                string lowestGrade = "A";
                foreach var pastSub in learnerProf.past_subjects {
                    if pastSub.score.getCodePoint(0) > lowestGrade.getCodePoint(0) {
                        lowestGrade = pastSub.score;
                    }
                }

                TopicResObject[] topics = [];
                string difficulty = difficultyMap.get(lowestGrade);

                // find all materials that have a matching grade or lower
                foreach LearningMaterial material in materials {
                    foreach var audio in material.learning_objects.audio {
                        if audio.difficulty == difficulty {
                            topics.push(audio);
                        }
                    }
                    foreach var text in material.learning_objects.text {
                        if text.difficulty == difficulty {
                            topics.push(text);
                        }
                    }
                    foreach var video in material.learning_objects.video {
                        if video.difficulty == difficulty {
                            topics.push(video);
                        }
                    }
                }
                return topics;
            }
        }
        return {
            body: {
                message: "learner does not exist"
            }
        };
    }
}
