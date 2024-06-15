-- DROP USER attendance CASCADE;

CREATE USER attendance IDENTIFIED BY attendance DEFAULT TABLESPACE EVENTLY_TS QUOTA UNLIMITED ON EVENTLY_TS;

GRANT connect to attendance;
GRANT resource to attendance;
GRANT create session TO attendance;
GRANT create table TO attendance;
GRANT create view TO attendance;

ALTER SESSION SET current_schema = attendance;

CREATE TABLE attendance.attendees (
    id char(36) NOT NULL,
    email varchar2(300) NOT NULL,
    first_name varchar2(200) NOT NULL,
    last_name varchar2(200) NOT NULL,
    CONSTRAINT pk_attendees PRIMARY KEY (id)
);

CREATE TABLE attendance.event_statistics (
    event_id char(36) NOT NULL,
    title clob NOT NULL,
    description clob NOT NULL,
    location clob NOT NULL,
    starts_at_utc timestamp with time zone NOT NULL,
    ends_at_utc timestamp with time zone,
    tickets_sold number(10) NOT NULL,
    attendees_checked_in number(10) NOT NULL,
    duplicate_check_in_tickets clob NOT NULL,
    invalid_check_in_tickets clob NOT NULL,
    CONSTRAINT pk_event_statistics PRIMARY KEY (event_id)
);

CREATE TABLE attendance.events (
    id char(36) NOT NULL,
    title clob NOT NULL,
    description clob NOT NULL,
    location clob NOT NULL,
    starts_at_utc timestamp with time zone NOT NULL,
    ends_at_utc timestamp with time zone,
    CONSTRAINT pk_events PRIMARY KEY (id)
);

CREATE TABLE attendance.inbox_message_consumers (
    inbox_message_id char(36) NOT NULL,
    name varchar2(500) NOT NULL,
    CONSTRAINT pk_inbox_message_consumers PRIMARY KEY (inbox_message_id, name)
);

CREATE TABLE attendance.inbox_messages (
    id char(36) NOT NULL,
    type clob NOT NULL,
    content varchar2(2000) NOT NULL,
    occurred_on_utc timestamp with time zone NOT NULL,
    processed_on_utc timestamp with time zone,
    error clob,
    CONSTRAINT pk_inbox_messages PRIMARY KEY (id)
);

CREATE TABLE attendance.outbox_message_consumers (
    outbox_message_id char(36) NOT NULL,
    name varchar2(500) NOT NULL,
    CONSTRAINT pk_outbox_message_consumers PRIMARY KEY (outbox_message_id, name)
);

CREATE TABLE attendance.outbox_messages (
    id char(36) NOT NULL,
    type clob NOT NULL,
    content varchar2(2000) NOT NULL,
    occurred_on_utc timestamp with time zone NOT NULL,
    processed_on_utc timestamp with time zone,
    error clob,
    CONSTRAINT pk_outbox_messages PRIMARY KEY (id)
);

CREATE TABLE attendance.tickets (
    id char(36) NOT NULL,
    attendee_id char(36) NOT NULL,
    event_id char(36) NOT NULL,
    code varchar2(30) NOT NULL,
    used_at_utc timestamp with time zone,
    CONSTRAINT pk_tickets PRIMARY KEY (id),
    CONSTRAINT fk_tickets_attendees_attendee_id FOREIGN KEY (attendee_id) REFERENCES attendance.attendees (id) ON DELETE CASCADE,
    CONSTRAINT fk_tickets_events_event_id FOREIGN KEY (event_id) REFERENCES attendance.events (id) ON DELETE CASCADE
);

CREATE INDEX ix_tickets_attendee_id ON attendance.tickets (attendee_id);

CREATE UNIQUE INDEX ix_tickets_code ON attendance.tickets (code);

CREATE INDEX ix_tickets_event_id ON attendance.tickets (event_id);

