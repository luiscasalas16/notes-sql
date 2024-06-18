CREATE USER evently WITH PASSWORD 'evently';

\c evently;

GRANT ALL PRIVILEGES ON SCHEMA attendance TO evently;
GRANT ALL PRIVILEGES ON SCHEMA events TO evently;
GRANT ALL PRIVILEGES ON SCHEMA ticketing TO evently;
GRANT ALL PRIVILEGES ON SCHEMA users TO evently;

GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA attendance to evently;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA events to evently;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA ticketing to evently;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA users to evently;