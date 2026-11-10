# Changelog

## Bug hunt
- **Checked everything automatically:** all 20 levels were played by a test (walking the maze, pressing every key, firing the stun gun, picking up items, getting caught, taking the elevator). Every main-menu button and its panels were also opened, the phone layout was checked, and every script was syntax-checked. **No errors** came up anywhere, and no two scripts fight over the same name.
- **Fix:** in Murder Mystery, a player who **leaves in the middle of a round** (10 s gone) now counts as out. Their unfinished tasks are dropped and the winner is checked again. Before, the round could never end if the Skin-Stealer left, or if a crewmate left with tasks undone.
- **Fix:** going to the next level past Level 19 now goes to the ending. In real play the game already did this; the level-change code itself is now safe too.
- The animated poster on the menu's MOVIE button no longer keeps checking the page layout while you play.

## Fix: "it says 4 keycards but there are only 3"
- On **Nightmare** and **Don't Look Back**, Levels 0–9 have one extra escape item, so the counter says 4. Before, that 4th keycard was tucked into the 3rd tape room's glass case together with the 3rd one, so it looked like there were only 3. **Now every keycard gets its own tape challenge room**: 4 rooms when the counter says 4 (Level 9 on those difficulties: 2 rooms).
- **Co-op fix:** shared keycards were matched by their position rounded to a whole metre, so two keycards in the same case counted as one for your teammates, who got stuck at 3/4. They're now matched to 0.1 m.
- **Safety net:** on Levels 0–9 the counter can never ask for more items than the level really has.

## Smoother: light budget + nothing drawn past the fog
- **Light budget:** before, every lamp in a level was worked out for every pixel on screen, even when it was switched off or 150 m away (the stun-gun flash, the flare, the three tape-room lamps, the elevator, glow sticks…). Level 0 had 9 of them. Now only a few real lights exist (**5 on High, 4 on Medium, 3 on Low** quality). Every frame they go to the lamps that matter right now: switched on, closest and brightest. The lamps still work exactly as before, and the number of real lights never changes, so nothing has to be rebuilt mid-game.
- **Draw distance follows the fog:** the camera used to draw everything up to 80 m, but the fog hides everything past about 35–40 m. Now the view ends where the fog is solid (it reaches further again when the fog thins). On Level 0 that's about **half the draw calls** (487 → about 250 per frame) with no visible difference.
- Measured on the test machine (software graphics, so real computers are much faster): Level 0 **9.7 → 12 fps**, Level 3 **14.8 → 17 fps**. The automatic resolution drop when frames get slow is still there on top of this.

## Co-op: up to 10 players
- Co-op rooms now hold **10 players** (it was 4). The menu, the room-full message, the public games list and the elevator TV all show /10.
- The co-op elevator has **10 spots** (three rows of three plus one by the doors), so everyone starts in their own place.
- **Murder Mystery:** 3–10 players, with **2 Skin-Stealers** from 6 players. The meeting screen lists everyone, and **bots** can now fill up to 9 spots (0, 1, 2, 3, 5, 7 or 9).
- Good to know: it's still peer-to-peer, so the host's computer and internet carry everyone. With 10 players the host needs a decent connection. Voice chat with many people uses more data; proximity voice helps. Only the 3 nearest teammates' flashlights cast real light, to keep the game smooth.

## Murder Mystery: bots
- **Bots fill empty spots:** in the co-op menu, Murder Mystery now has **🤖 BOTS: 0 / 1 / 2 / 3** (2 by default; 4 players in all). With 2 bots you can even play on your own. Bots show up for everyone like normal players, in a coloured hazmat suit, named "Bot …".
- **What bots do:**
  - walk the halls and do their tasks (each one goes for its nearest unfinished task and they spread out);
  - spot bodies, walk over and **report** them;
  - **vote** in meetings a few seconds in. A crew bot that **saw** someone strike votes for them, otherwise it follows the others, picks someone or skips.
- **A bot can be the Skin-Stealer:** it waits a while, then hunts someone who is **alone** (no one else in sight), sometimes in **monster form**, and walks away after striking. It does fake tasks to blend in.
- If a real player joins and the room is full, a bot leaves to make space. Bots never change in the middle of a round, and they don't vote to GIVE UP. Switching back to CO-OP ESCAPE removes them.
- The host's game runs the bots, and they go through the same checks as real players (distance, cooldown, who is still in).
- Fix: during a Murder Mystery round there's no more "X is DOWN!" message (it gave strikes away).

