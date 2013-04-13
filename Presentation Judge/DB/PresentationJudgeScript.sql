ALTER TABLE "Question";
ALTER TABLE "SectionQuestion";
ALTER TABLE "SubSection";
ALTER TABLE "Section";
ALTER TABLE "PaticipantType";
ALTER TABLE "Presenter";
ALTER TABLE "Judge";
ALTER TABLE "Presentation";
ALTER TABLE "PresenterPresentation";
ALTER TABLE "PresentationJudge";
ALTER TABLE "PresentationQuestions";
ALTER TABLE "QuestionRanking";
ALTER TABLE "RankStyle";

DROP TABLE "Question";
DROP TABLE "SectionQuestion";
DROP TABLE "SubSection";
DROP TABLE "Section";
DROP TABLE "PaticipantType";
DROP TABLE "Presenter";
DROP TABLE "Judge";
DROP TABLE "Presentation";
DROP TABLE "PresenterPresentation";
DROP TABLE "PresentationJudge";
DROP TABLE "PresentationQuestions";
DROP TABLE "QuestionRanking";
DROP TABLE "RankStyle";

CREATE TABLE "Question" (
"ID" INTEGER NOT NULL,
"Question" VARCHAR(255) NOT NULL,
PRIMARY KEY ("ID") 
);

CREATE TABLE "SectionQuestion" (
"ID" INTEGER NOT NULL,
"QuestionID" INTEGER NOT NULL,
"SectionID" INTEGER NOT NULL,
"SubSectionID" INTEGER NULL,
"Comments" VARCHAR(255) NULL,
PRIMARY KEY ("ID") 
);

CREATE TABLE "SubSection" (
"ID" INTEGER NULL,
"Name" VARCHAR(255) NOT NULL,
PRIMARY KEY ("ID") 
);

CREATE TABLE "Section" (
"ID" INTEGER NOT NULL,
"Name" VARCHAR(255) NOT NULL,
PRIMARY KEY ("ID") 
);

CREATE TABLE "PaticipantType" (
"ID" INTEGER NOT NULL,
"Type" VARCHAR(255) NOT NULL,
PRIMARY KEY ("ID") 
);

CREATE TABLE "Presenter" (
"ID" INTEGER NOT NULL,
"FirstName" VARCHAR(255) NOT NULL,
"LastName" VARCHAR(255) NOT NULL,
"Email" VARCHAR(255) NOT NULL,
PRIMARY KEY ("ID") 
);

CREATE TABLE "Judge" (
"ID" INTEGER NOT NULL,
"FirstName" VARCHAR(255) NOT NULL,
"LastName" VARCHAR(255) NOT NULL,
"Email" VARCHAR(255) NOT NULL,
PRIMARY KEY ("ID") 
);

CREATE TABLE "Presentation" (
"ID" INTEGER NOT NULL,
"Title" VARCHAR(255) NOT NULL,
"RankSyleID" INTEGER NOT NULL,
"ScaleLowerBound" VARCHAR(255) NOT NULL,
"ScaleUpperBound" VARCHAR(255) NOT NULL,
"Comments" VARCHAR(255) NULL,
PRIMARY KEY ("ID") 
);

CREATE TABLE "PresenterPresentation" (
"ID" INTEGER NOT NULL,
"PresenterID" INTEGER NOT NULL,
"PresentationID" INTEGER NOT NULL,
PRIMARY KEY ("ID") 
);

CREATE TABLE "PresentationJudge" (
"ID" INTEGER NOT NULL,
"JudgeID" INTEGER NOT NULL,
"PresentationID" INTEGER NOT NULL,
PRIMARY KEY ("ID") 
);

CREATE TABLE "PresentationQuestions" (
"ID" INTEGER NOT NULL,
"PresentationID" INTEGER NOT NULL,
"QuestionSectionID" INTEGER NOT NULL,
PRIMARY KEY ("ID") 
);

CREATE TABLE "QuestionRanking" (
"ID" INTEGER NOT NULL,
"QuestionID" INTEGER NOT NULL,
"Ranking" VARCHAR(255) NOT NULL,
PRIMARY KEY ("ID") 
);

CREATE TABLE "RankStyle" (
"ID" INTEGER NOT NULL,
"StyleName" VARCHAR(255) NOT NULL,
PRIMARY KEY ("ID") 
);


ALTER TABLE "SectionQuestion" ADD CONSTRAINT "fk_QuestionSection_Question" FOREIGN KEY ("QuestionID") REFERENCES "Question" ("ID");
ALTER TABLE "SectionQuestion" ADD CONSTRAINT "fk_QuestionSection_SubSectio" FOREIGN KEY ("SubSectionID") REFERENCES "SubSection" ("ID");
ALTER TABLE "SectionQuestion" ADD CONSTRAINT "fk_QuestionSection_Section" FOREIGN KEY ("SectionID") REFERENCES "Section" ("ID");
ALTER TABLE "PresenterPresentation" ADD CONSTRAINT "fk_PresenterPresentation_Presenter" FOREIGN KEY ("PresenterID") REFERENCES "Presenter" ("ID");
ALTER TABLE "PresenterPresentation" ADD CONSTRAINT "fk_PresenterPresentation_Presentation" FOREIGN KEY ("PresentationID") REFERENCES "Presentation" ("ID");
ALTER TABLE "PresentationJudge" ADD CONSTRAINT "fk_PresentationJudge_Presentation" FOREIGN KEY ("PresentationID") REFERENCES "Presentation" ("ID");
ALTER TABLE "PresentationJudge" ADD CONSTRAINT "fk_PresentationJudge_Judge" FOREIGN KEY ("JudgeID") REFERENCES "Judge" ("ID");
ALTER TABLE "PresentationQuestions" ADD CONSTRAINT "fk_PresentationQuestions_Presentation" FOREIGN KEY ("PresentationID") REFERENCES "Presentation" ("ID");
ALTER TABLE "PresentationQuestions" ADD CONSTRAINT "fk_PresentationQuestions_Questions" FOREIGN KEY ("QuestionSectionID") REFERENCES "SectionQuestion" ("ID");
ALTER TABLE "Presentation" ADD CONSTRAINT "fk_Presentation_RankStyle" FOREIGN KEY ("RankSyleID") REFERENCES "RankStyle" ("ID");

