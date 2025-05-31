package com.agent.user.repository.entitys;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.ColumnDefault;
import org.hibernate.annotations.JdbcTypeCode;
import org.hibernate.type.SqlTypes;

import java.time.OffsetDateTime;
import java.util.Map;
import java.util.UUID;

@Getter
@Setter
@Entity
@Table(name = "users", schema = "public")
public class User {
    @Id
    @ColumnDefault("gen_random_uuid()")
    @Column(name = "id", nullable = false)
    private UUID id;

    @Size(max = 255)
    @NotNull
    @Column(name = "email", nullable = false)
    private String email;

    @Size(max = 255)
    @Column(name = "password_hash")
    private String passwordHash;

    @Size(max = 255)
    @Column(name = "salt")
    private String salt;

    @Size(max = 255)
    @Column(name = "username")
    private String username;

    @Size(max = 20)
    @Column(name = "phone_number", length = 20)
    private String phoneNumber;

    @Size(max = 100)
    @Column(name = "first_name", length = 100)
    private String firstName;

    @Size(max = 100)
    @Column(name = "last_name", length = 100)
    private String lastName;

    @Column(name = "profile_picture_url", length = Integer.MAX_VALUE)
    private String profilePictureUrl;

    @Size(max = 10)
    @NotNull
    @ColumnDefault("'en'")
    @Column(name = "preferred_language_code", nullable = false, length = 10)
    private String preferredLanguageCode;

    @Size(max = 50)
    @NotNull
    @ColumnDefault("'active'")
    @Column(name = "status", nullable = false, length = 50)
    private String status;

    @Column(name = "last_login_at")
    private OffsetDateTime lastLoginAt;

    @NotNull
    @ColumnDefault("0")
    @Column(name = "login_attempts", nullable = false)
    private Integer loginAttempts;

    @Column(name = "locked_until")
    private OffsetDateTime lockedUntil;

    @ColumnDefault("CURRENT_TIMESTAMP")
    @Column(name = "created_at")
    private OffsetDateTime createdAt;

    @ColumnDefault("CURRENT_TIMESTAMP")
    @Column(name = "updated_at")
    private OffsetDateTime updatedAt;

    @Column(name = "encrypted_email")
    private byte[] encryptedEmail;

    @Column(name = "email_iv")
    private byte[] emailIv;

    @Column(name = "email_auth_tag")
    private byte[] emailAuthTag;

    @Column(name = "encrypted_phone_number")
    private byte[] encryptedPhoneNumber;

    @Column(name = "phone_number_iv")
    private byte[] phoneNumberIv;

    @Column(name = "phone_number_auth_tag")
    private byte[] phoneNumberAuthTag;

    @Column(name = "encrypted_username")
    private byte[] encryptedUsername;

    @Column(name = "username_iv")
    private byte[] usernameIv;

    @Column(name = "username_auth_tag")
    private byte[] usernameAuthTag;

    @Column(name = "blacklisted_info")
    @JdbcTypeCode(SqlTypes.JSON)
    private Map<String, Object> blacklistedInfo;

    @Column(name = "user_attributes_data")
    @JdbcTypeCode(SqlTypes.JSON)
    private Map<String, Object> userAttributesData;

    @Size(max = 100)
    @Column(name = "involved_field", length = 100)
    private String involvedField;

}