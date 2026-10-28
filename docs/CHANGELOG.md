# Changelog

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
