-- DROP USER ticketing CASCADE;

CREATE USER ticketing IDENTIFIED BY ticketing DEFAULT TABLESPACE EVENTLY_TS QUOTA UNLIMITED ON EVENTLY_TS;

GRANT connect to ticketing;
GRANT resource to ticketing;
GRANT create session TO ticketing;
GRANT create table TO ticketing;
GRANT create view TO ticketing;

ALTER SESSION SET current_schema = ticketing;

CREATE TABLE ticketing.customers (
    id char(36) NOT NULL,
    email varchar2(300) NOT NULL,
    first_name varchar2(200) NOT NULL,
    last_name varchar2(200) NOT NULL,
    CONSTRAINT pk_customers PRIMARY KEY (id)
);

CREATE TABLE ticketing.events (
    id char(36) NOT NULL,
    title clob NOT NULL,
    description clob NOT NULL,
    location clob NOT NULL,
    starts_at_utc timestamp with time zone NOT NULL,
    ends_at_utc timestamp with time zone,
    canceled char(1) NOT NULL,
    CONSTRAINT pk_events PRIMARY KEY (id)
);

CREATE TABLE ticketing.inbox_message_consumers (
    inbox_message_id char(36) NOT NULL,
    name varchar2(500) NOT NULL,
    CONSTRAINT pk_inbox_message_consumers PRIMARY KEY (inbox_message_id, name)
);

CREATE TABLE ticketing.inbox_messages (
    id char(36) NOT NULL,
    type clob NOT NULL,
    content varchar2(2000) NOT NULL,
    occurred_on_utc timestamp with time zone NOT NULL,
    processed_on_utc timestamp with time zone,
    error clob,
    CONSTRAINT pk_inbox_messages PRIMARY KEY (id)
);

CREATE TABLE ticketing.outbox_message_consumers (
    outbox_message_id char(36) NOT NULL,
    name varchar2(500) NOT NULL,
    CONSTRAINT pk_outbox_message_consumers PRIMARY KEY (outbox_message_id, name)
);

CREATE TABLE ticketing.outbox_messages (
    id char(36) NOT NULL,
    type clob NOT NULL,
    content varchar2(2000) NOT NULL,
    occurred_on_utc timestamp with time zone NOT NULL,
    processed_on_utc timestamp with time zone,
    error clob,
    CONSTRAINT pk_outbox_messages PRIMARY KEY (id)
);

CREATE TABLE ticketing.orders (
    id char(36) NOT NULL,
    customer_id char(36) NOT NULL,
    status number(10) NOT NULL,
    total_price number NOT NULL,
    currency clob NOT NULL,
    tickets_issued char(1) NOT NULL,
    created_at_utc timestamp with time zone NOT NULL,
    CONSTRAINT pk_orders PRIMARY KEY (id),
    CONSTRAINT fk_orders_customers_customer_id FOREIGN KEY (customer_id) REFERENCES ticketing.customers (id) ON DELETE CASCADE
);

CREATE TABLE ticketing.ticket_types (
    id char(36) NOT NULL,
    event_id char(36) NOT NULL,
    name clob NOT NULL,
    price number NOT NULL,
    currency clob NOT NULL,
    quantity number NOT NULL,
    available_quantity number NOT NULL,
    CONSTRAINT pk_ticket_types PRIMARY KEY (id),
    CONSTRAINT fk_ticket_types_events_event_id FOREIGN KEY (event_id) REFERENCES ticketing.events (id) ON DELETE CASCADE
);

CREATE TABLE ticketing.payments (
    id char(36) NOT NULL,
    order_id char(36) NOT NULL,
    transaction_id char(36) NOT NULL,
    amount number NOT NULL,
    currency clob NOT NULL,
    amount_refunded number,
    created_at_utc timestamp with time zone NOT NULL,
    refunded_at_utc timestamp with time zone,
    CONSTRAINT pk_payments PRIMARY KEY (id),
    CONSTRAINT fk_payments_orders_order_id FOREIGN KEY (order_id) REFERENCES ticketing.orders (id) ON DELETE CASCADE
);

CREATE TABLE ticketing.order_items (
    id char(36) NOT NULL,
    order_id char(36) NOT NULL,
    ticket_type_id char(36) NOT NULL,
    quantity number NOT NULL,
    unit_price number NOT NULL,
    price number NOT NULL,
    currency clob NOT NULL,
    CONSTRAINT pk_order_items PRIMARY KEY (id),
    CONSTRAINT fk_order_items_orders_order_id FOREIGN KEY (order_id) REFERENCES ticketing.orders (id) ON DELETE CASCADE,
    CONSTRAINT fk_order_items_ticket_types_ticket_type_id FOREIGN KEY (ticket_type_id) REFERENCES ticketing.ticket_types (id) ON DELETE CASCADE
);

CREATE TABLE ticketing.tickets (
    id char(36) NOT NULL,
    customer_id char(36) NOT NULL,
    order_id char(36) NOT NULL,
    event_id char(36) NOT NULL,
    ticket_type_id char(36) NOT NULL,
    code varchar2(30) NOT NULL,
    created_at_utc timestamp with time zone NOT NULL,
    archived char(1) NOT NULL,
    CONSTRAINT pk_tickets PRIMARY KEY (id),
    CONSTRAINT fk_tickets_customers_customer_id FOREIGN KEY (customer_id) REFERENCES ticketing.customers (id) ON DELETE CASCADE,
    CONSTRAINT fk_tickets_events_event_id FOREIGN KEY (event_id) REFERENCES ticketing.events (id) ON DELETE CASCADE,
    CONSTRAINT fk_tickets_orders_order_id FOREIGN KEY (order_id) REFERENCES ticketing.orders (id) ON DELETE CASCADE,
    CONSTRAINT fk_tickets_ticket_types_ticket_type_id FOREIGN KEY (ticket_type_id) REFERENCES ticketing.ticket_types (id) ON DELETE CASCADE
);

CREATE INDEX ix_order_items_order_id ON ticketing.order_items (order_id);

CREATE INDEX ix_order_items_ticket_type_id ON ticketing.order_items (ticket_type_id);

CREATE INDEX ix_orders_customer_id ON ticketing.orders (customer_id);

CREATE INDEX ix_payments_order_id ON ticketing.payments (order_id);

CREATE UNIQUE INDEX ix_payments_transaction_id ON ticketing.payments (transaction_id);

CREATE INDEX ix_ticket_types_event_id ON ticketing.ticket_types (event_id);

CREATE UNIQUE INDEX ix_tickets_code ON ticketing.tickets (code);

CREATE INDEX ix_tickets_customer_id ON ticketing.tickets (customer_id);

CREATE INDEX ix_tickets_event_id ON ticketing.tickets (event_id);

CREATE INDEX ix_tickets_order_id ON ticketing.tickets (order_id);

CREATE INDEX ix_tickets_ticket_type_id ON ticketing.tickets (ticket_type_id);

