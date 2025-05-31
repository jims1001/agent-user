create table role_permissions
(
    role_id       uuid not null
        references roles
            on delete cascade,
    permission_id uuid not null
        references permissions
            on delete cascade,
    primary key (role_id, permission_id)
);

comment on table role_permissions is '关联角色和权限，实现多对多关系。';

comment on column role_permissions.role_id is '关联的角色ID。';

comment on column role_permissions.permission_id is '关联的权限ID。';

alter table role_permissions
    owner to root;

create index idx_role_permissions_role_id
    on role_permissions (role_id);

create index idx_role_permissions_permission_id
    on role_permissions (permission_id);

