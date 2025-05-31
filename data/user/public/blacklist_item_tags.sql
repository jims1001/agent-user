create table blacklist_item_tags
(
    blacklist_id uuid not null
        references blacklist
            on delete cascade,
    tag_id       uuid not null
        references blacklist_tags
            on delete cascade,
    created_at   timestamp with time zone default CURRENT_TIMESTAMP,
    primary key (blacklist_id, tag_id)
);

comment on table blacklist_item_tags is '关联黑名单条目和标签，实现多对多关系。';

comment on column blacklist_item_tags.blacklist_id is '关联的黑名单条目ID。';

comment on column blacklist_item_tags.tag_id is '关联的黑名单标签ID。';

comment on column blacklist_item_tags.created_at is '关联记录的创建时间。';

alter table blacklist_item_tags
    owner to root;

create index idx_bit_blacklist_id
    on blacklist_item_tags (blacklist_id);

create index idx_bit_tag_id
    on blacklist_item_tags (tag_id);

