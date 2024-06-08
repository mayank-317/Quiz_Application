USE quizapp;

CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    uname VARCHAR(50),
    upwd VARCHAR(50),
    uemail VARCHAR(255),
    umobile VARCHAR(10)
);

SELECT * FROM users;

CREATE TABLE quizzes (
    quiz_id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL,
    quiz_name VARCHAR(100) NOT NULL
);

SELECT * FROM quizzes;
CREATE TABLE questions (
    question_id INT AUTO_INCREMENT PRIMARY KEY,
    quiz_id INT NOT NULL REFERENCES quizzes(quiz_id),
    question_text VARCHAR(255) NOT NULL,
    option1 VARCHAR(255) NOT NULL,
    option2 VARCHAR(255) NOT NULL,
    option3 VARCHAR(255) NOT NULL,
    option4 VARCHAR(255) NOT NULL,
    correct_option VARCHAR(255) NOT NULL
);

SELECT * FROM questions;

	CREATE TABLE quiz_attempts (
		attempt_id INT AUTO_INCREMENT PRIMARY KEY,
		user_id INT NOT NULL REFERENCES users(id),
		quiz_id INT NOT NULL REFERENCES quizzes(quiz_id),
		score INT NOT NULL
	);
SELECT * FROM quiz_attempts;


-- insert into questions values(
-- 1,1,"What is the capital of Australia","Sydney","Melbourne","Canberra","Brisbane","Canberra"
-- );
