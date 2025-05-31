create table roles
(
    id          uuid default gen_random_uuid() not null
        primary key,
    name        varchar(50)                    not null
        unique,
    description text
);

comment on table roles is '定义系统中的用户角色。';

comment on column roles.id is '角色的唯一标识符。';

comment on column roles.name is '角色的名称（例如: admin, user, moderator）。';

comment on column roles.description is '角色的详细描述。';

alter table roles
    owner to root;

