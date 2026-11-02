# Changelog

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
