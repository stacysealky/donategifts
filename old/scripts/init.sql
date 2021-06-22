CREATE TABLE IF NOT EXISTS Address
(
    id        int PRIMARY KEY AUTO_INCREMENT,
    address1  varchar(255) not null,
    address2  varchar(255) null,
    city      varchar(255) not null,
    country   varchar(255) not null,
    state     varchar(255) not null,
    createdAt timestamp DEFAULT CURRENT_TIMESTAMP,
    updatedAt timestamp ON UPDATE CURRENT_TIMESTAMP,
    deletedAt datetime     null
);

CREATE TABLE IF NOT EXISTS Child
(
    id        int PRIMARY KEY AUTO_INCREMENT,
    birthday  date         not null,
    firstName varchar(255) not null,
    lastName  varchar(255) null,
    interest  varchar(255) not null,
    bio       varchar(255) null,
    addressId int          not null,
    createdAt timestamp DEFAULT CURRENT_TIMESTAMP,
    updatedAt timestamp ON UPDATE CURRENT_TIMESTAMP,
    deletedAt datetime     null,
    FOREIGN KEY (addressId) REFERENCES Address (id)
);

CREATE TABLE IF NOT EXISTS User
(
    id                        int PRIMARY KEY AUTO_INCREMENT,
    firstName                 varchar(255)                       not null,
    lastName                  varchar(255)                       not null,
    profileImage			  varchar(255)						 null,
    email                     varchar(255)                       unique not null,
    emailVerified             boolean                            default false not null,
    emailVerificationHash     varchar(255)                       unique null,
    role                      enum ('donor', 'partner', 'admin') not null,
    loginMode                    enum ('Facebook', 'Google', 'Default') not null,
    password                  varchar(255)                       not null,
    passwordResetToken        varchar(255)                       unique null,
    passwordResetTokenExpires datetime                           null,
    createdAt                 timestamp DEFAULT CURRENT_TIMESTAMP,
    updatedAt                 timestamp ON UPDATE CURRENT_TIMESTAMP,
    deletedAt                 datetime                           null
);

CREATE TABLE IF NOT EXISTS Agency
(
    id         int PRIMARY KEY AUTO_INCREMENT,
    name       varchar(255) not null,
    bio        varchar(255) null,
    isVerified boolean      default false not null,
    phone      varchar(255) not null,
    website    varchar(255) null,
    addressId  int          unique not null,
    createdAt  timestamp DEFAULT CURRENT_TIMESTAMP,
    updatedAt  timestamp ON UPDATE CURRENT_TIMESTAMP,
    deletedAt  datetime     null
);

CREATE TABLE IF NOT EXISTS AgencyMembers
(
	agencyId 	int			not null,
	userId		int			not null,
	role		enum('admin', 'member') not null,
	CONSTRAINT id PRIMARY KEY (agencyId, userId),
	FOREIGN KEY (agencyId) REFERENCES Agency (id),
	FOREIGN KEY (userId) REFERENCES User (id)
);

CREATE TABLE IF NOT EXISTS Wishcard
(
    id            int PRIMARY KEY AUTO_INCREMENT,
    image         varchar(255)                         not null,
    itemPrice     float                                not null,
    itemUrl       varchar(255)                         not null,
    childId       int                                  not null,
    agencyId      int                                  not null,
    createdBy     int                                  not null,
    isLockedBy    int                                  null,
    isLockedUntil datetime                             null,
    status        enum ('draft','published','donated') not null,
    occasion      varchar(255)                         null,
    createdAt     timestamp DEFAULT CURRENT_TIMESTAMP,
    updatedAt     timestamp ON UPDATE CURRENT_TIMESTAMP,
    deletedAt     datetime                             null,
    FOREIGN KEY (agencyId) REFERENCES Agency (id),
    FOREIGN KEY (createdBy) REFERENCES User (id),
    FOREIGN KEY (isLockedBy) REFERENCES User (id),
    FOREIGN KEY (childId) REFERENCES Child (id)
);

CREATE TABLE IF NOT EXISTS Message
(
    id         int PRIMARY KEY AUTO_INCREMENT,
    userId     int          not null,
    wishcardId int          not null,
    message    varchar(255) not null,
    createdAt  timestamp DEFAULT CURRENT_TIMESTAMP,
    updatedAt  timestamp ON UPDATE CURRENT_TIMESTAMP,
    deletedAt  datetime     null,
    FOREIGN KEY (userId) REFERENCES User (id),
    FOREIGN KEY (wishcardId) REFERENCES Wishcard (id)
);

CREATE TABLE IF NOT EXISTS Donation
(
    id         int PRIMARY KEY AUTO_INCREMENT,
    wishcardId int                                        not null,
    userId     int                                        not null,
    amount     float                                      not null,
    status     enum ('confirmed', 'ordered', 'delivered') not null,
    createdAt  timestamp DEFAULT CURRENT_TIMESTAMP,
    updatedAt  timestamp ON UPDATE CURRENT_TIMESTAMP,
    deletedAt  datetime                                   null,
    FOREIGN KEY (userId) REFERENCES User (id),
    FOREIGN KEY (wishcardId) REFERENCES Wishcard (id)
);

ALTER TABLE Agency
    ADD FOREIGN KEY (addressId) REFERENCES Address (id);