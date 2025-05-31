create table user_attributes
(
    id                  uuid                     default gen_random_uuid() not null
        primary key,
    name                varchar(100)                                       not null,
    description         text,
    category_id         uuid
                                                                           references user_attribute_categories
                                                                               on delete set null,
    is_system_attribute boolean                  default false             not null,
    created_at          timestamp with time zone default CURRENT_TIMESTAMP,
    updated_at          timestamp with time zone default CURRENT_TIMESTAMP,
    unique (name, category_id)
);

comment on table user_attributes is '定义系统中所有可用于标记用户的属性值。';

comment on column user_attributes.id is '用户属性值的唯一标识符。';

comment on column user_attributes.name is '属性值的名称，例如“黄金会员”、“高活跃”。';

comment on column user_attributes.description is '对用户属性值的详细描述。';

comment on column user_attributes.category_id is '此属性值所属的分类ID，用于属性的结构化管理。';

comment on column user_attributes.is_system_attribute is '指示此属性值是否为系统预设，通常不可由普通管理员修改或删除。';

comment on column user_attributes.created_at is '属性值的创建时间。';

comment on column user_attributes.updated_at is '属性值的最后更新时间。';

alter table user_attributes
    owner to root;

create index idx_user_attributes_name
    on user_attributes (name);

create index idx_user_attributes_category_id
    on user_attributes (category_id);

