create table user_attribute_categories
(
    id          uuid                     default gen_random_uuid() not null
        primary key,
    name        varchar(100)                                       not null
        unique,
    description text,
    created_at  timestamp with time zone default CURRENT_TIMESTAMP,
    updated_at  timestamp with time zone default CURRENT_TIMESTAMP
);

comment on table user_attribute_categories is '定义用户属性的分类，用于更好地组织和管理用户属性。';

comment on column user_attribute_categories.id is '用户属性分类的唯一标识符。';

comment on column user_attribute_categories.name is '分类的唯一名称，例如“客户等级”、“兴趣偏好”。';

comment on column user_attribute_categories.description is '对用户属性分类的详细描述。';

comment on column user_attribute_categories.created_at is '用户属性分类的创建时间。';

comment on column user_attribute_categories.updated_at is '用户属性分类的最后更新时间。';

alter table user_attribute_categories
    owner to root;

