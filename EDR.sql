-- =========================================================
-- ENUMS (ประเภทข้อมูลที่กำหนดค่าเฉพาะ)
-- =========================================================
CREATE TYPE "Platform" AS ENUM ('PC','PLAYSTATION','XBOX','SWITCH','MOBILE');
CREATE TYPE "PlayStyle" AS ENUM ('COMPETITIVE','CASUAL','CHILL','LEARNING');
CREATE TYPE "GameMode" AS ENUM ('RANKED','CASUAL','COOP','CUSTOM');
CREATE TYPE "PartyStatus" AS ENUM ('OPEN','FULL','CLOSED');
CREATE TYPE "PartyRole" AS ENUM ('OWNER','MEMBER');
CREATE TYPE "MemberStatus" AS ENUM ('PENDING','ACCEPTED','REJECTED','LEFT','KICKED');
CREATE TYPE "ConversationType" AS ENUM ('PARTY','DIRECT');
CREATE TYPE "NotificationType" AS ENUM ('PARTY_JOIN_REQUEST','PARTY_REQUEST_ACCEPTED','PARTY_REQUEST_REJECTED','NEW_MESSAGE','PARTY_INVITE','FRIEND_REQUEST','FRIEND_REQUEST_ACCEPTED');
CREATE TYPE "FriendRequestStatus" AS ENUM ('PENDING','ACCEPTED','REJECTED');
CREATE TYPE "ReportStatus" AS ENUM ('OPEN','REVIEWED','DISMISSED');
CREATE TYPE "ReportCategory" AS ENUM ('PROFANITY','TOXIC','AFK','DISRUPTION','HARASSMENT');
CREATE TYPE "BanAppealStatus" AS ENUM ('OPEN','APPROVED','REJECTED');

-- =========================================================
-- 1. USER
-- =========================================================
CREATE TABLE "User" (
  "id" SERIAL PRIMARY KEY,
  "discordId" TEXT NOT NULL,
  "username" TEXT NOT NULL,
  "displayName" TEXT,
  "email" TEXT,
  "avatarUrl" TEXT,
  "bio" VARCHAR(500),
  "languages" TEXT[] NOT NULL DEFAULT ARRAY[]::TEXT[],
  "timezone" TEXT NOT NULL DEFAULT 'Asia/Bangkok',
  "contact" TEXT,
  "profanityWarnings" INTEGER NOT NULL DEFAULT 0,
  "chatMutedUntil" TIMESTAMP(3),
  "isBanned" BOOLEAN NOT NULL DEFAULT false,
  "bannedAt" TIMESTAMP(3),
  "banReason" VARCHAR(500),
  "bannedByDiscordId" TEXT,
  "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "updatedAt" TIMESTAMP(3) NOT NULL,

  CONSTRAINT uq_user_discord_id UNIQUE ("discordId"),
  CONSTRAINT uq_user_email UNIQUE ("email")
);

-- =========================================================
-- 2. GAME
-- =========================================================
CREATE TABLE "Game" (
  "id" SERIAL PRIMARY KEY,
  "name" TEXT NOT NULL,
  "slug" TEXT NOT NULL,
  "imageUrl" TEXT,
  "ranks" TEXT[] NOT NULL DEFAULT ARRAY[]::TEXT[],

  CONSTRAINT uq_game_name UNIQUE ("name"),
  CONSTRAINT uq_game_slug UNIQUE ("slug")
);

-- =========================================================
-- 3. USER_GAME
-- =========================================================
CREATE TABLE "UserGame" (
  "id" SERIAL PRIMARY KEY,
  "userId" INTEGER NOT NULL,
  "gameId" INTEGER NOT NULL,
  "rank" TEXT,
  "platform" "Platform" NOT NULL DEFAULT 'PC',
  "playStyle" "PlayStyle" NOT NULL DEFAULT 'CASUAL',
  "micEnabled" BOOLEAN NOT NULL DEFAULT true,

  CONSTRAINT fk_usergame_user FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT fk_usergame_game FOREIGN KEY ("gameId") REFERENCES "Game"("id") ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT uq_userid_gameid UNIQUE ("userId","gameId")
);

-- =========================================================
-- 4. AVAILABILITY
-- =========================================================
CREATE TABLE "Availability" (
  "id" SERIAL PRIMARY KEY,
  "userId" INTEGER NOT NULL,
  "dayOfWeek" INTEGER NOT NULL,
  "startTime" TEXT NOT NULL,
  "endTime" TEXT NOT NULL,

  CONSTRAINT fk_availability_user FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE
);

