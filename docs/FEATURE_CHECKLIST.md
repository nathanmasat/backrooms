# THE BACKROOMS: DON'T LOOK BACK — Ultimate Horror Update checklist

Built in 3 stages inside `index.html`. Each stage is a separate script block named
`ULTIMATE HORROR UPDATE — STAGE …`. Every older level, monster, item, phone app and save still works.

**Important limit:** the game runs only in the browser and has **no online server**. So anything that
needs real online multiplayer (syncing between players, host migration, server checks) cannot work.
Single-player versions are built instead, and they are labelled clearly in the game.

Legend: ✅ done · 🟡 partly done (what is missing is written next to it) · ⛔ not possible without a server

| # | Feature | Status | Notes |
|---|---|---|---|
| 1 | The Copycat | ✅ | Level 5. It has 10 AI states: idle, patrol, listen, investigate, mimic, stalk, chase, attack, search, retreat. **Learning:** it learns from sprinting, flashlight use and hiding, and it warns you each time it learns something. **Mimic:** it copies your suit colour or a wanderer, and makes fake footsteps, fake calls for help and fake scanner blips. **Tells:** a copy has no footsteps, a twitching head and eyes that shine in your flashlight. **Attacks:** there is always a shriek and a wind-up first. A missed attack makes it retreat. It never copies a real player's voice. 🟡 It can't copy teammates, because there is no multiplayer. |
| 2 | Lights-out events | ✅ | **Sequence:** the lights flicker and an alarm sounds, then 20–45 s of darkness with red emergency lights, then the lights come back. **During the blackout:** monsters move faster and hear better. You hear sounds with no source, and the scanner gets interference. Some closed doors lock for a while, but never doors near you. **Your options:** restart an emergency generator (marked on the HUD and map) to end it early. Rare supply crates appear in dead ends. **Fairness:** cooldowns stop it happening too often. |
| 3 | Secret control room (Level 0) | ✅ | **Getting in:** 3 different-looking keycards are hidden in 3 parts of the level. They are saved in your inventory, and you need all 3 to open the blast door. The room is not on the map until you find it. **Inside:** 3 monitors show live in-game cameras, including one that tracks the monster. There are also classified reports, containment records, photos of missing wanderers, a map of the levels and an audio log. **Terminal and secret:** the password is QUIET ROOM PROTOCOL, and its logs unlock as you reach deeper levels. A sigil hidden behind the cabinet counts towards Level 20. |
| 4 | Don't Look Back challenge | ✅ | **Rules:** the Watcher only moves when you are not looking at it, and it gets faster over time. Looking at it drains sanity. Flashing your flashlight (R or right-click) freezes it for a moment, using battery. **The course:** crates, a locked door with a lever, a crouch-only vent shortcut, and a symbol-order puzzle before the exit. **Entrances:** door W-7 in the control room, and a door on Level 19. 🟡 There is no team version. |
| 5 | Fake exits & false realities | ✅ | **Where:** about 35% of levels 1–18 get an optional fake EXIT door. **The 6 places:** a house, a parking lot, a street, a "safe" room, a menu-like place, and a copy of the Lobby. **Clues:** a clock running backwards, impossible windows, a door that leads back into the same room, a chair on the ceiling, a sound that repeats exactly, a man who says the same line, and strange phone messages. **Outcomes:** spotting the clues opens a hidden way back (+$75). The wrong exit leads to a Nightmare Level, which you can always escape. |
| 6 | Lost Wanderers VHS expansion | ✅ | **The tapes:** 10 new tapes for Levels 0–9, plus the 10 older ones for 10–19 and an extra tape you get after beating Level 19. The first tape is always in the same place in Level 0. The others move between runs but stay put within a run. **Finding them:** found tapes show on the map, and nearby tapes show on the scanner. **Playing them:** play tapes at the TVs on Levels 0–9; the footage is a real camera view of the level, and some tapes lower your sanity. **Future recordings:** a room you haven't found yet (it comes true later), a countdown to the next real blackout, and an elevator going to floor 20 (it happens on your next ride). **Archive app:** name, level, found and played status, notes, clues and completion %. |
| 7 | Monster containment breakout | ✅ | **Getting there:** take the containment lift in the control room once the terminal is unlocked. **What you do:** find 2 access cards, restore power, read the logs, dodge sweeping cameras, set the right emergency locks and decide whether to free the trapped wanderer. **Danger:** a wrong switch, being seen by a camera, or opening cells too early lets monsters out. **Finish:** restore emergency power and call the evacuation elevator. You get money, lore and the Containment Suit. 🟡 Single-player only. |
| 8 | The monster beneath the water | ✅ | Level 17 (the Undertow). **Warnings before it strikes:** its shadow under the water, ripple rings, splashing and a low rumble. Running through water draws it to you. **Ways to stay safe:** safe platforms where it can't reach you, and the existing air pockets and attack warnings. **Optional objectives:** rerouting power and opening the floodgate, which drains part of the flood. |
| 9 | Sanity & hallucinations | ✅ | **What drains sanity:** darkness, being near monsters, scary events, staying too long away from safe areas, and disturbing tapes. Lights and safe rooms bring it back. **8 hallucinations:** fake footsteps, shadow figures, fake doors, a stretching room, static bursts, fake scanner readings, a fake wanderer on the map, and creepy phone messages. None of them change the real world or break objectives. **New accessibility options:** reduce visual distortion, and reduce intense screen effects. |
| 10 | STALKER mode | 🟡 | **Why it's different:** real online Stalker needs a server, so this is the "fair AI substitute" the prompt allows. **How a round works:** you and 3 AI wanderers must escape, and one of them is secretly the entity. **What the entity can do:** cut the lights, lock doors for a short time, fake sounds, jam the scanner and arm traps, all on cooldowns. It can only knock you down, not kill you instantly, and a teammate can revive you. **Results:** the entity is revealed on the results screen, with points and saved stats. ⛔ You can't play as the entity against real players. |
| 11 | Randomized mutations | ✅ | **The 9 mutations:** Lights Out, Low Battery, Fast Hunters, Silent World, False Signals, The Building Is Alive (doors move by themselves; walls never move, so no route gets cut off), Broken Elevators (a fuse you can always reach), Extra Supplies, and Double Threat. **Rules:** they are picked when the run starts, saved, and stay the same for the whole run. They show in the lobby, the pause menu and the phone. You get bonus money for each one, and +$100 for 3 or more. |
| 12 | Elevator anomalies | ✅ | **The 7 anomalies:** the floor display changing by itself, stopping between floors, doors opening onto an unknown hallway, doors opening onto a level you visited before, a strange button, a distorted speaker warning, and knocking on the roof. Rarely, the button shows floor 20. **Safety:** every anomaly ends by itself, so you can never get stuck. |
| 13 | Rescue missions | ✅ | **6 missions on Levels 2–8:** escort, find someone hiding, deliver batteries, heal someone injured, find the real person among two (one is the Copycat), and recover a recorder. **NPCs:** they walk with you, talk, get scared, and can be caught by monsters. **Rewards and failures:** you get money, tips and the Rescuer's Vest. A failed rescue changes later dialogue and Level 20, but you can still finish the game. |
| 14 | Secret Level 20 | ✅ | **Unlock:** find 19 hidden symbols (one in each level 0–18), play tapes 00, 05 and 09, and unlock the control-room terminal and sigil. All of this is tracked in the ✦ SECRETS app. It never appears in level select; instead, a new elevator button shows up. **The level:** rooms from the Lobby, Poolrooms, Mall, Hotel, School, Hospital, Flooded Tunnel and Void. It has your name, the levels you escaped, statues of monsters you met, your tape count, and things that change with your choices. **Ending it:** a final puzzle that uses tape clues, and a final encounter in the Void. |
| 15 | Meta horror on the main menu | ✅ | Rare scripted events based on your real progress: YOU CAME BACK, WE REMEMBER YOUR FOOTSTEPS, THAT WAS NOT THE EXIT, IT KNOWS YOUR NAME, DON'T LOOK BACK, red lighting, a terminal, a figure in your suit, a new tape, and new music. They only use your in-game username and progress. |
| 16 | Daily challenges | ✅ | **The challenges:** 3 a day (easy, medium and hard), changing at midnight UTC, each with a reward and a countdown. **Protection:** claimed rewards are saved so they can't be claimed twice, and winding the clock back pauses rewards. 🟡 **Local only:** progress is saved on your device and is not checked by a server, and the game says so. |
| 17 | Monster encyclopedia | ✅ | **What it covers:** every monster from 0–19, including the Copycat, the Watcher and the Undertow. **How it fills in:** entries unlock in 3 steps as you meet monsters, escape them and play their tapes. It also shows how many times you met and escaped each one. |
| 18 | Rare suits & cosmetics | ✅ | **The suits:** 9 earned suits from Common to Secret, each with its own unlock rule. **Where you see them:** in the shop (locked ones show their unlock rule instead of a price) and in the 🏆 RARE SUITS app, with a preview and equip button. **Fairness:** they never cost money twice, and they protect you no better than a Rare suit. |
| 19 | Death replays | ✅ | **What it records:** the last ~20 s, including your position and view direction, monster movement, sounds, damage, objectives and the final attack. **How you watch it:** a 3D view rebuilt from those records, plus a mini-map, with play/pause, a timeline, 0.5×/1×/2× speed and a return button. It is labelled as a reconstruction, not a video. |
| 20 | Difficulty modes | ✅ | **The 4 modes:** CASUAL, NORMAL, NIGHTMARE and DON'T LOOK BACK, chosen before each run. **What they change:** monster speed and senses, supplies, battery and sanity drain, extra objectives, how often events happen, the number of mutations and the money you earn. **DON'T LOOK BACK only:** no save spot, and dying ends the run. It is still always beatable. |
| 21 | Endings A–H + final cinematic | ✅ | **Level 19 endings:** A, plus B, C and D if you've earned them, offered as choices at the exit. **Other endings:** E comes from the Watcher corridor on Level 19 once you know the truth. F and G come from the Void Elevator in Level 20. H happens if you choose the loop or get caught in Level 20. **The cinematic:** it plays after F and G, and is clearly labelled as fictional, including the fictional news report. You can rewatch it in ✦ SECRETS. |
| 22 | Multiplayer & saves | ⛔/✅ | ⛔ Online play, syncing, disconnect handling and host migration are not possible without a server. The game says this instead of faking it. ✅ Saves use the existing save slots, every new data key is per slot, and rewards are protected from double claims. |
| 23 | Phone integration | ✅ | **New apps:** RUN, DAILY, VHS ARCHIVE, ENCYCLOPEDIA, SECRETS, RARE SUITS and GADGETS. They sit alongside the existing map, scanner, notes, photos, recorder, wallet and settings, and they all use real game data. |
| 24 | UI & audio | ✅ | Emergency lights, captions for sound cues, fluorescent flicker, VHS effects and directional monster sounds, all respecting the accessibility settings. |
| 25 | Technical | ✅ | **Spawning:** things only appear in places you can reach, and puzzles always have a solution. **Stability:** every new block is wrapped so that if one fails, the game keeps working. **Tuning and admin:** the main values are adjustable. Admin buttons for testing every feature are in the admin panel (WORLD tab). |

