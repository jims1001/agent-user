create table permissions
(
    id          uuid default gen_random_uuid() not null
        primary key,
    name        varchar(100)                   not null
        unique,
    description text
);

comment on table permissions is '定义系统中的具体操作权限。';

comment on column permissions.id is '权限的唯一标识符。';

comment on column permissions.name is '权限的名称（例如: user:read, product:delete）。';

comment on column permissions.description is '权限的详细描述。';

alter table permissions
    owner to root;

