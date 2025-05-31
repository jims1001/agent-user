create table blacklist
(
    id           uuid                     default gen_random_uuid() not null
        primary key,
    entity_type  varchar(50)                                        not null,
    entity_value varchar(255)                                       not null,
    reason       text,
    expires_at   timestamp with time zone,
    is_active    boolean                  default true              not null,
    created_at   timestamp with time zone default CURRENT_TIMESTAMP,
    blocked_by   uuid
                                                                    references users
                                                                        on delete set null,
    updated_at   timestamp with time zone default CURRENT_TIMESTAMP,
    unique (entity_type, entity_value)
);

comment on table blacklist is '存储被系统拒绝访问的实体信息，支持多种实体类型，包括基于用户属性的限制。';

comment on column blacklist.id is '黑名单记录的唯一标识符。';

comment on column blacklist.entity_type is '被拉黑的实体类型。可包括：user_id (用户UUID), ip_address, device_id, email_domain, user_attribute_id (某个用户属性的UUID)。';

comment on column blacklist.entity_value is '被拉黑实体的具体值。例如：某个用户UUID，某个IP地址，某个邮箱域名，或某个用户属性的UUID。';

comment on column blacklist.reason is '将此实体加入黑名单的详细原因。';

comment on column blacklist.expires_at is '黑名单的过期时间，如果为空则表示永久黑名单。';

comment on column blacklist.is_active is '指示此黑名单条目是否当前处于活跃状态，允许临时禁用。';

comment on column blacklist.created_at is '黑名单记录的创建时间。';

comment on column blacklist.blocked_by is '执行拉黑操作的管理员用户ID。';

comment on column blacklist.updated_at is '黑名单记录的最后更新时间。';

alter table blacklist
    owner to root;

create index idx_blacklist_entity_type_value
    on blacklist (entity_type, entity_value);

create index idx_blacklist_expires_at
    on blacklist (expires_at)
    where (expires_at IS NOT NULL);

create index idx_blacklist_is_active
    on blacklist (is_active);

