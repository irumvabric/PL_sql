PL/SQL is a block structured language that enables developers to combine the power of SQL with procedural statements.All the statements of a block are passed to oracle engine all at once which increases processing speed and decreases the traffic. 


SQL	
SQL is a single query that is used to perform DML and DDL operations.	
It is declarative, that defines what needs to be done, rather than how things need to be done.	
Execute as a single statement.	
Mainly used to manipulate data.
Cannot contain PL/SQL code in it.




PL/SQL

PL/SQL is a block of codes that used to write the entire program blocks/ procedure/ function, etc.

PL/SQL is procedural that defines how the things needs to be done.

Execute as a whole block.

Mainly used to create an application.

It is an extension of SQL, so it can contain SQL inside it.


DECLARE
    declaration statements;

BEGIN
    executable statements

EXCEPTIONS
    exception handling statements

END;
