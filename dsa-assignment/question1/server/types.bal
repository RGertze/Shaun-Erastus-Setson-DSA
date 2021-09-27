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
    record  { record  { string name?; string description?; string difficulty?;} [] audio?; record  { string name?; string description?; string difficulty?;} [] video?; record  { string name?; string description?; string difficulty?;} [] text?;}  learning_objects;
};
