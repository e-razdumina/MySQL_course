-- добавляем внешние ключи 

USE geek;

ALTER TABLE profiles
   ADD CONSTRAINT profiles_user_id_fk
    FOREIGN KEY (user_id) REFERENCES users(id)
	;



ALTER TABLE courses
   ADD CONSTRAINT courses_teacher_id_fk
    FOREIGN KEY (teacher_id) REFERENCES users(id)
      ON DELETE SET NULL
  	  ;
     
ALTER TABLE faculties_courses
   ADD CONSTRAINT faculties_courses_faculty_id_fk
    FOREIGN KEY (faculty_id) REFERENCES faculties(id),
	ADD CONSTRAINT faculties_courses_course_id_fk
    FOREIGN KEY (course_id) REFERENCES courses(id)
    ;
     
ALTER TABLE users_courses
   ADD CONSTRAINT users_courses_course_id_fk
    FOREIGN KEY (course_id) REFERENCES courses(id)
    ,
	ADD CONSTRAINT users_courses_user_id_fk
    FOREIGN KEY (user_id) REFERENCES users(id)
    ;

ALTER TABLE events
   ADD CONSTRAINT events_teacher_id_fk
    FOREIGN KEY (teacher_id) REFERENCES users(id)
      ON DELETE SET NULL,
	ADD CONSTRAINT events_faculty_id_fk
    FOREIGN KEY (faculty_id) REFERENCES faculties(id)
      ON DELETE SET NULL;
     
ALTER TABLE users_events
   ADD CONSTRAINT users_events_event_id_fk
    FOREIGN KEY (event_id) REFERENCES events(id)
      ,
	ADD CONSTRAINT users_events_user_id_fk
    FOREIGN KEY (user_id) REFERENCES users(id)
      ;
     
ALTER TABLE tests
	ADD CONSTRAINT tests_course_id_fk
    FOREIGN KEY (course_id) REFERENCES courses(id)
      ON DELETE SET NULL;
     
     
ALTER TABLE users_tests
	ADD CONSTRAINT users_tests_test_id_fk
    FOREIGN KEY (test_id) REFERENCES tests(id)
      ,
    ADD CONSTRAINT users_tests_user_id_fk
    FOREIGN KEY (user_id) REFERENCES users(id)
      ;
     
ALTER TABLE messages
	ADD CONSTRAINT messages_from_user_id_fk
    FOREIGN KEY (from_user_id) REFERENCES users(id)
      ON DELETE SET NULL,
    ADD CONSTRAINT messages_to_user_id_fk
    FOREIGN KEY (to_user_id) REFERENCES users(id)
      ON DELETE SET NULL;
     
ALTER TABLE likes
	ADD CONSTRAINT likes_from_user_id_fk
    FOREIGN KEY (from_user_id) REFERENCES users(id)
      ON DELETE SET NULL,
    ADD CONSTRAINT likes_to_user_id_fk
    FOREIGN KEY (to_user_id) REFERENCES users(id)
      ON DELETE SET NULL;
     

