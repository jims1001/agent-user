create table user_roles
(
    user_id uuid not null
        references users
            on delete cascade,
    role_id uuid not null
        references roles
            on delete cascade,
    primary key (user_id, role_id)
);

comment on table user_roles is '关联用户和角色，实现多对多关系。';

comment on column user_roles.user_id is '关联的用户ID。';

comment on column user_roles.role_id is '关联的角色ID。';

alter table user_roles
    owner to root;

create index idx_user_roles_user_id
    on user_roles (user_id);

create index idx_user_roles_role_id
    on user_roles (role_id);

