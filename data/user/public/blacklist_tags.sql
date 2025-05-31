create table blacklist_tags
(
    id          uuid                     default gen_random_uuid() not null
        primary key,
    name        varchar(50)                                        not null
        unique,
    description text,
    created_at  timestamp with time zone default CURRENT_TIMESTAMP,
    updated_at  timestamp with time zone default CURRENT_TIMESTAMP
);

comment on table blacklist_tags is '定义用于标记黑名单条目的标签。';

comment on column blacklist_tags.id is '黑名单标签的唯一标识符。';

comment on column blacklist_tags.name is '标签的唯一名称。';

comment on column blacklist_tags.description is '标签的详细描述。';

comment on column blacklist_tags.created_at is '标签的创建时间。';

comment on column blacklist_tags.updated_at is '标签的最后更新时间。';

alter table blacklist_tags
    owner to root;

