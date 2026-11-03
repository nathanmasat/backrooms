# Where to put THE BACKROOMS: DON'T LOOK BACK online

The whole game is one file (`index.html`, about 3 MB). Anywhere that can host a web page can host the game. Players just open the link in a browser, on a computer or a phone.

This list has 70+ real places, checked in November 2026. Four of them (section 3) are **distribution networks**: you upload once and they spread the game to **hundreds of partner game sites** automatically. That is the realistic way to get the game onto 100+ websites.

## Before you upload anywhere
- **Use HTTPS.** Co-op, voice chat and the microphone only work on `https://` pages. Every host below gives you HTTPS.
- **Embedded games and the mic.** On game portals the game runs inside a frame on their page. Co-op voice chat needs that frame to allow the microphone, and some portals don't. Solo play always works.
- **Co-op needs outside connections.** Co-op talks to the free PeerJS matchmaking server and to public relay servers. A few portals block that, so co-op may not work there. Solo play is fine.
- **Horror rating.** The game has jump scares and creepy themes. Mark it as horror (13+) where a site asks. Kids' sites won't take it.
- **Ads and SDKs.** Big portals (CrazyGames, Poki, GameDistribution...) want their own ad code (an "SDK") added before they show your game, and they review it first.

---

## 1. Your own website (free, you control it)
| # | Site | Notes |
|---|------|-------|
| 1 | **GitHub Pages**: `https://nathanmasat.github.io/backrooms/` | **You may already have this.** Your repo is public and Pages is switched on. If the link doesn't load: repo → Settings → Pages → Source: "Deploy from a branch", branch `main`, folder `/ (root)`. |
| 2 | Netlify (Netlify Drop) | Drag the folder onto app.netlify.com/drop and get a link in seconds. |
| 3 | Cloudflare Pages | Free, fast everywhere. Connect the GitHub repo or upload the folder. |
| 4 | Vercel | Free hobby plan. Import the GitHub repo. |
| 5 | Firebase Hosting | Google. Free tier. Needs the Firebase command-line tool. |
| 6 | Render (Static Sites) | Free static sites from a GitHub repo. |
| 7 | Surge.sh | `npx surge` in the folder; free `*.surge.sh` link. |
| 8 | Neocities | Free personal sites; upload `index.html` in the browser. |
| 9 | GitLab Pages | Like GitHub Pages, on GitLab. |
| 10 | Codeberg Pages | Free, non-profit Git hosting with Pages. |
| 11 | Bitbucket Cloud static sites | Free `*.bitbucket.io` site from a repo. |
| 12 | SourceHut Pages | Free `*.srht.site` sites. |
| 13 | Azure Static Web Apps | Microsoft. Free plan. |
| 14 | AWS Amplify Hosting | Amazon. Free tier, then pay as you go. |
| 15 | DigitalOcean App Platform | Free tier for static sites. |
| 16 | Deno Deploy | Free tier; can serve a static folder. |
| 17 | Kinsta Static Site Hosting | Free static sites from Git. |
| 18 | Static.app | Upload a folder; free plan has limits. |
| 19 | Tiiny.host | Quickest upload; the free plan has small size and time limits. |
| 20 | InfinityFree | Free classic web hosting (upload by FTP or file manager). |
| 21 | Amazon S3 static website | Not free, but costs pennies; add CloudFront for HTTPS. |
| 22 | Google Cloud Storage website | Same idea as S3. |
| 23 | CodeSandbox | Good for sharing a quick test link. |
| 24 | Replit | Publishing may need a paid plan. |
| — | ~~Glitch~~ | **No longer hosts sites** (ended July 2025). |
| — | ~~000webhost~~ | Closed. |

