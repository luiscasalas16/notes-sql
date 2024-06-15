CREATE USER evently WITH PASSWORD 'evently';

GRANT ALL ON SCHEMA attendance TO evently;
GRANT ALL ON SCHEMA events TO evently;
GRANT ALL ON SCHEMA ticketing TO evently;
GRANT ALL ON SCHEMA users TO evently;