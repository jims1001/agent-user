create table password_reset_tokens
(
    id         uuid                     default gen_random_uuid() not null
        primary key,
    user_id    uuid                                               not null
        references users
            on delete cascade,
    token      varchar(255)                                       not null
        unique,
    expires_at timestamp with time zone                           not null,
    is_used    boolean                  default false             not null,
    created_at timestamp with time zone default CURRENT_TIMESTAMP
);

comment on table password_reset_tokens is '存储用于用户密码重置的一次性令牌。';

comment on column password_reset_tokens.id is '密码重置令牌的唯一标识符。';

comment on column password_reset_tokens.user_id is '关联到需要重置密码的用户。';

comment on column password_reset_tokens.token is '发送给用户的安全随机令牌字符串。';

comment on column password_reset_tokens.expires_at is '令牌的过期时间。';

comment on column password_reset_tokens.is_used is '指示令牌是否已被成功使用，防止重复使用。';

comment on column password_reset_tokens.created_at is '令牌的创建时间。';

alter table password_reset_tokens
    owner to root;

create index idx_password_reset_tokens_user_id
    on password_reset_tokens (user_id);

create index idx_password_reset_tokens_token
    on password_reset_tokens (token);