## Tests run
- Every level 0–19 loads and plays with no errors. This uses the full test sweep: items, shop, inventory, stun gun, save spot, vents, doors, lockers, elevator and escape.
- The objectives on Levels 10–19 can still be completed while a NIGHTMARE run with mutations is active.
- **Difficulty:** speeds, battery and sanity drain, and extra objectives change correctly for each mode.
- **Lights-out:** the generator restarts the lights, and the mutations work.
- **Runs:** the DON'T LOOK BACK mode run ends when you die.
- **Daily challenges:** a reward can't be claimed twice, and a clock rollback is detected.
- **Elevator:** all 7 anomaly types play and the ride always finishes.
- **Control room:** keycards open the door, the password works, all stations work, and the monitors show live cameras.
- **Other secrets:** the Watcher challenge, all 6 fake realities and the nightmare level were tested.
- **Monsters and tapes:** Copycat state changes, VHS pickup, TV playback and archiving, and the encyclopedia all work.
- **Stage 3:** rescues, Stalker, the containment facility, Level 20, endings, the cinematic, cosmetics and replays were tested.

# Stage 4 — Complete Lore and Story Expansion

The organization is now **the Threshold Project** everywhere; the old "Aster Institute" name is gone. All lore lives in the new 📚 LORE ARCHIVE phone app, which shows a lore completion % and keeps everything you collect in your save.

