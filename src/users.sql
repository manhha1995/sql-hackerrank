create table USERS if not exists
(
    ID        NUMBER generated as identity
        primary key,
    FIRSTNAME VARCHAR2(50) not null,
    LASTNAME  VARCHAR2(50) not null,
    EMAIL     VARCHAR2(50) not null,
    PASSWORD  VARCHAR2(50) not null,
    ROLEID    NUMBER       not null
)