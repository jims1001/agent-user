create table user_attribute_assignments
(
    user_id      uuid not null
        references users
            on delete cascade,
    attribute_id uuid not null
        references user_attributes
            on delete cascade,
    assigned_by  uuid
                      references users
                          on delete set null,
    assigned_at  timestamp with time zone default CURRENT_TIMESTAMP,
    primary key (user_id, attribute_id)
);

comment on table user_attribute_assignments is '记录用户与其分配的用户属性值之间的关联。';

comment on column user_attribute_assignments.user_id is '被分配属性的用户ID。';

comment on column user_attribute_assignments.attribute_id is '分配给用户的属性值ID。';

comment on column user_attribute_assignments.assigned_by is '分配此属性的管理员用户ID。';

comment on column user_attribute_assignments.assigned_at is '属性值分配给用户的时间。';

alter table user_attribute_assignments
    owner to root;

create index idx_user_attribute_assignments_user_id
    on user_attribute_assignments (user_id);

create index idx_user_attribute_assignments_attribute_id
    on user_attribute_assignments (attribute_id);