## 2. Game sites where players browse and play
| # | Site | How you get on it |
|---|------|------|
| 25 | **itch.io** | Open upload, instant. Zip the folder (with `index.html`), choose "HTML", tick "mobile friendly". The best first stop. |
| 26 | **Newgrounds** | Open upload; players vote. Big horror audience. |
| 27 | **Game Jolt** | Open upload, instant listing. |
| 28 | CrazyGames | Submit for "Basic Launch", then they may pick it for a full launch. Needs their SDK for ads. |
| 29 | Y8 | Upload, then they approve it. |
| 30 | Kongregate | Apply to become a developer first, then upload for review. |
| 31 | Poki | Hand-picked. You apply, they playtest. Often want web exclusivity. |
| 32 | Armor Games | Pitch by email; they may sponsor or license the game. |
| 33 | GamePix | Developer portal; also syndicates (see section 3). |
| 34 | Playgama | Developer portal; also syndicates. |
| 35 | Lagged | Has a developer submission page. |
| 36 | IndieDB | A game page with news, screenshots and a download/link. Good for publicity. |
| 37 | Itch.io game jams | Enter a horror or "liminal" jam with the game to get players fast. |

## 3. One upload, hundreds of sites (distribution networks)
| # | Network | What it does |
|---|---------|------|
| 38 | **GameDistribution** | Upload through their dashboard and they review it. If approved, it goes out to their big network of partner game sites, and you share the ad money. |
| 39 | **GameMonetize** | Same idea, its own network of partner sites. |
| 40 | GamePix | Network of publisher sites. |
| 41 | Playgama | Network of partner sites and platforms. |

A game accepted by even one of these usually appears on **hundreds of websites**, all at once.

## 4. Apps and platforms (wrap the web game)
| # | Platform | Notes |
|---|------|------|
| 42 | Discord Activities | Play inside Discord with friends; app review needed. Takes some coding. |
| 43 | Telegram Mini Apps | HTML5 games inside Telegram through a bot. |
| 44 | Facebook Instant Games | HTML5 games in Facebook/Messenger; needs their SDK. |
| 45 | Reddit (Developer Platform) | Interactive posts and games on Reddit; needs their tools. |
| 46 | YouTube Playables | Invite only for now. |
| 47 | TikTok Mini Games | Application-based. |
| 48 | Google Play (as an app) | Wrap the site as an app (Trusted Web Activity / Bubblewrap). One-time developer fee. |
| 49 | Microsoft Store (as an app) | Package the site with PWABuilder. |
| 50 | Apple App Store (as an app) | Wrap with Capacitor; yearly developer fee and Apple review. |
| 51 | Steam (as a desktop game) | Wrap with Electron or NW.js. One-time fee per game. |
| 52 | WeChat / Douyin mini-games | China only; separate approval and tools. |

## 5. Places to share the link and find players
| # | Place | Tip |
|---|------|-----|
| 53 | r/WebGames (Reddit) | Post the playable link, with a GIF. |
| 54 | r/playmygame | Made for this. |
| 55 | r/IndieGaming | Short video clips do best. |
| 56 | r/IndieDev | Show how you made it. |
| 57 | r/backrooms | The fans. Read the rules first. |
| 58 | r/horrorgaming | Horror players. |
| 59 | r/gamedev (Screenshot Saturday) | Weekly showcase thread. |
| 60 | r/threejs | It's a three.js game, so people there love seeing this. |
| 61 | itch.io community forums | "Release announcements" board. |
| 62 | Newgrounds forums | Game dev and horror boards. |
| 63 | TIGSource forums | DevLogs board. |
| 64 | GameDev.net | Showcase and blogs. |
| 65 | Hacker News ("Show HN") | Good for the "it's one HTML file" angle. |
| 66 | Product Hunt | Launch it as a free browser game. |
| 67 | YouTube | A trailer, the movie, and the music video. |
| 68 | TikTok | Short scary clips with the link in your bio. |
| 69 | X / Twitter | #screenshotsaturday, #indiedev, #backrooms |
| 70 | Bluesky | Game dev feeds. |
| 71 | Mastodon (gamedev.place) | Friendly indie dev crowd. |
| 72 | Twitch / YouTube creators | Email horror streamers: Backrooms games are popular to stream. |
| 73 | Discord servers | Indie game and Backrooms fan servers often have a #self-promo channel. |
| 74 | Instagram Reels | Same clips as TikTok. |

---

**The quickest plan:**
1. GitHub Pages, so you have your own link.
2. itch.io, Newgrounds and Game Jolt, which take a few minutes each.
3. GameDistribution and GameMonetize, for the hundreds of partner sites.
4. Post the link on r/WebGames, r/playmygame and r/backrooms.