## Murder Mystery: no monsters, and the Skin-Stealer's monster form
- **No monsters at all in Murder Mystery:** the Boiled One, the ghost, the grinning thing in blackouts, the Follower, the mannequins and the locker scares are all switched off. The only danger is the Skin-Stealer.
- **Monster form:** the Skin-Stealer can **right-click** (phone: **🧟 MONSTER**) to turn into a monster for **15 seconds** (45 s cooldown, the HUD shows when it's ready). In monster form everyone else sees a monster instead of their suit, with **no name tag** and no flashlight. It can still strike with F. Meetings and the end of a round turn it back.
- **No give-aways:** during a round the player list shows no distances and doesn't say who is down (bodies have to be found), and teammates' dots and trails are hidden on the map.

## Co-op game modes + MURDER MYSTERY
- **Pick a game mode:** in the co-op menu the host chooses **🧭 CO-OP ESCAPE** (the normal game) or **🔪 MURDER MYSTERY**. Everyone in the room plays the mode the host picks, and friends who join later get it too.
- **Murder Mystery (3–4 players, like Among Us):** it plays on Level 0 with the monster switched off. In the game the host presses **▶ START ROUND**, and the elevator doors open.
  - One player is secretly the **SKIN-STEALER**. Each player only sees their own role.
  - **Crew:** finish your 3 tasks at the glowing green terminals (yellow **!** above them and on the map, hold **F** for 2.5 s). Report a body with **F**, or press the **red EMERGENCY button** near the start (once per round).
  - **Skin-Stealer:** walk up to someone and press **F** to strike (25 s cooldown, 15 s at the start and after meetings). Do fake tasks to blend in.
  - **Meetings:** everyone gets a voting screen for 40 s (talk on voice chat with Y). Vote for a player or SKIP. The player with the most votes is voted out, and everyone sees whether they WERE or were NOT the Skin-Stealer.
  - **Crew wins** when all crew tasks are done or the Skin-Stealer is voted out. **The Skin-Stealer wins** when there are as many of them as crew left. Out players watch the others. Then the host can start another round.
  - **No cheating:** the host's game is the referee. It deals the roles (players are only told their own), and checks every strike, report, vote and task (distance, cooldown, who is still in).
  - No Revival Scrolls and no elevator during Murder Mystery.

## Fun with friends + no tracker bar
- **Emote & quick-chat wheel (U, phone: EMOTE):** 1 Wave, 2 Dance, 3 Point, 4 Thumbs up, 5 "Help!", 6 "Follow me!", 7 "Monster here!", 8 "Found something!". Your friends see your hazmat suit do it, with a speech bubble over your head. The phrases also pop up on their screen with how far away you are. Only these fixed emotes and phrases can be sent, no free typing.
- **High five:** wave at a friend standing right next to you while they wave back (within 3.5 s), and you both get a HIGH FIVE and +10 sanity.
- **Pings (middle mouse, or 9 in the wheel, phone: PING):** mark the spot you're looking at. Everyone sees a glowing blue beam with your name for 8 seconds, and a dot on the map.
- **The tracker bar at the top of the screen is gone.** If you ever want it back, press O.
- Fix: pressing G for GIVE UP no longer also drops a glow stick.

## More scares (and flares)
- **The Follower:** every minute or two, a tall black figure with pale eyes walks the path you just took, a few metres behind you. You hear its footsteps. **Turn around and it's gone.** If you never look back, it reaches you: a breath on your neck, a red flash, and you lose sanity.
- **Mannequins:** 3 pale, faceless mannequins stand somewhere on each level. **They only move while nobody is looking at them**, a step at a time towards you. If one gets right behind you, the next time you turn around it's there (jump scare).
- **Flares:** 2 flares are hidden on each level. Press **K** (phone: **FLARE**) to throw one (K, because X is lean right). It bounces, burns red for 25 s and lights up the hallway, and **the monster won't come near it**: it's stunned for 4 s if it tries. Flares in your pocket show above the stats.
- **Lockers:** about 1 in 14 lockers has something already inside the first time you open it (never while the monster is chasing you).
- Scares shake the camera, flash the screen red and make a noise the monster can hear. Everything is captions only, no voices.

## Co-op: see what your teammate sees + scrolls in lockers
- **Spectating is now first-person:** while you're down you see exactly what your teammate sees, from their eyes, looking where they look (left/right and up/down) and lit by their flashlight. Their own body is hidden so it doesn't block the view. Click / tap to switch teammates.
- The heavy static on the screen is gone while you spectate, so you can actually watch.
- **Revival Scrolls in lockers:** in co-op, the first time you hide in each locker there's a **50% chance a Revival Scroll is tucked inside**. Each locker can only give you one roll. The 2 scrolls lying around each level are still there too.

## Co-op: nobody leaves until the team gives up
- In co-op you **always go down and spectate** when you're caught, even if you were the last one standing. You watch your teammates (click / tap to switch) until someone revives you with a 📜 Revival Scroll.
- **The run no longer ends by itself** when everyone is down. It only ends when **every player votes 🏳 GIVE UP**: press **G** or use the GIVE UP button (top right). The button shows the votes, for example 1/3. Players who are still standing see the button as soon as someone votes, and must agree too.
- If you get revived, your give-up vote is taken back automatically. You can also take it back yourself by pressing G again.

## New hazmat suit model + the white suit
- **New player model** (co-op teammates, the rag doll, the phone camera, selfies): a baggy hazmat suit with soft wrinkled fabric, a loose hood around a black gas mask with two round eye lenses and three filter canisters, a big biohazard symbol on the chest and back, a black belt with a suit-coloured buckle and a pouch, black gloves and tall black rubber boots. The old reflective stripes and air tank are gone.
- **White by default:** until you wear a suit from a closet or the shop, your suit is plain white. Every coloured suit uses the same new model in its colour.
- **Opening cutscene:** after you walk away from the car, you look down and **find a folded white hazmat suit with a gas mask**, pick it up and put it on (3.5 seconds, the screen goes dark while you dress). The ghost scene that follows is unchanged.

## You have to find the stun gun
- The stun gun is now hidden in a **supply cabinet on every level**, at a random spot far from the start (at least 45 m away when there's room), with no compass arrow. You start each level without it, and your loaded and spare ammo carry over.
- When you see the cabinet, a message says the stun gun might be inside. Walk up to it and press E (GRAB on a phone).
- If you continue a saved spot on the same run, you keep the gun you already found. A new run or a new level means finding it again.
- In co-op, every player finds their own gun. The cabinet is in the same place for everyone.
- The "STUN GUN" text now always sits just above the stats panel.

## New stun gun + 10-second stun
- **New stun gun model:** a sleek two-tone match-pistol shape with a black slide (grip serrations and glowing blue coil windows), a gunmetal frame with a rail, an orange front sight, a skeleton trigger, a textured raked grip with a flared magwell, and two electrode prongs at the front with a blue spark between them. The spark flashes when you fire, and the ammo light (green / red) is now on the back of the slide where you can see it.
- **A stun hit freezes any monster for 10 seconds** (it was 0.8-5 seconds depending on the level). After that the monster can't be stunned again for 3 seconds. The Null on Level 9 still shrugs off some shots.
- The "STUN GUN" text no longer covers the STAMINA label.
- Fix: the compass could show the locked VHS tape as "14197m" away. The locked tape now stays where it is, and only the pickup is blocked until the room is solved.

## Three tape challenge rooms per level
- Fix: "Cannot read properties of undefined (reading 'length')" when a level loaded straight into play before the rooms were built.
- Levels 0-8 now have **three** tape challenge rooms (TAPE CHALLENGE 1, 2 and 3), spread well apart. Each one has the parkour to the second floor and the lamp puzzle.
- **One keycard (or valve, party favor, and so on) is locked in each room's glass case**, so you need to beat all three rooms to escape. The VHS tape is in room 1.
- Level 9 has only one escape item, so it keeps one room. The extra item on Nightmare / Don't Look Back goes in room 3.
- When you solve a puzzle, a message tells you how many rooms are done (for example 2/3). The compass and the map point to the nearest locked keycard.

## The tape challenge is the only way out
- On Levels 0-9, the things you need to escape (keycards, pump valves, party favors, and so on) are no longer spread around the maze. They're **locked in the glass case on the second floor of the tape challenge room**, together with the VHS tape.
- To escape you have to do the parkour up to the second floor **and** light all five lamps. Then you can take the keycards and the tape. You can't pick them up from below or through the glass.
- The compass, the map and the "nearest" arrow point at the case, and the room's sign and hints say the keycards are in there.
- The case is a little bigger so everything fits. The extra keycard on Nightmare / Don't Look Back goes in the case too. In co-op, keycards are still shared: when one player opens the case and grabs them, everyone has them.
- Admin "reset item" still works: an item it moves is let out of the case.

## Godot version started (folder godot/)
- New **godot/** folder: the game rebuilt in **Godot 4.7.2** (the same build as Nathan's Steam copy). Open it with Godot → Import → godot/project.godot → F5.
- **Level 0 uses the same maze as the browser game:** the browser's random numbers and Chrome 141's sorting are copied exactly, and a test checks 8 reference mazes cell by cell (all match).
- Walls, carpet, ceiling, glowing panels, fog, flickering lights, a pool of real lights that follow you, and the player (walk, sprint with stamina, crouch, jump, flashlight with battery). Plus a HUD and a start/pause screen.
- The level data for all 20 levels is exported from the browser game into godot/data/levels.json.
- Decisions recorded in the migration plan: Windows, Godot 4.7.2, models made by Claude, co-op up to 6, no web build, same repository.

## Every VHS tape: parkour + puzzle
- Every tape room on Levels 0-9 now has **both** challenges, one after the other:
  1. **Parkour:** jump up the crates, pillars and the high ledge to the second floor (SPACE / JUMP).
  2. **Puzzle:** up on the second floor, the tape is locked in a glass case. Light all five lamps to open it; each button flips its own lamp and the ones next to it (E / tap GRAB).
- The tape only comes out when you're up on the second floor **and** the puzzle is solved. The buttons only work from up there, not from the floor under the balcony.
- The buttons and lamps are on one side of the balcony and the case on the other, so the spot where you land from the jump stays clear.
- This replaces the old random pick of one challenge per level. (The maze still exists in the code if you want it back on some levels.)
- The doorway sign says "TAPE CHALLENGE · PARKOUR + PUZZLE", and its text now shrinks to fit.

## BACKROOMS MUSIC: the music video + where to put the game online
- **🎬 BACKROOMS MUSIC: the music video (2:00)** for the song "DON'T LOOK BACK", made with the movie's engine, sets and characters, so it looks like the movie. Open it from **SOUND → 🎬 BACKROOMS MUSIC** (in the music section, under the song) or from the movie menu (**🎵 BACKROOMS MUSIC**).
  - It opens and closes with a **BACKROOMS MUSIC** title card, like the movie's title card.
  - Every shot is cut to the song's bars, and the lights pulse on the beat. The video's clock *is* the song, so picture and music can't drift apart. The sung lyrics appear as subtitles at the exact moment each line is sung (CC turns them off).
  - Verse 1: walking the yellow Lobby, a shadow far away. Chorus 1: running down a hallway with the Boiled One behind you, and a look back. Verse 2: VHS footage from October 1987 with the Threshold Project sign and the camcorder. Chorus 2: the Poolrooms and a Boiled One close-up. Bridge: "14 · 1 · 20 · 8 · 1 · 14" appears on a red wall one beat at a time, the letters N A T H A N appear under it, then the HELP letter on the desk. Final chorus: security-camera footage and the run to the elevator. Outro: the doors open.
  - No footsteps or movie sounds play over the song. ⏹ stops it, and ▶ / WATCH AGAIN plays it from the start.
- **docs/WHERE_TO_PLAY.md:** 70+ real places to put the game online, checked in November 2026: free hosting (GitHub Pages and others), game sites (itch.io, Newgrounds, Game Jolt, CrazyGames, Poki...), distribution networks that copy the game to hundreds of partner sites (GameDistribution, GameMonetize, GamePix, Playgama), app stores, and places to share the link. Sites that have closed (Glitch hosting, 000webhost) are marked.

## Co-op: the elevator is a safe room
- While you are inside the co-op elevator, you can't die: not while waiting for the doors, and not while standing inside after they open. Monsters, sanity, imprint and level hazards can't kill you there (imprint is held at half).
- The host's monster ignores anyone standing in the elevator and goes after players outside instead. If everyone is inside, it loses track and wanders.
- As soon as you step out of the elevator, the normal rules apply again.

## Smoother: less lag, no stutters
Measured on the same level and the same walk, frame time roughly halved on both computers and phones, and nothing gets "first-time" prepared mid-game anymore.
- **Adaptive resolution:** the game watches the frame rate all the time. If frames start to slow down, the 3D view is drawn slightly smaller (the film grain hides it); when there is room again it gets sharp again. Before, it only reacted below about 28 frames a second, and only once.
- **Fewer pixels for nothing:** the game no longer draws more pixels than your screen has (on a normal monitor, the "High" setting was drawing 2.25 times the pixels). Phones draw at 1×.
- **Phones:** edge smoothing (antialiasing) is off on phones. It was wasted work, because the camera effect redraws the picture anyway.
- **No more first-time stutters:** right after a level starts, the game prepares every shader in advance, so monsters, effects and items don't freeze the game for a moment the first time they appear.
- **Co-op:** friends' flashlights are created at the start, so a friend joining no longer makes everyone's game freeze for a moment. The elevator TV no longer adds an extra light.
- **Cheaper effects:** the TV-static texture updates 20 times a second instead of every frame. The low-sanity blur (a very expensive full-screen effect) is skipped on phones and updated 10 times a second on computers.

## Fix: the white flashlight glare
- **Bug fixed:** the flashlight's narrow, very bright beam was never actually switched off. A speed value in the movement code had the same name and blocked the update. So a bright white circle with a hard dark edge was always on, even with your flashlight off; close walls and the elevator doors glowed white.
- The narrow beam now turns on and off with your flashlight, is a bit gentler, and has a soft edge instead of a hard white-and-black ring.
- **Co-op elevator:** the level lights no longer flicker or black out while you wait inside, and the elevator doors are a darker brushed metal, so they don't glare white right in front of you.

## Jumping + VHS tape challenges (second floor parkour, maze, puzzle)
- **Jumping:** press **SPACE** to jump (on a phone: the new **JUMP** button next to GRAB). You jump about 1 metre and can land on crates, pillars and ledges. A quick tap jumps; holding SPACE still holds your breath like before. You can still jump a split second after stepping off an edge.
- **Tape challenges (Levels 0-9):** each level's VHS tape is now inside a special 12 × 12 m challenge room, and beating the challenge is the **only** way to get the tape. A sign over the doorway says which challenge it is. Each level and run picks one of three:
  - **PARKOUR – the second floor:** the ceiling opens into a tall shaft with a balcony (a real second floor) high above. Jump from crate to crate, then up the pillars and a high ledge, then leap onto the second floor to grab the tape. Fall and you just land on the floor and try again. Standing under the tape on the ground doesn't work.
  - **MAZE:** the tape is hidden in the middle of a walled mini-maze with one way in. The walls are too tall to jump over.
  - **PUZZLE:** the tape is locked in a glass case. Light all five lamps to open it: each button flips its own lamp and the lamps next to it (press **E** / tap **GRAB** at a button). The case lifts away when all five are green.
- Works on every level from 0 to 9, including the Dark Forest (there the room is an open clearing).
- The compass and map still point to the tape while it's locked.
- **Co-op:** every player gets the same challenge room (it comes from the level seed), and teammates see each other jump and stand on platforms.

## Co-op runs only end when the whole team is down
- Going down in co-op never ends your run. You stay in the game spectating, and your run keeps going until a teammate revives you or everyone is down.
- More forgiving teammate check: a teammate counts as "still standing" unless they've sent nothing for 10 seconds (it was 2.5 seconds). A lag spike or a quick reconnect no longer makes you die for real instead of going down.
- When nobody is left standing, players who are down wait 5 seconds (it was 4) before the run ends, in case a teammate's connection comes back.

## Co-op: rag doll, spectating, Revival Scrolls, teammates on the map
Co-op only. Solo games are unchanged.
- **Going down:** when you're caught and a teammate is still standing, you go **DOWN** instead of dying. Your view falls to the floor, and everyone else sees your body fall over like a rag doll (arms and legs spread, name tag turns blue).
- **Spectating:** after the fall you watch a teammate from behind their shoulder. Click or tap (or press Space) to switch between teammates. The screen says who you're watching.
- **📜 Revival Scrolls:** two scrolls appear in every co-op level (never in solo). They float and glow so you can spot them. Walk into one to pick it up; everyone sees it disappear, so each scroll can only be taken once. Your scrolls carry over between levels and show in the co-op list (📜 Revival Scrolls: 1).
- **Reviving:** walk up to a fallen teammate and press **F** (on a phone: tap **ACT**). They stand back up where they fell and are protected for 4 seconds. Without a scroll, the game tells you that you need one.
- **Nobody left standing:** if everyone else is down too, the last player dies normally, and anyone still down dies after a few seconds.
- **Map:** teammates show in **blue** on your map: a blue dot with a direction line for where they are, a blue line for where they've been, and a blue ✕ wherever they went down.
- The co-op list says "DOWN — revive them!" for fallen teammates. Being down doesn't count as a death in your run record; only a real death does.
- The scroll is an original model (parchment roll, dark rod with brass caps, leather band with gold emblems, rope tie with tassels).
- Co-op version is now 3: everyone in a game needs this update.

## The hum is gone
- The constant fluorescent-light hum (a low electrical drone plus a high buzz) is now **off by default**.
- If you ever want it back: **SOUND → 💡 LIGHT HUM: OFF (tap to turn on)**. The choice is remembered.
- Everything else (music, monster sounds, footsteps, effects) is unchanged. The movie keeps its own sound.

## Co-op: OPEN GAMES list
- The co-op menu now shows **🌐 OPEN GAMES**: every public game being hosted right now, with the host's name, the level, and how many players are in (for example 2/4). Tap **JOIN** to hop in; full games say FULL.
- Hosting now has two choices:
  - **HOST A PUBLIC GAME**: listed in OPEN GAMES, anyone can join.
  - **HOST A PRIVATE GAME**: not listed; only friends with your room code can join (same as before).
- While hosting, the host can switch between public and private any time from the co-op menu.
- How it works: there's no game server, so a public host posts a small listing (room code, in-game name, level, player count) on the same free relay servers co-op already uses, refreshed every 10 seconds. Listings disappear right away when the host leaves or goes private, and within about a minute if the host's game closes suddenly.
- Privacy: only in-game info is listed, never anything personal. Private games are never listed. Anyone playing the game can see and join a public game, so the menu reminds players to only play with people they trust. Voice chat stays off until each player turns on their own mic.

## Co-op starts where you left off
- Hosting a co-op game now starts on the level the host was last playing (solo or co-op) instead of a random level. Friends who join go to that same level.
- The game remembers your last level for each save slot. It updates every couple of seconds while you play, so if you leave a co-op game on Level 14, your next co-op game starts on Level 14.
- Riding the elevator together still takes the group to a random level.
- Your solo save is still protected: co-op never changes it.

## Pick any name
- Names can now be almost anything: 1 to 20 characters, any language, emoji, accents and symbols (for example "Ünal 🐸 the GOAT!!" or "李小龙"). Before, names had to be 3-16 plain letters, numbers, spaces or _.
- Co-op shows your real name to your friends; it used to strip everything except plain letters.
- Fixed false blocks: names like "Hostile" or "grapes" were rejected because they started with or contained a blocked word.
- Still blocked: hateful slurs, and the exact names admin / administrator / moderator / mod / staff (so nobody can pretend to be game staff). Characters that could break the page (< > & " ' ` \) are quietly removed.
- A name never gives admin powers; admin still needs the admin key.

## Phone mic button
- **🎤 MIC button on phones:** in a co-op game, phones show a MIC button at the top right (next to the button column). Tap it to turn your mic on (it lights up green), and tap again to turn it off. It does the same as the Y key on a computer.
- The button only appears on phones and tablets, and only during co-op. Computers keep using Y.
- The mic still only turns on when you tap it, and the browser asks for permission the first time.
- Phone text now says "tap MIC" instead of "Y".
- The co-op player list moved under the mini-map on phones so it doesn't run into the buttons, and the elevator message is smaller.

## Co-op elevator TV
- A TV on the left wall of the co-op starting elevator (co-op only) shows:
  - **HOST:** the host's name
  - **PLAYERS:** how many players are in the elevator (for example 2 / 4), with a light for each one
  - For the host: **PRESS ENTER TO OPEN THE DOORS** (on a phone: **TAP ACT TO OPEN THE DOORS**). For everyone else: **WAITING FOR THE HOST TO OPEN THE DOORS**.
  - Once the doors open: **DOORS OPEN — STAY TOGETHER. DON'T LOOK BACK.**
- A host playing on a phone can now open the doors by tapping ACT (there's no ENTER key on a phone).
- The on-screen elevator message moved lower so it doesn't cover the TV.

## Cleaner phone screen
- **Scanner moved:** on phones, the scanner now opens in the top-left corner (in place of the mini-map while it's on) instead of sitting under the ACT / CROUCH buttons.
- **Stats tidied:** stamina, battery, sanity, imprint and keycards are a small panel next to the mini-map instead of big bars across the middle of the top of the screen.
- **Compass** is narrower so it no longer runs into the other text. The level name is smaller and tucked by the right-hand buttons.
- **Messages** appear at the bottom centre between the joystick and the buttons, so the middle of the screen stays clear for watching the hallway.
- **Newcomer help** is smaller and sits under the compass. On phones its tips describe touch controls (LEFT STICK, ACT, BAG, LIGHT) instead of keyboard keys.
- Computers are unchanged.

## Fix: "Cannot create so many PeerConnections" crash
- **The problem:** with the mic on, voice chat re-called each friend every 2 seconds. A call that was still connecting (or that a friend's network never answered) counted as "not connected", so every 2 seconds the game opened another browser connection without closing the old one. After a few minutes Chrome hit its limit and threw "Failed to construct 'RTCPeerConnection': Cannot create so many PeerConnections".
- **The fix:**
  - A voice call that is still connecting is left alone. A call stuck for 15 seconds is closed before a new one is tried, and there are at most 3 tries per friend per minute.
  - A repeated call from the same friend closes the older one.
  - Joining a room never has more than one connection attempt waiting at a time; a stuck attempt is closed first, and reconnecting no longer stacks extra attempts.
  - A safety cap: the game counts its open connections and won't open new ones once 60 are open (far below the browser's limit).

## Co-op connection fix: automatic encrypted relay
- **The problem:** joining only worked when the two browsers could connect directly. Many home routers, phone hotspots and school networks block that, and PeerJS has no relay of its own. The free public PeerJS matchmaking server also sometimes goes down.
- **The fix: two ways to connect at once.**
  - **Direct (peer-to-peer):** this is tried first, and voice chat uses it.
  - **Relay:** if the direct connection hasn't answered within 7 seconds, the game also tries free public MQTT message servers (EMQX, HiveMQ, Mosquitto) over a normal secure web connection. Whichever reaches the host first is used.
  - The host listens on every relay server at once, so a friend whose network blocks one of them still gets in.
  - The game never stops on a missing matchmaking server: if it is down, everyone simply uses the relay.
- **Encrypted:** everything sent through the relay is encrypted (AES-GCM) with a key made from the room code. The topic name is a hash of the code too, so the relay servers can't read your game or find your room.
- **Upgrades by itself:** if you started on the relay and a direct connection comes through later, the game switches over seamlessly so voice chat starts working. If a direct connection drops mid-game, it falls back to the relay.
- **No duplicate players:** each game has a session ID, so the host never shows the same friend twice while a connection is being swapped.
- **Clear status:**
  - The host's multiplayer menu shows "Ways in: direct ✓/✗ · relay ✓ (n servers)", with advice when both are blocked.
  - Friends see whether they are connected directly or through the relay.
- **Advanced:** you can add your own TURN server, for example from a free TURN account, to help direct connections and voice on very strict networks.
- **Version check:** multiplayer is now version 2. Everyone needs the latest index.html, and an older copy gets a clear "different version" message.
- **Tested:**
  - Matchmaking server switched off: joining, the elevator start, the same monster, the group elevator and reconnecting all work through the relay.
  - Both available: the game starts on the relay, upgrades to direct, and voice works with exactly one copy of each player.
  - All 20 levels still work in solo.

## The Backrooms Song: no stutter, no echo
- **No stutter:** each line is now sung at an even, natural pace. Before, every syllable was stretched or squashed to hit its note, which made the stutter.
- **On pitch:** the voice is still pitch-corrected onto the melody notes, with short smooth glides between them.
- **No echo or "playback":**
  - The delay echo on the voice is gone.
  - Each line now stops before the next one starts, so lines never overlap.
  - The song's room reverb is much shorter and quieter (1.2 s at 13%, down from 2.4 s at 32%).
- **A cleaner voice:** the vocals now use the MBROLA "us1" voice, a computer voice and not a real person. It speaks around 190 Hz, right in the middle of the melody, so the pitch is moved less and sounds cleaner.
- **Measured:** the speech recognizer picks out 45% of the lyric words on the voice alone (30% before) and 34% in the full song. "The Threshold Project wanted to see more" and "The Boiled One is smiling where the hallway…" come through clearly.

## The Backrooms Song: clearer vocals
- **A clearer voice:** the vocoded robot voice is replaced by a more natural synthetic voice (MBROLA "us2" through eSpeak NG; still a computer voice, not a real person). Each syllable is lined up with its melody note and pitch-corrected onto it with Praat's PSOLA, so consonants and vowels stay sharp instead of smeared.
- **Mixing:**
  - When the vocals are on, the lead synth that doubled the melody drops to 30%, so it no longer covers the words.
  - The voice is 4 dB louder than before, with a presence lift around 3 kHz and gentle compression.
  - A limiter on the song's output stops it clipping.
- **Measured:** the same speech recognizer now picks out 38% of the lyric words in the full mix, up from 8% before. Lines like "Something is breathing just behind the black" come through almost word for word.
- **The MP3 and the game** both use the new vocals. The 🎤 VOCALS ON/OFF switch still works.

## The Backrooms Song now has sung words
- **Vocals:** "DON'T LOOK BACK" now has a singing voice on every lyric line, sung on the song's melody, an octave low for a ghostly sound.
  - In the bridge, each number (fourteen… one… twenty… eight… one… fourteen) is sung on its music-box note, one per beat.
  - The title, the "HELP" letter lines and the outro are whispered.
- **How it was made:** the voice is a computer voice made with the eSpeak NG speech synthesizer, not a real person or anyone's imitation. A vocoder puts the spoken words onto the melody notes.
  - Only the song has a voice. The rest of the game still uses captions only, as you asked.
  - The vocal track is embedded in the game as a small MP3, so it adds about 1 MB.
- **Vocals switch:** **🎤 VOCALS: ON/OFF** on the song screen turns them off or back on, even mid-song, and your choice is remembered. The lyrics still show on screen.
- **Checked:** the vocals play in sync for the whole song. A speech recognizer picks out the sung lines about as well as the plain spoken ones, for example "I slipped through", "something is" and "the threshold".

## The Backrooms Song: "DON'T LOOK BACK" (2:00)
- **Where:** 🎵 SOUND (main menu or pause menu) → **🎤 THE BACKROOMS SONG**.
- **What it is:** an original 2-minute song about the game and its lore, in A minor at 106 BPM.
  - Intro: fluorescent hum and static.
  - Verse 1: falling into the Lobby.
  - Chorus: "Don't look back".
  - Verse 2: the Threshold Project, October '87, the five First Wanderers and their tapes.
  - Chorus 2: the Boiled One.
  - Bridge: a music box plays 14 - 1 - 20 - 8 - 1 - 14 as notes over a ticking clock, then Nathan's letter: "HELP. But who held the pen?"
  - Final chorus: an octave higher.
  - Outro: the elevator doors open with a ding.
- **Lyrics on screen:** they appear karaoke style, with the section name, the next line, a progress bar and STOP and CLOSE buttons. There is no singing voice, because the game uses captions only. A synth lead plays the melody line.
- **Made in code:** all of it is generated with Web Audio, with no audio files. It uses the Music volume, and the background music pauses while it plays.

## Co-op voice chat
- **Talk to your friends:** in a co-op game press **Y**, or use **🎤 TURN ON YOUR MIC** in the multiplayer menu. The browser asks for permission the first time. Press Y again to turn it off.
- **Proximity voice:** friends next to you sound at full volume and get quieter the farther away they are. Friends on another level sound at 60%. You can switch this off in the multiplayer menu to hear everyone at full volume.
- **Mute anyone:** each player in the multiplayer menu's list has a mute link, and it is remembered by name.
- **Who is talking:** the co-op list shows 🎤 LIVE next to your name while your mic is on, and 🎤 next to friends with their mic on (🔇 if you muted them).
- **Your mic stays on between levels:** after the group elevator, a retry or a reload, the mic switches back on by itself if it was on. Leaving multiplayer turns it off.
- **Privacy:**
  - Only your real microphone is used, and only after you turn it on.
  - Your voice goes straight to the other players' browsers. It never goes through a server.
  - Nothing is recorded or stored, and voices are never changed or imitated.
  - Echo cancellation and noise reduction are on.
- **Tested:** with two browsers and a fake test microphone.
  - Both directions work, and the volume drops from 100% to 12% when far away.
  - Muting sets a friend to 0%.
  - Turning the mic off stops the other player hearing it.

## Co-op: random levels
- **A random start:** every new co-op game starts on a random level from 0 to 19, with everyone in the elevator showing that floor number.
- **Random next levels:** each time the group takes the elevator, it goes to another random level, never the same one twice in a row. On Level 19 the game doesn't end in co-op: the elevator just takes the group somewhere new.
- **Your solo save is safe:** co-op never changes your solo level, unlocked levels or save spot. Leaving multiplayer takes you back to where your solo game was. Cash, trophies and stats you earn in co-op still count.

## Co-op: no PLAY button needed
- **Straight into the elevator:**
  - Pressing **HOST A GAME** puts the host in the closed elevator right away.
  - Pressing **JOIN GAME** loads the host's level and puts the friend in the elevator too.
  - The same happens after the group elevator takes everyone to a new level, and after a retry when you get caught.
- **Your first run:** if you don't have a run yet, it starts with the difficulty already selected on the run screen (Casual for brand-new players).
- **Main menu:** choosing MAIN MENU from the pause menu still leaves you in the menu.
- **Sound:** a game started without a click wakes its sound on your first click or key press. Click the game once to look around.

## Co-op start: everyone begins in the elevator
- **The start:** in a co-op game, every level begins with all players inside a closed elevator, with the floor number lit above the doors. Each player stands in their own spot, facing the doors.
- **While you wait:**
  - A message shows how many players are in the elevator.
  - The host sees "press ENTER to open the doors"; everyone else sees "Waiting for (host) to open the doors...".
  - Nobody can leave the elevator, and the monster stays frozen.
  - No blackouts happen, and 14 - 1 - 20 - 8 - 1 - 14 stays away.
- **When the host presses ENTER:** the doors slide open for everyone at the same moment with a chime, and the level begins. Your flashlight switches back on if it was on before.
- **Every co-op level works this way:** that includes arriving on a new level with the group elevator.
- **After the doors open:**
  - If you get caught and retry, or reload, you come back in the elevator with the doors already open.
  - Friends who join late also find them open.
  - The elevator stays in the level as a landmark, and you can only go in or out through its doorway.
- **Safety net:** if the host stops answering for 20 seconds, the doors open by themselves so nobody is stuck.

## Multiplayer: peer-to-peer co-op (beta)
- **How to play together:** ▶ MODES → 👥 MULTIPLAYER (CO-OP). One player presses **HOST A GAME** and gets a 6-letter room code. Friends type the code and press **JOIN GAME**. Then everyone presses PLAY. 2–4 players.
- **What is shared:**
  - **The level:** the host sends the level and its seed, so every player gets the exact same maze, items and exit.
  - **Other players:** they show up with their own suit colour, name tag, flashlight beam and walking, running and crouching animations. Hidden or caught players disappear from view.
  - **The monster:** the host's game runs it and it hunts whoever is closest. Everyone sees it in the same place. Being caught is still personal: you die, retry, and rejoin the same level.
  - **Keycards and objective items:** they are shared. When anyone picks one up, it is gone for everyone and counts for the whole team.
  - **The elevator:** it takes the whole group. When anyone leaves with the keycards, every player moves to the next level together, on a new shared seed.
  - **The co-op list** on the right of the screen shows each player's distance, and whether they are hiding, caught or on another level.
- **Reconnecting:** every page reload (a new level, a retry, the main menu) reconnects to the same room by itself. Players can join mid-level.
- **How it connects:** browsers connect directly with WebRTC through PeerJS, which is bundled into the game (MIT licence). The free public PeerJS server only introduces the browsers to each other; game data never goes through it. You can set your own PeerJS server in the menu's advanced options.
- **Safety:**
  - Every incoming message is checked: allowed message types only, number and text limits, and a rate limit.
  - Names are escaped before they appear on screen.
  - Rooms take 4 players at most, and players on a different game version are turned away.
  - The menu explains that peer-to-peer means other players can see your IP address, so only play with people you know.
- **Saves:** each player keeps their own save, cash and suits. Nobody can change anyone else's save.
- **Not shared yet:**
  - The Level 1 and Level 2 monsters, and the special objectives on Levels 10–19.
  - Random events and hallucinations, which stay personal scares.
  - Admin tools, which only affect your own game.
  - Hide and Seek and Stalker, which still use AI players.
  - There is no voice or text chat. If the host leaves, the room closes.
- **Tested:** with two browsers on a local PeerJS server.
  - Joining, the identical maze and keycards, seeing each other, and the monster in the same place on both screens.
  - The host's monster chasing the friend.
  - A shared keycard pickup.
  - The group elevator from Level 1 to Level 2 with a new shared seed, automatic reconnecting, and leaving.
  - Not yet tested between two real homes over the internet.

## Easier first Level 0 for new players
- **Who gets it:** anyone on Level 0 who has never escaped it. It switches off by itself after your first escape. Press **H** to turn it off sooner. It does not apply to Nightmare or Don't Look Back runs.
- **New-run screen:** brand-new players start with **CASUAL** selected (marked "★ recommended for your first time") and mutations **OFF**. You can still pick anything.
- **On your first Level 0:**
  - The Boiled One sleeps for the first 45 seconds (a countdown shows it). After that it moves 30% slower.
  - A guide at the top of the screen shows how many keycards you have, with an arrow and the distance to the nearest one. Once you have them all, it points to the elevator, or to the elevator fuse if the run has Broken Elevators.
  - Blue light beams above each keycard (a yellow one above the fuse) show through the fog.
  - Sanity and flashlight battery drain at half speed.
  - No blackouts, and 14 - 1 - 20 - 8 - 1 - 14 stays away.
  - You start with 2 Almond Waters.
  - Short tips appear one at a time: the goal, moving and sprinting, the flashlight, escaping a chase, hiding in lockers, using items.

## The Forgotten Security Office
- **Where:** a door marked **SECURITY** is hidden in a wall on **Level 0** and on **Level 5**. Walk up to it and press **E**. It is never required, you can always leave, and leaving puts you back at the same door.
  - Leave through the STAFF ONLY door you came in by, or through the emergency exit once you have read the letter.
- **The office:**
  - an open office with 12 cubicles: desks, rolling chairs, monitors, keyboards, phones, coffee cups, papers, a printer and a phone desk
  - a corridor with a flickering fluorescent light and a map of every level, including the ones you have not found yet
  - a **security control room** with a wall of 12 camera screens and the security computer
  - ceiling cameras with red lights
  - a dusty clock stopped at **3:33**
  - a server alcove with the **THRESHOLD PROJECT — INTERNAL ACCESS ONLY** computer
  - a locked records room and locked filing cabinets
  - a locked office with **NATHAN** on the door; inside, his handwriting covers the walls
  - a broken elevator: you can call it, but it only ever opens on this floor
  - a locked emergency exit
- **Nathan's letter:** on a desk in the control room. **[E] READ LETTER** opens a close-up of the old, stained, folded paper, with a big HELP at the top and a red fingerprint. Press E or click to put it down.
  - Reading it adds **NATHAN'S LAST MESSAGE** to the story archive, with the full text and a note that the footage may have been altered. It is saved, so you never have to find it again in that save.
  - A key is taped to the back. It opens the cabinets, the records, the DO NOT SHOW NATHAN folder and Nathan's office.
  - If you have already watched the office chapter of the movie, the game says you have seen this letter before.
- **Security cameras:** press **E** at the security computer.
  - Feeds CAM 01–08 plus **CAMERA 20 — DO NOT WATCH**. Switch with 1–8 or the arrow keys, open Camera 20 with 9 or 0, zoom with W/S or the mouse wheel.
  - Some feeds show empty rooms. Others show movement far away.
  - A figure sometimes appears on CAM 01 and is gone when you come back.
  - **HALLWAY 7-B** does not exist on the office map.
  - CAM 02 shows you standing in the security room.
  - **Camera 20:** a dark hallway with a figure at the far end that comes closer every time you switch feeds. After enough switches, Camera 20 shows the office from behind you. Watch it too long and the screen goes black: **IT KNOWS YOU ARE WATCHING**.
  - The signal drops now and then, but rarely.
  - Only one small monitor on the wall is refreshed at a time, so the cameras stay fast.
- **Rare events:** each one happens at most once per save, one at a time, at random times.
  - The printer prints a visitor log with your in-game username.
  - Every computer shows **NATHAN IS STILL HERE**.
  - A phone with no cable rings. Answering it gives a whisper as a caption: "You found the letter."
  - CAM 03 sometimes shows you walking down the corridor six seconds in the future.
  - The records cabinet has reports about earlier Wanderers.
  - The **DO NOT SHOW NATHAN** folder plays corrupted footage.
- **After the letter:** a few seconds after you put it down, the security computer behind you switches on by itself and shows a live view of the letter desk. When you come close, a second note slides out from under the letter: **NATHAN DIDN'T WRITE THIS.** The screen flickers, **SO WHO DID?** appears, and then it cuts to black. Quiet footsteps follow behind you. There is no jumpscare.
- **The movie:** a new chapter, **THE FORGOTTEN SECURITY OFFICE** (chapter 7, 1:59), uses the same office layout and draws the same letter as the game.
  - Nathan walks in under buzzing lights, past the desks, into the control room.
  - A monitor shows someone at the end of a hallway. He looks away, and the figure is gone.
  - Another monitor shows him sitting at the desk while he is standing. He whispers "That's not possible."
  - He sits down and writes HELP, then the rest of the letter down to DON'T LOOK BACK.
  - The ceiling camera turns toward him, and the screens start showing him from different angles.
  - His desk monitor shows someone standing right behind him. He turns, and nothing is there.
  - Every screen dies except Camera 20, which shows him from behind with something tall in the doorway.
  - The lights go out one by one. He drops the pen and runs.
  - It ends on the letter, which fades into the flat letter you read in the game.
  - The monster is only ever a dark shape on a monitor.
  - The movie is now 29:59 long. Chapter numbers update by themselves.
- **Multiplayer:** there is still no game server, so the office, the cameras and the letter are single-player on your device. They are not synced between players.

## Title screen
- **New first screen:** before the opening cutscene you now see the Backrooms: Don't Look Back title art, gently floating and flickering, with a glowing **▶ START HERE** button.
- **Starting:** clicking the button, or anywhere on the screen, starts the opening car scene, the same as before.
- **Phones:** the layout fits phone screens too.

## Easier levels: never more than three
- No level asks for more than **3** items to escape.
  - Level 2 now needs 3 party favors, Level 14 needs 3 ride tokens, and Level 15 needs 3 hidden symbols. All three used to need 4.
  - Level 19 has 3 transmitters instead of 5.
- Levels that already needed fewer than 3 are unchanged.

## The lore of 14 - 1 - 20 - 8 - 1 - 14 · no more spoken voices
- **Who he is:** 14 - 1 - 20 - 8 - 1 - 14 is what is left of Nathan when his sanity reaches zero. Count the letters of the alphabet and the numbers spell NATHAN.
- **His file:** five pages of the Threshold Project's FILE 14-1-20-8-1-14 are hidden on Levels 0, 3, 8, 13 and 19, and you collect them into the lore archive.
  - Page 1: entry at 100% sanity.
  - Page 2: counting the same six numbers at 64%.
  - Page 3: crouching in Ward 8 at 31%.
  - Page 4: his warning at 9%.
  - File closed: 0%. "The family reports that Nathan came home. The Project disagrees."
- **Encyclopedia:** a full entry with appearance, behaviour, detection, weaknesses and the lore.
- **Gameplay:** he comes more often the lower your sanity is, up to about 4× as often near 0%. Below 35% sanity you hear him counting when he appears.
- **The movie:**
  - a sanity meter in the corner drains from 100% to 0% over the film
  - in the Void, the Wanderer's double turns into 14 - 1 - 20 - 8 - 1 - 14 for a moment
  - the elevator ride counts the numbers
  - the news ticker mentions him crouching and counting
  - the credits list him as "Nathan, at zero sanity"
- **Voices:** all spoken (text-to-speech) voice lines are gone from both the game and the movie. Captions and subtitles still show every line.

## THE MOVIE: WHAT WENT DOWN
- **A full movie inside the game:** 15 chapters, 28 minutes. Open it from the main menu with the 🎬 THE MOVIE: WHAT WENT DOWN button, under MODES. You can watch it any time. It never changes your saves, progress, trophies or items.
- **How it's made:** the movie is rendered live in real time, not as a video file. It reuses the game's own wall, carpet and ceiling textures for every level, and the real monster models. On top of that it adds:
  - camera moves, shadows from the flashlight, fog, dust, water with reflections, film grain, VHS and security-camera footage
  - a new main character, THE WANDERER, with walking, running, crouching, hiding, breathing and fear on his face
- **The story covers every level, 0 to 20:**
  - the fall into Level 0 and the chase to the elevator
  - the Poolrooms, the Party Rooms, the hotel register, the school drawing
  - the Threshold Project files, the forest, the empty train, the hospital footage, the Void
  - the mall and garage, the aquarium and library, the carnival and red hallways, the airport and flooded city
  - the Dream Hotel, the Forgotten City tape, the final elevator below zero, and the ending at home
- **Player:**
  - play and pause, skip 10 seconds either way, skip a scene, previous and next chapter, a seek bar with chapter marks
  - subtitles, full screen, return to the menu
  - keys: Space, ←/→, C, F and Esc
- **Movie menu:** WATCH MOVIE, CONTINUE WATCHING (only when you have stopped partway), CHAPTERS (all open, with thumbnails, descriptions, lengths and a watched mark), MOVIE SETTINGS, BACK.
- **Settings:** separate music, dialogue and effects volume, subtitles, spoken dialogue, and Low/Medium/High quality. Low is for slower computers.
- **Saving:** your viewing position is saved separately from your game saves. When the movie ends you can WATCH AGAIN, open CHAPTERS, or RETURN TO MAIN MENU.

## N4TH4N is now 14 - 1 - 20 - 8 - 1 - 14
- **New name:** the monster is now called **14 - 1 - 20 - 8 - 1 - 14**. Those are the letters of NATHAN as numbers (N=14, A=1, T=20, H=8). The encyclopedia hints at it: "it spells a name when you count the letters of the alphabet".
- **Portrait:** now `docs/14-1-20-8-1-14.png`.

## The Croucher is now N4TH4N
- **New name:** N4TH4N, which is "Nathan" with the A's written as 4s.
- **File number:** 14-1-20-8-1-14. Those are the letters of NATHAN as numbers (N=14, A=1, T=20, H=8). The encyclopedia entry mentions it.
- **Jumpscare caption:** the static whispers the numbers.
- **Portrait:** now `docs/14-1-20-8-1-14.png`.

## The Croucher
- The custom monster now has a name: **The Croucher**.
- **Every level:** he can appear in every level from 0 to 19. His first appearance is 35–70 seconds into a level, then about every 2–3 minutes. He picks a spot you can see, 7–28 m away.
- **Sharper face:** the eyes line up with the glasses frames, and no photo background shows at the sides of his head.
- **Portrait:** `docs/14-1-20-8-1-14.png`.

## Better Corrupted model + cutscene lighting fix
- **The Corrupted** has a new, detailed model:
  - a round head that wears his corrupted face (it glows a little, so it can be seen in the dark), messy hair with bangs, ears and glasses frames
  - a baggy hoodie with a hood, a fold around the neck, a front pocket, drawstrings and a logo patch
  - arms with elbows and cuffs, pale long fingers
  - tapered joggers, and white sneakers with soles and laces
- **The walk after the car crash:** the figure that appears now is The Corrupted, not the Boiled One.
- **Cutscene lighting:** the lights used to drop to 1–3%, which made the walls pitch black while the ceiling lights stayed bright. Now they stay dim but readable.
- **The crash flash:** a short dark-red flash instead of a full white screen.
- **Level 0 wall shading:** the secret control room rebuilds walls; they now get the correct brightness instead of keeping stale colours.

## The Corrupted (custom monster, now called The Croucher)
- **What he is:** a new monster made from a photo of a friend of the developer, used with his permission. His face is corrupted: grey skin, black tears, burning red eyes behind his glasses, and a jagged grin. His 3D model is a crouching boy in a dark hoodie with long arms.
- **In the levels:** he rarely shows up crouched down a hallway, lit by a faint red glow. If you stare at him or walk up to him, he rushes you and jumpscares you (−20 sanity, but it can never kill you). If you ignore him, he gives up.
- **Jumpscare:** his own full-screen scare with a static scream. It follows the "Reduce flashing lights" and "Reduce sudden loud sounds" settings.
- **Phone camera:** after you meet him, the camera has an "Invite The Corrupted into the photo" option. He stands behind you in selfies and in front of you in "What I see". Photographing a wild one makes him rush you. You get $15 for his photo once a day.
- **Opening car scene:** he replaces the Boiled One at the window and in the road.
- **Also:** he is in the monster log and encyclopedia, and in the admin ENTITY tab.

## Hide and Seek + admin entity transformation
- **HIDE AND SEEK mode** (main menu → MODES):
  - **Menu:** Quick Play, Create Lobby, Join Lobby, Private Match, Choose Map, Choose Rules, Character, How to Play, Stats.
  - **Lobby:** ready check, a join code, and host rules: role, number of AI players (2–9), seekers (1–3), hiding time (default 30 s), round length (default 5 min), player speed, each ability on or off, and "every prop on every map".
  - **Maps:** Levels 0, 1, 2, 3, 4, 5, 10, 11, 12, 13, 14 and 16. Each map has its own prop set (office, pool, party, hotel, school, airport…), and about 45 real copies of those props are scattered around so disguises blend in. Matches use a ring-shaped play area with extra light.
  - **Hiders:** E transforms (H also works), J opens the prop wheel, [ ] switches prop, Z / X rotates. You can't transform inside walls or on top of other props. There is a cooldown, a "pop" sound and smoke when you transform. You move slowly while disguised, and the camera sits behind your prop.
  - **Hider abilities** (once per round each): 1 Quick Transform, 2 Silent Movement, 3 Decoy Prop (a copy that wanders off), 4 Last Chance (a sprint burst).
  - **Seekers:** locked behind a black countdown screen while the hiders hide. F or click tags the object in front of you (short range, no walls); tagging an empty object adds a short cooldown. Q is the Detection Pulse: 3 uses, 20 s cooldown, 14 m range.
  - **Round end:** results screen with points, a streak, a daily Hide and Seek challenge, and stats (rounds, wins, tags, best survival time, favourite disguise). Cash is capped at $40 a round and $200 a day, and rounds shorter than 1 minute pay nothing.
- **Admin panel → ENTITY tab:** transform into any of the 24 entities from Levels 0–20.
  - **Browser:** search, category filters, a 3D model preview, home level, movement, abilities and status for each entity.
  - **Two modes:** player-controlled (third-person) and AI-controlled (your body waits safely and the camera follows the entity).
  - **Controls:** size, speed, sounds, effects, AI on/off, reset, return to spawn, ability buttons with optional hotkeys 8 / 9 / 0.
  - **Permission toggles:** attack, damage, jumpscares, abilities, visibility, invisible, fly, teleport, effects, ignore limits. The dangerous ones ask for confirmation first.
  - **Safety and logging:** every action is written to the audit log. You can't die while transformed, and nothing in your run is reset or duplicated.
- **Limits:** no server exists. Lobbies, matchmaking and join codes are local, other players are AI, and the admin role check runs in the browser. All of this is labelled in the game.

## Cleanup update
- **Phone home screen:** shrunk from 25 tiles to 18. Apps that belong together now open from one folder:
  - ARCHIVE: lore archive, VHS archive, found tapes and notes.
  - MONSTERS: the encyclopedia and the monster log.
  - PROGRESS: run, daily challenges and trophies.
  - SUITS: suits and rare suits.
  - GALLERY: files and images.
- **Pause menu:** the duplicate CONTROLS button is gone.
- **Main menu:** MULTIPLAYER (info only) moved from MODES to INFO.
- **Admin panel:** all story and secret test buttons moved out of WORLD into their own STORY tab, sorted into Events, Encounters, Give / Unlock and Tools.

## Organizing update
- **Main menu:** a big PLAY button, with everything else sorted into four tabs: MODES, PLAYER, SETTINGS and INFO. The game remembers the last tab you used.
- **Phone:** the home screen is sorted into sections: Essentials, Story & Lore, Progress, Style & Money, and Photos & Fun.
- **New help screens:** ⌨ ALL CONTROLS lists every key in one place, and 📘 GAME GUIDE gives a short guide to the whole game.
- **Pause menu:** a CONTROLS button.
- **Repository:** a README, this changelog, the checklist moved into `docs/`, and a table of contents at the top of `index.html`.

## Player model, third-person view and drone maps
- **Player model:** a new detailed model in your suit's colour, with a helmet and visor, air tank, name tag and flashlight. The phone camera uses it too.
- **Third-person view (7):** first person → over the shoulder → far.
- **Drone aerial map (B):** a real top-down photo of the level, with icons, your trail, zoom and waypoints.

## More stuff
- **New features:** the compass (O), holding your breath while hiding (Space), ENDLESS mode, 20 trophies, and handwritten wall messages.

## Lore expansion
- **The story:** the Threshold Project, five First Wanderers, rare Boiled One sightings, and 12 titled VHS tapes in 6 categories.
- **Documents and clues:** 8 Project documents and a story clue on every level.
- **Who you are:** identity clues tied to your username.
- **Theories:** a board with three theories, and a choice of what to believe before the final elevator.
- **Archive:** the LORE ARCHIVE app.

## Ultimate Horror Update (stages 1–3)
- **Stage 1:** difficulty modes and run mutations, lights-out events, sanity hallucinations, elevator anomalies, menu meta-horror and daily challenges.
- **Stage 2:** the Copycat's new AI and the Level 0 control room. Also the Don't Look Back challenge, fake exits, the VHS expansion, the encyclopedia and the water predator.
- **Stage 3:** rescue missions, Stalker mode (AI), the containment facility and secret Level 20. Also endings A–H with the final cinematic, rare suits and death replays.

## Earlier updates
- **New content:** Levels 10–19 with new monsters, 3D jumpscares, the admin panel and gadgets.
