create table users
(
    id                      uuid                     default gen_random_uuid()           not null
        primary key,
    email                   varchar(255)                                                 not null
        unique,
    password_hash           varchar(255),
    salt                    varchar(255),
    username                varchar(255)
        unique,
    phone_number            varchar(20),
    first_name              varchar(100),
    last_name               varchar(100),
    profile_picture_url     text,
    preferred_language_code varchar(10)              default 'en'::character varying     not null,
    status                  varchar(50)              default 'active'::character varying not null,
    last_login_at           timestamp with time zone,
    login_attempts          integer                  default 0                           not null,
    locked_until            timestamp with time zone,
    created_at              timestamp with time zone default CURRENT_TIMESTAMP,
    updated_at              timestamp with time zone default CURRENT_TIMESTAMP,
    encrypted_email         bytea,
    email_iv                bytea,
    email_auth_tag          bytea,
    encrypted_phone_number  bytea,
    phone_number_iv         bytea,
    phone_number_auth_tag   bytea,
    encrypted_username      bytea,
    username_iv             bytea,
    username_auth_tag       bytea,
    blacklisted_info        jsonb,
    user_attributes_data    jsonb,
    involved_field          varchar(100)
);

comment on table users is '
存储用户的基本信息，包括认证凭据、个人资料、安全相关字段以及黑名单和自定义属性信息。
注意：为了满足在单表中集成所有功能的需求，部分复杂关系（如黑名单分组/标签、用户属性）通过 JSONB 字段实现。这可能导致查询和维护的复杂性增加。
';

comment on column users.id is '用户的全局唯一标识符。';

comment on column users.email is '
用户的电子邮件地址。
注意事项：
1. **如果此字段被加密存储于 encrypted_email，则此明文字段可用于存储脱敏数据、哈希值（用于唯一性检查和登录）或在迁移后删除。**
2. 数据库对加密字段无法直接进行唯一性检查或索引，因此如果需要邮箱唯一且可查询，需额外考虑。
';

comment on column users.password_hash is '存储用户密码的哈希值，绝不存储明文密码。';

comment on column users.salt is '用于密码哈希的随机盐值，增强密码安全性。';

comment on column users.username is '
用户的唯一用户名。
注意事项：
1. **如果此字段被加密存储于 encrypted_username，则此明文字段通常用于存储用户名的哈希值（用于登录认证和唯一性检查），因为加密字段无法直接查询。**
2. 用户名通常作为登录凭证，对其进行完全加密会极大地增加登录流程的复杂性（需解密所有用户名进行比对），因此通常建议存储哈希值进行认证。
';

comment on column users.phone_number is '
用户的手机号码。
注意事项：
1. **如果此字段被加密存储于 encrypted_phone_number，则此明文字段可用于存储脱敏数据、哈希值或在迁移后删除。**
2. 数据库对加密字段无法直接进行唯一性检查或索引。
';

comment on column users.first_name is '用户名字。';

comment on column users.last_name is '用户姓氏。';

comment on column users.profile_picture_url is '用户头像图片的 URL。';

comment on column users.preferred_language_code is '用户偏好的语言代码（例如: en, zh-CN, fr），用于界面多语言显示。';

comment on column users.status is '用户账户的状态（例如: active, inactive, suspended, locked）。';

comment on column users.last_login_at is '用户最后一次成功登录的时间。';

comment on column users.login_attempts is '记录用户连续登录失败的次数，用于触发账户锁定。';

comment on column users.locked_until is '如果账户被锁定，此字段记录解锁时间。';

comment on column users.created_at is '用户账户的创建时间。';

comment on column users.updated_at is '用户账户信息最后更新的时间。';

comment on column users.encrypted_email is '
加密后的用户电子邮件地址的二进制数据。
**此字段是应用层加密后的密文，数据库无法直接读取其内容。**
';

comment on column users.email_iv is '
用于加密用户电子邮件地址的初始化向量 (Initialization Vector, IV)。
每次加密操作都需要生成一个唯一的 IV 并与密文一同存储。
';

comment on column users.email_auth_tag is '
(可选) 用于加密用户电子邮件地址的认证标签 (Authentication Tag)。
当使用 AEAD (Authenticated Encryption with Associated Data) 加密模式（如 AES-GCM）时生成，用于验证密文的完整性和真实性。
';

comment on column users.encrypted_phone_number is '
加密后的用户手机号码的二进制数据。
**此字段是应用层加密后的密文。**
';

comment on column users.phone_number_iv is '用于加密用户手机号码的初始化向量。';

comment on column users.phone_number_auth_tag is '(可选) 用于手机号码加密的认证标签。';

comment on column users.encrypted_username is '
加密后的用户名的二进制数据。
**此字段是应用层加密后的密文，主要用于在需要时可逆地还原用户名（例如显示在用户资料页）。**
';

comment on column users.username_iv is '用于加密用户名的初始化向量。';

comment on column users.username_auth_tag is '(可选) 用于用户名加密的认证标签。';

comment on column users.blacklisted_info is '
用户的黑名单信息。
格式：JSONB 对象。示例:
{
  "is_blacklisted": true,
  "reason": "多次违规操作",
  "expires_at": "2025-12-31T23:59:59Z",
  "groups": ["作弊用户", "高风险"],
  "tags": ["暴力破解", "滥用API"],
  "blocked_by": "admin_user_uuid"
}
此字段的维护和查询逻辑完全在应用层实现。
';

comment on column users.user_attributes_data is '
用户的自定义属性（标签）数据。
格式：JSONB 对象。示例:
{
  "category1": ["attribute1", "attribute2"],
  "category2": ["attribute3"]
}
或者更简单的数组：["VIP客户", "活跃用户", "参与测试"]。
此字段的维护和查询逻辑完全在应用层实现。
';

comment on column users.involved_field is '
触发黑名单操作或与此黑名单条目直接相关的用户字段（例如：当基于邮箱域名拉黑时，记录为“email”）。
此字段仅当用户被拉黑时才相关。
';

alter table users
    owner to root;

create index idx_users_email
    on users (email);

create index idx_users_username
    on users (username);

