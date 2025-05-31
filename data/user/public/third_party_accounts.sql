create table third_party_accounts
(
    id            uuid                     default gen_random_uuid() not null
        primary key,
    user_id       uuid                                               not null
        references users
            on delete cascade,
    provider      varchar(50)                                        not null,
    provider_id   varchar(255)                                       not null,
    email         varchar(255),
    access_token  text,
    refresh_token text,
    expires_at    timestamp with time zone,
    created_at    timestamp with time zone default CURRENT_TIMESTAMP,
    updated_at    timestamp with time zone default CURRENT_TIMESTAMP,
    unique (provider, provider_id)
);

comment on table third_party_accounts is '存储用户绑定的第三方认证服务（如 Google, Facebook）账户信息。';

comment on column third_party_accounts.id is '第三方账户绑定的唯一标识符。';

comment on column third_party_accounts.user_id is '关联到系统内部的用户。';

comment on column third_party_accounts.provider is '第三方认证服务的名称（例如: google, facebook, github）。';

comment on column third_party_accounts.provider_id is '在第三方服务中用户的唯一标识符。';

comment on column third_party_accounts.email is '第三方账户提供的电子邮件地址（可选）。';

comment on column third_party_accounts.access_token is '用于访问第三方 API 的令牌。';

comment on column third_party_accounts.refresh_token is '用于刷新过期访问令牌的令牌。';

comment on column third_party_accounts.expires_at is '访问令牌的过期时间。';

comment on column third_party_accounts.created_at is '第三方账户绑定记录的创建时间。';

comment on column third_party_accounts.updated_at is '第三方账户绑定记录的最后更新时间。';

alter table third_party_accounts
    owner to root;

create index idx_third_party_accounts_user_id
    on third_party_accounts (user_id);

create index idx_third_party_accounts_provider_provider_id
    on third_party_accounts (provider, provider_id);

