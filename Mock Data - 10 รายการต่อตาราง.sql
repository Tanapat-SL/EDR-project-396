-- =========================================================
-- 1. USER (10 รายการ)
-- =========================================================
INSERT INTO "User" ("discordId", "username", "displayName", "email", "timezone", "updatedAt") VALUES
('user_001', 'alpha_player', 'Alpha', 'alpha@mail.com', 'Asia/Bangkok', CURRENT_TIMESTAMP),
('user_002', 'beta_gamer', 'Beta', 'beta@mail.com', 'Asia/Bangkok', CURRENT_TIMESTAMP),
('user_003', 'charlie_pro', 'Charlie', 'charlie@mail.com', 'Asia/Bangkok', CURRENT_TIMESTAMP),
('user_004', 'delta_noob', 'Delta', 'delta@mail.com', 'Asia/Bangkok', CURRENT_TIMESTAMP),
('user_005', 'echo_tank', 'Echo', 'echo@mail.com', 'Asia/Bangkok', CURRENT_TIMESTAMP),
('user_006', 'foxtrot_heal', 'Foxtrot', 'foxtrot@mail.com', 'Asia/Bangkok', CURRENT_TIMESTAMP),
('user_007', 'golf_sniper', 'Golf', 'golf@mail.com', 'Asia/Bangkok', CURRENT_TIMESTAMP),
('user_008', 'hotel_carry', 'Hotel', 'hotel@mail.com', 'Asia/Bangkok', CURRENT_TIMESTAMP),
('user_009', 'india_support', 'India', 'india@mail.com', 'Asia/Bangkok', CURRENT_TIMESTAMP),
('user_010', 'juliet_afk', 'Juliet', 'juliet@mail.com', 'Asia/Bangkok', CURRENT_TIMESTAMP);

-- =========================================================
-- 2. GAME (10 รายการ)
-- =========================================================
INSERT INTO "Game" ("name", "slug", "ranks") VALUES
('Valorant', 'valorant', '{"Iron", "Bronze", "Silver", "Gold", "Platinum", "Diamond", "Ascendant", "Immortal", "Radiant"}'),
('Apex Legends', 'apex-legends', '{"Bronze", "Silver", "Gold", "Platinum", "Diamond", "Master", "Predator"}'),
('Overwatch 2', 'overwatch-2', '{"Bronze", "Silver", "Gold", "Platinum", "Diamond", "Master", "Grandmaster"}'),
('Dota 2', 'dota-2', '{"Herald", "Guardian", "Crusader", "Archon", "Legend", "Ancient", "Divine", "Immortal"}'),
('CS:GO', 'csgo', '{"Silver I", "Silver II", "Gold Nova", "Master Guardian", "Global Elite"}'),
('Minecraft', 'minecraft', '{}'),
('Genshin Impact', 'genshin-impact', '{}'),
('League of Legends', 'league-of-legends', '{"Iron", "Bronze", "Silver", "Gold", "Platinum", "Emerald", "Diamond", "Master", "Grandmaster", "Challenger"}'),
('Fortnite', 'fortnite', '{"Bronze", "Silver", "Gold", "Platinum", "Diamond", "Elite", "Champion", "Unreal"}'),
('Roblox', 'roblox', '{}');

-- =========================================================
-- 3. USER_GAME (10 รายการ)
-- =========================================================
INSERT INTO "UserGame" ("userId", "gameId", "rank", "platform", "playStyle") VALUES
(1, 1, 'Radiant', 'PC', 'COMPETITIVE'),
(2, 1, 'Gold', 'PC', 'LEARNING'),
(3, 2, 'Predator', 'PLAYSTATION', 'COMPETITIVE'),
(4, 3, 'Silver', 'PC', 'CASUAL'),
(5, 3, 'Grandmaster', 'PC', 'COMPETITIVE'),
(6, 4, 'Immortal', 'PC', 'COMPETITIVE'),
(7, 6, NULL, 'XBOX', 'CHILL'),
(8, 7, NULL, 'MOBILE', 'CHILL'),
(9, 8, 'Gold', 'PC', 'CASUAL'),
(10, 9, 'Unreal', 'PC', 'COMPETITIVE');

-- =========================================================
-- 4. AVAILABILITY (10 รายการ)
-- =========================================================
INSERT INTO "Availability" ("userId", "dayOfWeek", "startTime", "endTime") VALUES
(1, 1, '18:00', '22:00'), (2, 2, '19:00', '23:00'),
(3, 3, '20:00', '24:00'), (4, 4, '17:00', '21:00'),
(5, 5, '18:00', '23:00'), (6, 6, '10:00', '15:00'),
(7, 0, '09:00', '12:00'), (8, 1, '21:00', '01:00'),
(9, 2, '18:30', '20:30'), (10, 5, '22:00', '02:00');

