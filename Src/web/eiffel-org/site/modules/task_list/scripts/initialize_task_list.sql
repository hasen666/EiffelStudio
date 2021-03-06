
	
INSERT INTO task_list_categories (synopsis, description, is_active) 
VALUES ('Wikipedia', '', 1);

INSERT INTO task_list_categories (synopsis, description, is_active) 
VALUES ('Rosetta_Code', '', 1);

INSERT INTO task_list_status (synopsis, description) 
VALUES ('Open', 'The initial state of a Problem Report. This means the PR has been filed and the responsible person(s) notified.');

INSERT INTO task_list_status (synopsis, description) 
VALUES ('Analyzed', 'The responsible person has analyzed the problem. The analysis should contain a preliminary evaluation of the problem and an estimate of the amount of time and resources necessary to solve the problem. It should also suggest possible workarounds.');

INSERT INTO task_list_status (synopsis, description) 
VALUES ('Closed', 'A Problem Report is closed only when any changes have been integrated, documented, and tested, and the submitter has confirmed the solution');

INSERT INTO task_list_status (synopsis, description) 
VALUES ('Suspended', 'Work on the problem has been postponed. This happens if a timely solution is not possible or is not cost-effective at the present time. The PR continues to exist, though a solution is not being actively sought. If the problem cannot be solved at all, it should be closed rather than suspended.');

INSERT INTO task_list_status (synopsis, description) 
VALUES ("Won't fix", "Won't fix problem report.");



