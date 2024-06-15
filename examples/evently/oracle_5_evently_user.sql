DROP USER evently CASCADE;

CREATE USER evently IDENTIFIED BY evently QUOTA UNLIMITED ON USERS;

GRANT connect to evently;
GRANT resource to evently;
GRANT create session TO evently;

BEGIN
  FOR t IN (SELECT object_name, object_type FROM all_objects WHERE owner='ATTENDANCE' AND object_type IN ('TABLE','VIEW','PROCEDURE','FUNCTION','PACKAGE')) LOOP
    IF t.object_type IN ('TABLE','VIEW') THEN
      EXECUTE IMMEDIATE 'GRANT SELECT, UPDATE, INSERT, DELETE ON ATTENDANCE.'||t.object_name||' TO EVENTLY';
    ELSIF t.object_type IN ('PROCEDURE','FUNCTION','PACKAGE') THEN
      EXECUTE IMMEDIATE 'GRANT EXECUTE ON ATTENDANCE.'||t.object_name||' TO EVENTLY';
    END IF;
  END LOOP;
END;

BEGIN
  FOR t IN (SELECT object_name, object_type FROM all_objects WHERE owner='EVENTS' AND object_type IN ('TABLE','VIEW','PROCEDURE','FUNCTION','PACKAGE')) LOOP
    IF t.object_type IN ('TABLE','VIEW') THEN
      EXECUTE IMMEDIATE 'GRANT SELECT, UPDATE, INSERT, DELETE ON EVENTS.'||t.object_name||' TO EVENTLY';
    ELSIF t.object_type IN ('PROCEDURE','FUNCTION','PACKAGE') THEN
      EXECUTE IMMEDIATE 'GRANT EXECUTE ON EVENTS.'||t.object_name||' TO EVENTLY';
    END IF;
  END LOOP;
END;

BEGIN
  FOR t IN (SELECT object_name, object_type FROM all_objects WHERE owner='TICKETING' AND object_type IN ('TABLE','VIEW','PROCEDURE','FUNCTION','PACKAGE')) LOOP
    IF t.object_type IN ('TABLE','VIEW') THEN
      EXECUTE IMMEDIATE 'GRANT SELECT, UPDATE, INSERT, DELETE ON TICKETING.'||t.object_name||' TO EVENTLY';
    ELSIF t.object_type IN ('PROCEDURE','FUNCTION','PACKAGE') THEN
      EXECUTE IMMEDIATE 'GRANT EXECUTE ON TICKETING.'||t.object_name||' TO EVENTLY';
    END IF;
  END LOOP;
END;

BEGIN
  FOR t IN (SELECT object_name, object_type FROM all_objects WHERE owner='USERS' AND object_type IN ('TABLE','VIEW','PROCEDURE','FUNCTION','PACKAGE')) LOOP
    IF t.object_type IN ('TABLE','VIEW') THEN
      EXECUTE IMMEDIATE 'GRANT SELECT, UPDATE, INSERT, DELETE ON USERS.'||t.object_name||' TO EVENTLY';
    ELSIF t.object_type IN ('PROCEDURE','FUNCTION','PACKAGE') THEN
      EXECUTE IMMEDIATE 'GRANT EXECUTE ON USERS.'||t.object_name||' TO EVENTLY';
    END IF;
  END LOOP;
END;