| # | Part | Status | What's in the game |
|---|---|---|---|
| 1 | The original mystery | ✅ | **Experiment 001** (14 Oct 1987): the Aperture opens, the first team walks in, and their signals come from impossible places. **Later documents:** doors nobody built, the Project starting to contain something, and the Final Directive: close the door. |
| 2 | The First Wanderers | ✅ | **Five explorers:** Elena Voss, Tomas Reyes, Ilse Marrow, Kit Okonkwo and Ruth Calloway. **What each one has:** a role, a reason for going in, a fear, and recordings that grow more desperate. **Their fates:** each fate unlocks only after you find a specific recording. One is death, one is a disappearance, one may have become part of the Backrooms, and one left clues for you. Tomas is Dana's father, which is why she came looking in 1994. |
| 3 | The Boiled One | ✅ | **Rare sightings that never attack:** it watches from a long hallway, the level goes silent, electronics fail, it stands behind you in a "safe" room and vanishes when you look, and cryptic phone messages arrive. **Evidence about it:** hospital files from 1979, a "Subject Zero" file with no experiment behind it, appearances on camera only, and damaged tapes that show it even where the camera wasn't pointing. Its origin is never confirmed. |
| 4 | VHS categories | ✅ | **12 new titled tapes** across the 6 categories: Expedition, Research, Incident, Warning, Corrupted and Future. Each has a recorder, place, date, a playable transcript with subtitles, a clue and links to related tapes. **Contradictions on purpose:** Tomas's two "last" messages disagree, and the Boiled One's origin differs between tapes. |
| 5 | Monster lore | ✅ | Possible origins for 11 monsters. They unlock as you meet and escape each monster, and none is confirmed. |
| 6 | Level-by-level story | ✅ | One required story clue on every level 0–19. It is always placed near the start in a reachable spot and follows that level's story from the prompt. Optional collectibles are randomized per run. **Level 20:** a records-of-previous-runs wall and the "deepest record". |
| 7 | Player identity | ✅ | **Where you show up:** the hotel register (checked in tomorrow), a hospital file and the library's book are under your username, and the Flight 0 manifest lists your name. **Other clues:** a dashcam describes your real progress, a future tape shows your suit, and an unknown sender texts you on 8 levels. **Footsteps:** after one tape, the extra footsteps copy yours. All of it uses only your in-game name, suit and progress. |
| 8 | Threshold documents | ✅ | The 8 documents from the prompt. The Personnel Report holds the code for the sealed filing room on Level 5, which you open on a keypad to get Kit's hidden tape. |
| 9 | The final truth | ✅ | **Theory board:** Experiment, Discovery and Observation, plus the Boiled One, with evidence counts that never resolve. **Your choice:** before the Void Elevator you choose what you believe, and the ending text remembers it. |
| 10 | Multiplayer story | ⛔ | There is no server, so shared sessions are not possible. Everything works solo. |
| 11 | Story delivery | ✅ | **Ways the story reaches you:** tapes, audio logs, terminals, notes, photos, cameras, elevator announcements, monster behavior, hidden rooms, menu changes and the cinematic. **Pacing:** nothing is unskippable, and the cinematic can be skipped. |
| 12 | Implementation | ✅ | **Reliability:** required clues are always reachable. **Saves:** found and played states are saved in each save slot. **Admin:** the WORLD tab has buttons to add all lore and to summon a Boiled One sighting. |

