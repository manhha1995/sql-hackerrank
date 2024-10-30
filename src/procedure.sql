create FUNCTION InsertMillionUsers
    RETURN NUMBER
AS
    v_inserted_count NUMBER := 0;
    TYPE t_firstname IS TABLE OF VARCHAR2(50);
    TYPE t_lastname IS TABLE OF VARCHAR2(50);
    TYPE t_email IS TABLE OF VARCHAR2(100);
    TYPE t_password IS TABLE OF VARCHAR2(50);
    TYPE t_roleid IS TABLE OF NUMBER;

    v_firstname t_firstname := t_firstname();
    v_lastname t_lastname := t_lastname();
    v_email t_email := t_email();
    v_password t_password := t_password();
    v_roleid t_roleid := t_roleid();

    v_batch_size NUMBER := 10000;
BEGIN
    FOR i IN 1..1000000 LOOP
            v_firstname.EXTEND;
            v_lastname.EXTEND;
            v_email.EXTEND;
            v_password.EXTEND;
            v_roleid.EXTEND;

            v_firstname(i) := 'FirstName' || TO_CHAR(i);
            v_lastname(i) := 'LastName' || TO_CHAR(i);
            v_email(i) := 'Email' || TO_CHAR(i) || '@gmail.com';
            v_password(i) := 'Password' || TO_CHAR(i);
            v_roleid(i) := 1;

            -- Perform bulk insert every v_batch_size records
            IF MOD(i, v_batch_size) = 0 THEN
                FORALL j IN v_firstname.FIRST..v_firstname.LAST
                    INSERT INTO Users (FirstName, LastName, Email, Password, RoleId)
                    VALUES (v_firstname(j), v_lastname(j), v_email(j), v_password(j), v_roleid(j));

                v_inserted_count := v_inserted_count + SQL%ROWCOUNT;
                COMMIT;

                -- Clear the collections
                v_firstname.DELETE;
                v_lastname.DELETE;
                v_email.DELETE;
                v_password.DELETE;
                v_roleid.DELETE;
            END IF;
        END LOOP;

    -- Insert any remaining records
    IF v_firstname.COUNT > 0 THEN
        FORALL j IN v_firstname.FIRST..v_firstname.LAST
            INSERT INTO Users (FirstName, LastName, Email, Password, RoleId)
            VALUES (v_firstname(j), v_lastname(j), v_email(j), v_password(j), v_roleid(j));

        v_inserted_count := v_inserted_count + SQL%ROWCOUNT;
        COMMIT;
    END IF;

    RETURN v_inserted_count;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
        ROLLBACK;
        RETURN v_inserted_count;
END InsertMillionUsers;