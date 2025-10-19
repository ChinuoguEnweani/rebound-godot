# Pong — 20 Games Challenge #1

🕹️ Play now  

<iframe frameborder="0" src="https://itch.io/embed/3967028?border_width=0" width="206" height="165"><a href="https://chinuoguenweani.itch.io/pong">Pong by chinuoguenweani</a></iframe>


A simple Pong clone made in **Godot 4**, as part of the **20 Games Challenge**.  
Inspired by the description and goals on the 20 Games Challenge website:

> “Pong was the first widely successful arcade game … Essentially, Pong was a specialized computer designed to bounce a ball between two paddles and keep score.”

---

## 🎯 Goals

The core objectives I set out to implement:

- Create an arena with two walls (top & bottom) and a play area  
- Add paddles on either side, controllable via player input  
- Add a ball that moves and bounces off paddles and walls  
- Detect when the ball exits the playfield and award a point to the appropriate player  
- Track and display player scores  

### Stretch / Bonus Features

- Add sound effects (on paddle hit, wall bounce, scoring)  
- Menu, reset, or simple UI polish  
- Basic AI opponent  

---

## 🕹 How to Play / Controls

| Player | Controls        |
|--------|------------------|
| Left   | W / S (or Up / Down) |
| Right  | Arrow Up / Arrow Down |

---

## 🧩 Implementation Highlights

- Ball movement and bounce logic is based on normalized angles  
- Speed increases slightly after each paddle hit  
- Collision detection handles bouncing off walls and paddles  
- Sound effects triggered on collisions and scoring  
- Reset logic when a point is scored, positioning ball back in center  

---

## 📚 References / Inspiration

- [20 Games Challenge — Pong description and goals](https://20_games_challenge.gitlab.io/games/pong/?utm_source=chatgpt.com)  
- [Godot 4 documentation](https://docs.godotengine.org/en/stable/)

### 🎵 Sounds Used

These are the sound effects used in the game:

| Sound | File | Description |
|-------|------|------------|
| Wall Bounce Sound | [`108737__branrainey__boing.wav`](pong/audio/108737__branrainey__boing.wav) | Wall bounce/collision sound |
| Paddle Hit Sound | [`269718__michorvath__ping-pong-ball-hit.wav`](pong/audio/269718__michorvath__ping-pong-ball-hit.wav) | Played when the ball hits a paddle |
| Score Sound | [`514160__edwardszakal__score-beep.mp3`](pong/audio/514160__edwardszakal__score-beep.mp3) | Played when a player scores |
| Background music | [`Jesús Lastra - Heatstroke.mp3`](pong/audio/Jesús Lastra - Heatstroke.mp3)  | This music is played in the background |

## 🎮 Author & License

**Author:** Chinuogu Enweani 
**License:** All rights reserved

Feel free to clone, fork, or comment on ideas. I’d love feedback or suggestions!

