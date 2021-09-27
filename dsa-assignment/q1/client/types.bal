public type LearningObject record {
    MaterialObject[] audio;
    MaterialObject[] video;
    MaterialObject[] text;
};

public type MaterialObject record {
    string name;
    string description;
    string difficulty;
};

public type TopicResObject record {
    string name;
    string description;
    string difficulty;
};

public type ReqObject record {
    string message;
};

public type ResObject record {
    string message;
};

public type LearnerProf record {
    string username;
    string firstName;
    string lastName;
    string[] preferred_formats;
    record  { string course; string score;} [] past_subjects;
};

public type LearningMaterial record {
    string course;
    LearningObject learning_objects;
};
