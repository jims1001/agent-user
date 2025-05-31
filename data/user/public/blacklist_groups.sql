create table blacklist_groups
(
    id          uuid                     default gen_random_uuid() not null
        primary key,
    name        varchar(100)                                       not null
        unique,
    description text,
    created_at  timestamp with time zone default CURRENT_TIMESTAMP,
    updated_at  timestamp with time zone default CURRENT_TIMESTAMP
);

comment on table blacklist_groups is '定义黑名单条目所属的逻辑分组。';

comment on column blacklist_groups.id is '黑名单分组的唯一标识符。';

comment on column blacklist_groups.name is '分组的唯一名称。';

comment on column blacklist_groups.description is '分组的详细描述。';

comment on column blacklist_groups.created_at is '分组的创建时间。';

comment on column blacklist_groups.updated_at is '分组的最后更新时间。';

alter table blacklist_groups
    owner to root;

