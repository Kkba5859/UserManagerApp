CREATE TABLE IF NOT EXISTS "__EFMigrationsHistory" (
    "MigrationId" character varying(150) NOT NULL,
    "ProductVersion" character varying(32) NOT NULL,
    CONSTRAINT "PK___EFMigrationsHistory" PRIMARY KEY ("MigrationId")
);

START TRANSACTION;


DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20240917122040_InitialCreate') THEN
    CREATE TABLE "Roles" (
        "Id" nvarchar(450) NOT NULL,
        "Name" nvarchar(256),
        "NormalizedName" nvarchar(256),
        "ConcurrencyStamp" nvarchar(max),
        CONSTRAINT "PK_Roles" PRIMARY KEY ("Id")
    );
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20240917122040_InitialCreate') THEN
    CREATE TABLE "Users" (
        "Id" nvarchar(450) NOT NULL,
        "RegistrationDate" datetime2 NOT NULL DEFAULT (GETDATE()),
        "LastLoginDate" datetime2,
        "IsBlocked" bit NOT NULL,
        "UserName" nvarchar(256),
        "NormalizedUserName" nvarchar(256),
        "Email" nvarchar(256),
        "NormalizedEmail" nvarchar(256),
        "EmailConfirmed" bit NOT NULL,
        "PasswordHash" nvarchar(max),
        "SecurityStamp" nvarchar(max),
        "ConcurrencyStamp" nvarchar(max),
        "PhoneNumber" nvarchar(max),
        "PhoneNumberConfirmed" bit NOT NULL,
        "TwoFactorEnabled" bit NOT NULL,
        "LockoutEnd" datetimeoffset,
        "LockoutEnabled" bit NOT NULL,
        "AccessFailedCount" int NOT NULL,
        CONSTRAINT "PK_Users" PRIMARY KEY ("Id")
    );
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20240917122040_InitialCreate') THEN
    CREATE TABLE "RoleClaims" (
        "Id" int NOT NULL,
        "RoleId" nvarchar(450) NOT NULL,
        "ClaimType" nvarchar(max),
        "ClaimValue" nvarchar(max),
        CONSTRAINT "PK_RoleClaims" PRIMARY KEY ("Id"),
        CONSTRAINT "FK_RoleClaims_Roles_RoleId" FOREIGN KEY ("RoleId") REFERENCES "Roles" ("Id") ON DELETE CASCADE
    );
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20240917122040_InitialCreate') THEN
    CREATE TABLE "UserClaims" (
        "Id" int NOT NULL,
        "UserId" nvarchar(450) NOT NULL,
        "ClaimType" nvarchar(max),
        "ClaimValue" nvarchar(max),
        CONSTRAINT "PK_UserClaims" PRIMARY KEY ("Id"),
        CONSTRAINT "FK_UserClaims_Users_UserId" FOREIGN KEY ("UserId") REFERENCES "Users" ("Id") ON DELETE CASCADE
    );
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20240917122040_InitialCreate') THEN
    CREATE TABLE "UserLogins" (
        "LoginProvider" nvarchar(128) NOT NULL,
        "ProviderKey" nvarchar(128) NOT NULL,
        "ProviderDisplayName" nvarchar(max),
        "UserId" nvarchar(450) NOT NULL,
        CONSTRAINT "PK_UserLogins" PRIMARY KEY ("LoginProvider", "ProviderKey"),
        CONSTRAINT "FK_UserLogins_Users_UserId" FOREIGN KEY ("UserId") REFERENCES "Users" ("Id") ON DELETE CASCADE
    );
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20240917122040_InitialCreate') THEN
    CREATE TABLE "UserRoles" (
        "UserId" nvarchar(450) NOT NULL,
        "RoleId" nvarchar(450) NOT NULL,
        CONSTRAINT "PK_UserRoles" PRIMARY KEY ("UserId", "RoleId"),
        CONSTRAINT "FK_UserRoles_Roles_RoleId" FOREIGN KEY ("RoleId") REFERENCES "Roles" ("Id") ON DELETE CASCADE,
        CONSTRAINT "FK_UserRoles_Users_UserId" FOREIGN KEY ("UserId") REFERENCES "Users" ("Id") ON DELETE CASCADE
    );
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20240917122040_InitialCreate') THEN
    CREATE TABLE "UserTokens" (
        "UserId" nvarchar(450) NOT NULL,
        "LoginProvider" nvarchar(128) NOT NULL,
        "Name" nvarchar(128) NOT NULL,
        "Value" nvarchar(max),
        CONSTRAINT "PK_UserTokens" PRIMARY KEY ("UserId", "LoginProvider", "Name"),
        CONSTRAINT "FK_UserTokens_Users_UserId" FOREIGN KEY ("UserId") REFERENCES "Users" ("Id") ON DELETE CASCADE
    );
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20240917122040_InitialCreate') THEN
    CREATE INDEX "IX_RoleClaims_RoleId" ON "RoleClaims" ("RoleId");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20240917122040_InitialCreate') THEN
    CREATE UNIQUE INDEX "RoleNameIndex" ON "Roles" ("NormalizedName") WHERE [NormalizedName] IS NOT NULL;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20240917122040_InitialCreate') THEN
    CREATE INDEX "IX_UserClaims_UserId" ON "UserClaims" ("UserId");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20240917122040_InitialCreate') THEN
    CREATE INDEX "IX_UserLogins_UserId" ON "UserLogins" ("UserId");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20240917122040_InitialCreate') THEN
    CREATE INDEX "IX_UserRoles_RoleId" ON "UserRoles" ("RoleId");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20240917122040_InitialCreate') THEN
    CREATE INDEX "EmailIndex" ON "Users" ("NormalizedEmail");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20240917122040_InitialCreate') THEN
    CREATE UNIQUE INDEX "UserNameIndex" ON "Users" ("NormalizedUserName") WHERE [NormalizedUserName] IS NOT NULL;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20240917122040_InitialCreate') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20240917122040_InitialCreate', '8.0.8');
    END IF;
END $EF$;
COMMIT;

START TRANSACTION;


DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20240917130613_InitialCreate2') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20240917130613_InitialCreate2', '8.0.8');
    END IF;
END $EF$;
COMMIT;