# Stage 5 — More stuff
| Feature | What it does |
|---|---|
| Compass & objective markers | **Display:** a compass bar at the top of the screen. **Markers:** the exit (green once it's unlocked), the nearest objective item, story clues, discovered tapes, generators and the control room. **Toggle:** press O to show or hide it. |
| Hold your breath | **How:** hold SPACE while hiding in a locker. **Effect:** monsters searching nearby notice you 80% less. **Limit:** you have about 8 seconds of air, and running out makes you gasp, which makes noise. |
| ENDLESS mode | **Where:** a main menu button. **How it works:** escape a level and you drop into a random level you've found, each wave faster and darker. **Stakes:** one life, and your best score is saved. |
| 🏅 TROPHIES | **Phone app:** 20 trophies covering every system, each with a progress bar and a cash reward. |
| Wall writing | **What:** 4–6 handwritten messages on the walls of every level, including warnings, tips and lore, and sometimes your name. |

# Stage 6 — Player model, third-person view, drone maps
| Feature | What it does |
|---|---|
| New player model | **What it has:** a suited explorer built from many parts: helmet with a dark glass visor, mask filters, headlamp, air tank or your backpack, belt and pouches, reflective stripes, name tag with your username, boots, gloves and a flashlight in the right hand. **Customization:** it is coloured by your suit and shows your accessories (cap, glasses, mask, gloves, backpack). **Where else it's used:** the phone camera, previews and selfies. |
| Third-person view (7) | **Views:** press 7 to cycle first-person, over-the-shoulder and far. **Movement:** the model walks, runs, crouches, leans and points the flashlight. **Walls:** the camera never goes through walls; with no room behind you it rises up near the ceiling. |
| Drone aerial map (B) | **Opening it:** press B or use MAP on the phone. **With a Mapping Drone:** a real top-down photo of the level, with a scanning reveal when the drone launches. **Without one:** only the areas you've explored. **Icons:** exit, objectives, story clues, tapes, wanderers, generators, vents, doors, batteries and water. **Extras:** your trail, zoom and pan, and click to set a waypoint that shows on the compass. |


## Hide and Seek mode + admin entity transformation

| Feature | Status | Notes |
|---|---|---|
| Hide and Seek menu | ✅ | Quick Play, Create Lobby, Join Lobby, Private Match, Choose Map, Choose Rules, Character, How to Play, Stats, Back. |
| Public matchmaking / joining other people | ⛔ | Needs an online server. Quick Play and lobbies fill every slot with AI players. Join Lobby explains why no lobby can be found. |
| Private lobbies with join codes | 🟡 | A code is made and shown, but it only works locally. |
| Ready check, host rules, map choice | ✅ | All AI players get ready over a few seconds. The host sets role, seekers, AI count, hiding time, round length, speed, abilities and all-props. |
| Random seekers, head start, synced countdown | ✅ | The seeker is chosen at random, or set in the rules. Seekers see a black countdown screen and can't move. 🟡 "Synced" only means synced locally, since there is no server. |
| Prop disguises (map props, all-props toggle) | ✅ | 35 props in 12 map sets. Prop wheel with icons. Rotate, cooldown, no transforming in walls. Pop sound and smoke. The player model, name tag and health bar are hidden while disguised. |
| Seeker tag, detection pulse, timer, hiders left | ✅ | Tag checks range and line of sight, and a miss adds a cooldown. The pulse has 3 uses with a cooldown. The HUD shows the timer and how many hiders are left. |
| Hider abilities | ✅ | Quick Transform, Silent Movement, Decoy Prop, Last Chance. Each can be used once per round and turned off by the host. |
| Round flow, win checks, results, play again | ✅ | Seekers win if every hider is tagged, hiders win if any hider survives. |
| Disconnects / late joiners | ⛔ | There are no other real players to disconnect or join. If you cancel or leave, the round simply ends. |
| Rewards, daily challenge, stats, anti-farm | ✅ | Points, wallet cash, streaks and stats. Cash capped per round and per day. No cash for rounds under 1 minute. Each daily challenge can only be claimed once a day. |
| Admin ENTITY tab (24 entities, Levels 0–20) | ✅ | Search, filters, model preview and info. Player-controlled and AI-controlled modes. Size, speed, sounds, effects, AI, reset, spawn, abilities. |
| Permission toggles with warnings | ✅ | Attack, damage, jumpscares and ignore-limits ask for confirmation first. 🟡 Fly is a hover: the map is flat, so walls still block you. 🟡 "Visible to all" has no effect until there is a server. |
| Safety | ✅ | No death while transformed. Objectives and items are never touched. Health is restored when you change back. Choose whether to keep or drop the transformation when you change level (keeping it is checked against your admin login again). |
| Server-side admin checks | ⛔ | No server exists. The admin role, rate limit and audit log run in the browser. The admin key is stored only as a PBKDF2 hash. Nothing in the panel runs code typed by the user. |


## THE MOVIE: WHAT WENT DOWN

| Feature | Status | Notes |
|---|---|---|
| Movie section on the main menu | ✅ | 🎬 button with an animated poster, under PLAY in MODES. The movie menu shows the explorer with a flashlight, the yellow hallway, a watching silhouette, flickering lights and VHS lines. |
| WATCH / CONTINUE / CHAPTERS / SETTINGS / BACK | ✅ | CONTINUE only shows up when you have a saved position. The movie's description text is included. |
| Optional, separate from saves | ✅ | Tested: every game save key is unchanged after watching. The movie progress is stored in its own key (`brmovieP`). |
| Real playback, not a fake player | ✅ | A sequenced real-time cinematic: 15 chapters, 180 shots. Every frame is worked out from the time on the playhead, so seeking, chapters and resume always land on the right picture. |
| Runtime under 30 minutes | ✅ | 28:00 exactly. |
| Every level 0–20 | ✅ | Ch1–2: Level 0 · Ch3: 1 · Ch4: 2 · Ch5: 3–4 · Ch6: 5–6 · Ch7: 7–8 · Ch8: 9 · Ch9: 10–11 · Ch10: 12–13 · Ch11: 14–15 · Ch12: 16–17 · Ch13: 18–19 · Ch14: 20. |
| All the cutscenes in the spec | ✅ | The fall, the first sighting, the Level 0 chase, the elevator escape, the Poolrooms creature, the hotel register, the Threshold report, the Boiled One on tape, the Void doorways, the final VHS, the final elevator, waking at home, the window. |
| Shot types | ✅ | First person, third-person tracking, wide, close-up, over the shoulder, security camera, VHS footage, slow pans, orbits and dolly-zoom. |
| The Wanderer | ✅ | Everyday jacket, hoodie, jeans and backpack, with a flashlight. Walks, runs, crouches, hides, kneels, holds things, presses buttons and lies down. His breathing, shaking hands, brows, eyes and mouth react to fear. 🟡 The face is simple and low-poly, like the rest of the game's art. |
| Graphics | 🟡 | Real-time shadows from the flashlight (High), fog, dust, water with mirrored reflections, film grain, vignette, VHS and camera overlays, ACES tone mapping. **Not possible in this engine:** true depth of field and volumetric light. Light beams are faked with glowing planes. |
| Sound | ✅ | All sound is generated live: fluorescent hum, footsteps that change with the floor, breathing, a music pad, stings, room tones, radio static, elevator machinery, a train, bells, and the final horror sound. No audio files are used, so there is nothing that needs a licence. |
| Dialogue | ✅ | Subtitles only. Spoken text-to-speech lines were removed at the player's request. |
| Player controls | ✅ | Play/pause, ±10 s, skip scene, previous/next chapter, seek bar, subtitles, full screen, volume per channel, quality, and back to the menu. |
| End screen | ✅ | WATCH AGAIN · CHAPTERS · RETURN TO MAIN MENU. It never sends you into the game. |
| Performance | ✅ | Only one chapter is in memory at a time, and it is freed when you leave it. While the movie plays, the game stops drawing frames. Low quality uses fewer lights, no shadows, a lower resolution and no grain. |

## The Forgotten Security Office
- [x] Secret SECURITY door on Level 0 and Level 5; enter with E; leave by the entry door or the emergency exit (unlocked after the letter)
- [x] Open office with cubicles, desks, chairs, monitors, keyboards, phones, cups, papers, printer, filing cabinets
- [x] Security control room with a 12-screen wall (live, one small feed refreshed at a time), ceiling and wall cameras
- [x] Flickering fluorescent light that sometimes goes out; buzzing, distant footsteps, static
- [x] Broken elevator, locked emergency exit, clock stopped at 3:33, THRESHOLD PROJECT computer, map of all levels, locked NATHAN office
- [x] Nathan's letter: exact text, big HELP, stains, folds, red fingerprint; [E] READ LETTER close-up; saved as NATHAN'S LAST MESSAGE
- [x] Camera system: numbered feeds, switch, zoom, vanishing figure, Hallway 7-B, stand-in of the player, CAMERA 20 (approaching figure, view from behind, IT KNOWS YOU ARE WATCHING), rare signal loss
- [x] Rare events: printer with username, NATHAN IS STILL HERE, disconnected phone whisper (caption), future feed, Wanderer reports, DO NOT SHOW NATHAN corrupted footage
- [x] Final event: live desk view, NATHAN DIDN'T WRITE THIS, SO WHO DID?, black, quiet footsteps, no jumpscare
- [x] Movie chapter 7 using the same layout and the same letter drawing (FSO.build / FSO.drawLetter)
- [ ] Multiplayer sync: not possible, the game has no server

## Newcomer help (first Level 0)
- [x] Active only on Level 0 until the first escape; not in Nightmare / Don't Look Back; H turns it off
- [x] Casual + mutations off preselected for brand-new players (still changeable)
- [x] 45 s sleeping Boiled One, then 30% slower
- [x] Guide with keycard count, arrow and distance; then elevator (or fuse)
- [x] Light beams over keycards / fuse
- [x] Half sanity and battery drain; no blackouts; 14-1-20-8-1-14 kept away; 2 starter Almond Waters; step-by-step tips
