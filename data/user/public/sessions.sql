create table sessions
(
    id            uuid                     default gen_random_uuid() not null
        primary key,
    user_id       uuid                                               not null
        references users
            on delete cascade,
    session_token varchar(255)                                       not null
        unique,
    ip_address    inet,
    user_agent    text,
    expires_at    timestamp with time zone                           not null,
    created_at    timestamp with time zone default CURRENT_TIMESTAMP
);

comment on table sessions is '存储用户会话信息，用于维持用户的登录状态。';

comment on column sessions.id is '会话的唯一标识符。';

comment on column sessions.user_id is '关联到此会话的用户。';

comment on column sessions.session_token is '发送给客户端的会话令牌。';

comment on column sessions.ip_address is '创建会话时的用户 IP 地址。';

comment on column sessions.user_agent is '创建会话时的用户代理字符串（浏览器信息）。';

comment on column sessions.expires_at is '会话的过期时间。';

comment on column sessions.created_at is '会话的创建时间。';

alter table sessions
    owner to root;

create index idx_sessions_user_id
    on sessions (user_id);

create index idx_sessions_session_token
    on sessions (session_token);

