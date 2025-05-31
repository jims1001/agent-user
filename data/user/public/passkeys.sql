create table passkeys
(
    id               uuid                     default gen_random_uuid() not null
        primary key,
    user_id          uuid                                               not null
        references users
            on delete cascade,
    credential_id    text                                               not null
        unique,
    public_key       text                                               not null,
    attestation_type varchar(50)                                        not null,
    aaguid           uuid,
    sign_count       bigint                   default 0                 not null,
    transports       text[],
    created_at       timestamp with time zone default CURRENT_TIMESTAMP,
    last_used_at     timestamp with time zone
);

comment on table passkeys is '存储用户的 WebAuthn (Passkey) 凭据信息。';

comment on column passkeys.id is 'Passkey 记录的唯一标识符。';

comment on column passkeys.user_id is '关联到使用此 Passkey 的用户。';

comment on column passkeys.credential_id is '由 WebAuthn 认证器生成的凭据唯一 ID。';

comment on column passkeys.public_key is '与 Passkey 关联的公钥，用于验证认证签名。';

comment on column passkeys.attestation_type is '凭据的认证类型（例如: none, packed, fido-u2f）。';

comment on column passkeys.aaguid is '认证器厂商的全局唯一标识符。';

comment on column passkeys.sign_count is '认证器签名计数器，用于防止重放攻击。';

comment on column passkeys.transports is '支持此 Passkey 的传输方式（例如: usb, nfc, ble, internal）。';

comment on column passkeys.created_at is 'Passkey 凭据的创建时间。';

comment on column passkeys.last_used_at is '此 Passkey 最后一次成功使用的时间。';

alter table passkeys
    owner to root;

create index idx_passkeys_user_id
    on passkeys (user_id);

create index idx_passkeys_credential_id
    on passkeys (credential_id);

