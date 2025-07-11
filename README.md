# Rap Sheet

A World of Warcraft addon that displays detailed character statistics on hover, providing quick insight into player behavior and performance.

## 📊 Features

- **Need vs Greed Roll Tracking**  
  – Displays how many times a player has rolled *Need*, total count, and percentage of their rolls.  
- **Extended Stats on Ctrl‑Hover**  
  – Arena wins and scores (2‑, 3‑, 5‑man; 2‑ and 3‑team).  
  – Battleground matches played, honor kills (HKs), and respec count.  
  – Dual‑spec status.  
- **Raid & Progress Info**  
  – Kill counts and dates across major raid bosses (Xavius, Helya, Gul'dan, Kil’Jaeden, Argus), including Mythic achievements.  
  – Tracks account‑wide Level 110 and mythic raid boss kill dates.

All data is sourced directly from Blizzard’s API—no third‑party or external scraping required ([curseforge.com](https://www.curseforge.com/wow/addons/rap-sheet/download/2500793?utm_source=chatgpt.com)).

## 🎯 Use Cases

- **Loot leaders** can decide loot distribution strategies based on a player’s Need-roll history.  
- **Raid organizers** can assess a player’s progression and suitability visually, without needing additional add‑ons.

## 🛠️ Installation

1. Download via the CurseForge client or from GitHub.  
2. Extract into your `World of Warcraft/_retail_/Interface/AddOns/` folder.  
3. In-game: hover over a player’s nameplate to view stats; hold **Ctrl** for extended details.

## 🚧 Known Issues & Replacements

- Some users report Git-related issues when updating via CurseForge.  
- If features fail to load, try deleting the add-on folder and re-cloning from your Git server.  
- Confirm that your XML and TOC files are referencing the correct Git paths.

## 🚀 Contributing

Feel free to recreate or improve any aspects of the roll tracking, hover display, or data gathering. Submit PRs for bug fixes, enhancements, or code refactors to align with Blizzard API updates.