-- =========================================================
-- 5. PARTY
-- =========================================================
CREATE TABLE "Party" (
  "id" SERIAL PRIMARY KEY,
  "ownerId" INTEGER NOT NULL,
  "gameId" INTEGER NOT NULL,
  "title" VARCHAR(100) NOT NULL,
  "description" VARCHAR(1000),
  "mode" "GameMode" NOT NULL DEFAULT 'CASUAL',
  "rankMin" TEXT,
  "rankMax" TEXT,
  "maxMembers" INTEGER NOT NULL DEFAULT 5,
  "micRequired" BOOLEAN NOT NULL DEFAULT false,
  "language" TEXT,
  "region" TEXT,
  "bumpedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "status" "PartyStatus" NOT NULL DEFAULT 'OPEN',
  "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "updatedAt" TIMESTAMP(3) NOT NULL,

  CONSTRAINT fk_party_owner FOREIGN KEY ("ownerId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT fk_party_game FOREIGN KEY ("gameId") REFERENCES "Game"("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- =========================================================
-- 6. PARTY_MEMBER
-- =========================================================
CREATE TABLE "PartyMember" (
  "id" SERIAL PRIMARY KEY,
  "partyId" INTEGER NOT NULL,
  "userId" INTEGER NOT NULL,
  "role" "PartyRole" NOT NULL DEFAULT 'MEMBER',
  "status" "MemberStatus" NOT NULL DEFAULT 'PENDING',
  "message" VARCHAR(300),
  "joinedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "updatedAt" TIMESTAMP(3) NOT NULL,

  CONSTRAINT fk_partymember_party FOREIGN KEY ("partyId") REFERENCES "Party"("id") ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT fk_partymember_user FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT uq_party_user UNIQUE ("partyId","userId")
);

-- =========================================================
-- 7. CONVERSATION
-- =========================================================
CREATE TABLE "Conversation" (
  "id" SERIAL PRIMARY KEY,
  "type" "ConversationType" NOT NULL,
  "partyId" INTEGER,
  "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

  CONSTRAINT fk_conversation_party FOREIGN KEY ("partyId") REFERENCES "Party"("id") ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT uq_conversation_party UNIQUE ("partyId")
);

-- =========================================================
-- 8. CONVERSATION_MEMBER
-- =========================================================
CREATE TABLE "ConversationMember" (
  "conversationId" INTEGER NOT NULL,
  "userId" INTEGER NOT NULL,
  "lastReadAt" TIMESTAMP(3),

  CONSTRAINT pk_conversation_member PRIMARY KEY ("conversationId", "userId"),
  CONSTRAINT fk_convmember_conversation FOREIGN KEY ("conversationId") REFERENCES "Conversation"("id") ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT fk_convmember_user FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE
);

-- =========================================================
-- 9. MESSAGE
-- =========================================================
CREATE TABLE "Message" (
  "id" SERIAL PRIMARY KEY,
  "conversationId" INTEGER NOT NULL,
  "senderId" INTEGER NOT NULL,
  "content" VARCHAR(2000) NOT NULL,
  "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

  CONSTRAINT fk_message_conversation FOREIGN KEY ("conversationId") REFERENCES "Conversation"("id") ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT fk_message_sender FOREIGN KEY ("senderId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE
);

-- =========================================================
-- 10. NOTIFICATION
-- =========================================================
CREATE TABLE "Notification" (
  "id" SERIAL PRIMARY KEY,
  "userId" INTEGER NOT NULL,
  "type" "NotificationType" NOT NULL,
  "payload" JSONB NOT NULL,
  "readAt" TIMESTAMP(3),
  "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

  CONSTRAINT fk_notification_user FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE
);

-- =========================================================
-- 11. FRIEND_REQUEST
-- =========================================================
CREATE TABLE "FriendRequest" (
  "id" SERIAL PRIMARY KEY,
  "requesterId" INTEGER NOT NULL,
  "receiverId" INTEGER NOT NULL,
  "status" "FriendRequestStatus" NOT NULL DEFAULT 'PENDING',
  "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "updatedAt" TIMESTAMP(3) NOT NULL,

  CONSTRAINT fk_friendreq_requester FOREIGN KEY ("requesterId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT fk_friendreq_receiver FOREIGN KEY ("receiverId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT uq_friend_request UNIQUE ("requesterId", "receiverId")
);

-- =========================================================
-- 12. USER_BLOCK
-- =========================================================
CREATE TABLE "UserBlock" (
  "blockerId" INTEGER NOT NULL,
  "blockedId" INTEGER NOT NULL,
  "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

  CONSTRAINT pk_user_block PRIMARY KEY ("blockerId", "blockedId"),
  CONSTRAINT fk_userblock_blocker FOREIGN KEY ("blockerId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT fk_userblock_blocked FOREIGN KEY ("blockedId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE
);

-- =========================================================
-- 13. REPORT
-- =========================================================
CREATE TABLE "Report" (
  "id" SERIAL PRIMARY KEY,
  "reporterId" INTEGER NOT NULL,
  "targetUserId" INTEGER NOT NULL,
  "category" "ReportCategory" NOT NULL DEFAULT 'DISRUPTION',
  "reason" VARCHAR(1000) NOT NULL,
  "status" "ReportStatus" NOT NULL DEFAULT 'OPEN',
  "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

  CONSTRAINT fk_report_reporter FOREIGN KEY ("reporterId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT fk_report_target FOREIGN KEY ("targetUserId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE
);

-- =========================================================
-- 14. BAN_APPEAL
-- =========================================================
CREATE TABLE "BanAppeal" (
  "id" SERIAL PRIMARY KEY,
  "userId" INTEGER NOT NULL,
  "message" VARCHAR(2000) NOT NULL,
  "status" "BanAppealStatus" NOT NULL DEFAULT 'OPEN',
  "adminNote" VARCHAR(1000),
  "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "reviewedAt" TIMESTAMP(3),
  "reviewedByDiscordId" TEXT,

  CONSTRAINT fk_banappeal_user FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE
);