-- =========================================================
-- 5. PARTY (10 รายการ)
-- =========================================================
INSERT INTO "Party" ("ownerId", "gameId", "title", "mode", "maxMembers", "status", "updatedAt") VALUES
(1, 1, 'Pushing to Radiant', 'RANKED', 5, 'OPEN', CURRENT_TIMESTAMP),
(2, 1, 'Chill Unrated', 'CASUAL', 5, 'OPEN', CURRENT_TIMESTAMP),
(3, 2, 'Predator grind', 'RANKED', 3, 'FULL', CURRENT_TIMESTAMP),
(4, 3, 'QP for fun', 'CASUAL', 5, 'OPEN', CURRENT_TIMESTAMP),
(5, 3, 'Comp tryhard', 'RANKED', 5, 'OPEN', CURRENT_TIMESTAMP),
(6, 4, 'Climbing to Immortal', 'RANKED', 5, 'OPEN', CURRENT_TIMESTAMP),
(7, 6, 'Survival new world', 'COOP', 10, 'OPEN', CURRENT_TIMESTAMP),
(8, 7, 'Boss farming', 'COOP', 4, 'CLOSED', CURRENT_TIMESTAMP),
(9, 8, 'ARAM all day', 'CASUAL', 5, 'OPEN', CURRENT_TIMESTAMP),
(10, 9, 'Zero Build Duo', 'RANKED', 2, 'OPEN', CURRENT_TIMESTAMP);

-- =========================================================
-- 6. PARTY_MEMBER (10 รายการ)
-- =========================================================
INSERT INTO "PartyMember" ("partyId", "userId", "role", "status", "updatedAt") VALUES
(1, 1, 'OWNER', 'ACCEPTED', CURRENT_TIMESTAMP),
(1, 2, 'MEMBER', 'ACCEPTED', CURRENT_TIMESTAMP),
(2, 2, 'OWNER', 'ACCEPTED', CURRENT_TIMESTAMP),
(2, 3, 'MEMBER', 'PENDING', CURRENT_TIMESTAMP),
(3, 3, 'OWNER', 'ACCEPTED', CURRENT_TIMESTAMP),
(3, 4, 'MEMBER', 'ACCEPTED', CURRENT_TIMESTAMP),
(4, 4, 'OWNER', 'ACCEPTED', CURRENT_TIMESTAMP),
(5, 5, 'OWNER', 'ACCEPTED', CURRENT_TIMESTAMP),
(7, 7, 'OWNER', 'ACCEPTED', CURRENT_TIMESTAMP),
(10, 10, 'OWNER', 'ACCEPTED', CURRENT_TIMESTAMP);

-- =========================================================
-- 7. CONVERSATION (10 รายการ)
-- 5 แบบปาร์ตี้ (PARTY) และ 5 แบบคุยส่วนตัว (DIRECT)
-- =========================================================
INSERT INTO "Conversation" ("type", "partyId") VALUES
('PARTY', 1), ('PARTY', 2), ('PARTY', 3), ('PARTY', 4), ('PARTY', 5),
('DIRECT', NULL), ('DIRECT', NULL), ('DIRECT', NULL), ('DIRECT', NULL), ('DIRECT', NULL);

-- =========================================================
-- 8. CONVERSATION_MEMBER (10 รายการ)
-- =========================================================
INSERT INTO "ConversationMember" ("conversationId", "userId") VALUES
(1, 1), (1, 2), -- ห้อง Party 1
(2, 2), (2, 3), -- ห้อง Party 2
(3, 3), (3, 4), -- ห้อง Party 3
(6, 1), (6, 5), -- ห้อง Direct (User 1 คุยกับ User 5)
(7, 2), (7, 6); -- ห้อง Direct (User 2 คุยกับ User 6)

-- =========================================================
-- 9. MESSAGE (10 รายการ)
-- =========================================================
INSERT INTO "Message" ("conversationId", "senderId", "content") VALUES
(1, 1, 'Ready to push rank?'),
(1, 2, 'Yeah, let me invite one more.'),
(2, 2, 'Just a chill game guys.'),
(3, 3, 'Need a healer!'),
(3, 4, 'I can play support.'),
(6, 1, 'Hey, want to duo later?'),
(6, 5, 'Sure, what time?'),
(7, 2, 'Did you complete the weekly quest?'),
(7, 6, 'Not yet, need to farm a bit more.'),
(1, 1, 'Let''s go!');

