DROP USER events CASCADE;

CREATE USER events IDENTIFIED BY events QUOTA UNLIMITED ON USERS;

GRANT connect to events;
GRANT resource to events;
GRANT create session TO events;
GRANT create table TO events;
GRANT create view TO events;

ALTER SESSION SET current_schema = events;

CREATE TABLE events.categories (
    id char(36) NOT NULL,
    name clob NOT NULL,
    is_archived char(1) NOT NULL,
    CONSTRAINT pk_categories PRIMARY KEY (id)
);

CREATE TABLE events.inbox_message_consumers (
    inbox_message_id char(36) NOT NULL,
    name varchar2(500) NOT NULL,
    CONSTRAINT pk_inbox_message_consumers PRIMARY KEY (inbox_message_id, name)
);

CREATE TABLE events.inbox_messages (
    id char(36) NOT NULL,
    type clob NOT NULL,
    content varchar2(2000) NOT NULL,
    occurred_on_utc timestamp with time zone NOT NULL,
    processed_on_utc timestamp with time zone,
    error clob,
    CONSTRAINT pk_inbox_messages PRIMARY KEY (id)
);

CREATE TABLE events.outbox_message_consumers (
    outbox_message_id char(36) NOT NULL,
    name varchar2(500) NOT NULL,
    CONSTRAINT pk_outbox_message_consumers PRIMARY KEY (outbox_message_id, name)
);

CREATE TABLE events.outbox_messages (
    id char(36) NOT NULL,
    type clob NOT NULL,
    content varchar2(2000) NOT NULL,
    occurred_on_utc timestamp with time zone NOT NULL,
    processed_on_utc timestamp with time zone,
    error clob,
    CONSTRAINT pk_outbox_messages PRIMARY KEY (id)
);

CREATE TABLE events.events (
    id char(36) NOT NULL,
    category_id char(36) NOT NULL,
    title clob NOT NULL,
    description clob NOT NULL,
    location clob NOT NULL,
    starts_at_utc timestamp with time zone NOT NULL,
    ends_at_utc timestamp with time zone,
    status number(10) NOT NULL,
    CONSTRAINT pk_events PRIMARY KEY (id),
    CONSTRAINT fk_events_categories_category_id FOREIGN KEY (category_id) REFERENCES events.categories (id) ON DELETE CASCADE
);

CREATE TABLE events.ticket_types (
    id char(36) NOT NULL,
    event_id char(36) NOT NULL,
    name clob NOT NULL,
    price number NOT NULL,
    currency clob NOT NULL,
    quantity number NOT NULL,
    CONSTRAINT pk_ticket_types PRIMARY KEY (id),
    CONSTRAINT fk_ticket_types_events_event_id FOREIGN KEY (event_id) REFERENCES events.events (id) ON DELETE CASCADE
);

CREATE INDEX ix_events_category_id ON events.events (category_id);

CREATE INDEX ix_ticket_types_event_id ON events.ticket_types (event_id);

