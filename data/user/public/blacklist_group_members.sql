create table blacklist_group_members
(
    blacklist_id uuid not null
        references blacklist
            on delete cascade,
    group_id     uuid not null
        references blacklist_groups
            on delete cascade,
    created_at   timestamp with time zone default CURRENT_TIMESTAMP,
    primary key (blacklist_id, group_id)
);

comment on table blacklist_group_members is '关联黑名单条目和黑名单分组，实现多对多关系。';

comment on column blacklist_group_members.blacklist_id is '关联的黑名单条目ID。';

comment on column blacklist_group_members.group_id is '关联的黑名单分组ID。';

comment on column blacklist_group_members.created_at is '关联记录的创建时间。';

alter table blacklist_group_members
    owner to root;

create index idx_bgl_blacklist_id
    on blacklist_group_members (blacklist_id);

create index idx_bgl_group_id
    on blacklist_group_members (group_id);

