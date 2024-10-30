create index ix_fistname on USERS(FIRSTNAME);
EXPLAIN PLAN SET STATEMENT_ID = 'my_plan' FOR
SELECT EMAIL FROM USERS WHERE FIRSTNAME =  'FirstName116';
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY('PLAN_TABLE', 'my_plan', 'TYPICAL'));
select * from v$sql where SQL_TEXT like '%my_plan%';