-- =========================================================
-- 10. NOTIFICATION (10 รายการ)
-- =========================================================
INSERT INTO "Notification" ("userId", "type", "payload") VALUES
(1, 'PARTY_JOIN_REQUEST', '{"partyId": 1, "userId": 2}'),
(2, 'PARTY_REQUEST_ACCEPTED', '{"partyId": 1}'),
(3, 'FRIEND_REQUEST', '{"userId": 4}'),
(4, 'FRIEND_REQUEST_ACCEPTED', '{"userId": 3}'),
(5, 'NEW_MESSAGE', '{"conversationId": 6, "senderId": 1}'),
(6, 'NEW_MESSAGE', '{"conversationId": 7, "senderId": 2}'),
(7, 'PARTY_INVITE', '{"partyId": 7, "inviterId": 8}'),
(8, 'PARTY_REQUEST_REJECTED', '{"partyId": 8}'),
(9, 'FRIEND_REQUEST', '{"userId": 10}'),
(10, 'PARTY_JOIN_REQUEST', '{"partyId": 10, "userId": 9}');

-- =========================================================
-- 11. FRIEND_REQUEST (10 รายการ)
-- =========================================================
INSERT INTO "FriendRequest" ("requesterId", "receiverId", "status", "updatedAt") VALUES
(1, 2, 'ACCEPTED', CURRENT_TIMESTAMP),
(2, 3, 'PENDING', CURRENT_TIMESTAMP),
(3, 4, 'ACCEPTED', CURRENT_TIMESTAMP),
(4, 5, 'REJECTED', CURRENT_TIMESTAMP),
(5, 6, 'PENDING', CURRENT_TIMESTAMP),
(6, 7, 'ACCEPTED', CURRENT_TIMESTAMP),
(7, 8, 'PENDING', CURRENT_TIMESTAMP),
(8, 9, 'REJECTED', CURRENT_TIMESTAMP),
(9, 10, 'ACCEPTED', CURRENT_TIMESTAMP),
(10, 1, 'PENDING', CURRENT_TIMESTAMP);

-- =========================================================
-- 12. USER_BLOCK (10 รายการ)
-- =========================================================
INSERT INTO "UserBlock" ("blockerId", "blockedId") VALUES
(1, 10), (2, 9), (3, 8), (4, 7), (5, 6),
(6, 5), (7, 4), (8, 3), (9, 2), (10, 1);

-- =========================================================
-- 13. REPORT (10 รายการ)
-- =========================================================
INSERT INTO "Report" ("reporterId", "targetUserId", "category", "reason", "status") VALUES
(1, 10, 'AFK', 'Went AFK in competitive match', 'OPEN'),
(2, 9, 'TOXIC', 'Cursing in voice chat', 'REVIEWED'),
(3, 8, 'PROFANITY', 'Inappropriate text messages', 'DISMISSED'),
(4, 7, 'DISRUPTION', 'Trolling and throwing the game', 'OPEN'),
(5, 6, 'HARASSMENT', 'Following and griefing', 'REVIEWED'),
(6, 5, 'TOXIC', 'Screaming in mic', 'OPEN'),
(7, 4, 'AFK', 'Left the party mid-game', 'DISMISSED'),
(8, 3, 'DISRUPTION', 'Refused to communicate', 'OPEN'),
(9, 2, 'PROFANITY', 'Spamming bad words', 'REVIEWED'),
(10, 1, 'HARASSMENT', 'Targeted harassment', 'OPEN');

-- =========================================================
-- 14. BAN_APPEAL (10 รายการ)
-- =========================================================
INSERT INTO "BanAppeal" ("userId", "message", "status") VALUES
(1, 'I was falsely banned due to a power outage.', 'OPEN'),
(2, 'My little brother used my account, please unban.', 'REJECTED'),
(3, 'I apologize for my behavior, it won''t happen again.', 'APPROVED'),
(4, 'I got banned for no reason!', 'OPEN'),
(5, 'I didn''t know that was against the rules, sorry.', 'REJECTED'),
(6, 'My internet dropped, I didn''t leave on purpose.', 'APPROVED'),
(7, 'Please give me another chance.', 'OPEN'),
(8, 'I was hacked, that wasn''t me typing those things.', 'REJECTED'),
(9, 'I have reformed and read the guidelines.', 'APPROVED'),
(10, 'I want to play with my friends again, please unban.', 'OPEN');