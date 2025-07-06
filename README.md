# Faction Forge (Work in Progress)

**Faction Forge** is a personal solo game development project built in Godot. While still in progress, this project serves as a way for me to showcase what I’ve learned about system design, UI, and gameplay logic as I build toward a larger vision.

---

## Vision

The core idea behind Faction Forge is to create a community-oriented trading card game where character creation and battles happen through a mobile app, but **character data is stored on physical NFC cards**.

My goal is to encourage in-person play at local game stores — blending digital convenience with real-world interaction.

---

## Image Options (Planned Features)

Each character will have a custom image stored on their NFC card. I’m currently testing three user-selectable options:

1. **AI-generated art via API** (working, but still integrating image display in-game)
2. **Manual image upload from device**
3. **Commissioned art from linked artist portfolios**

Once an image is saved to a card, it becomes permanent — no overwrites. A new card would be required for a new image.

---

## Technical Highlights

- **Character Creator**  
  Fully working UI for selecting race, class, and up to four skills.  
  Skills auto-filter based on class/race and display estimated damage values.

- **Effects System**  
  Midway through development, I refactored the skill system to support attachable effect objects (e.g. *stun*). Effects are assigned at runtime and will activate during battle once fully implemented.

- **NFC Integration**  
  NFC card saving is not yet complete, but I’m actively working on integrating it with Godot.

- **AI Image Generation**  
  API call successfully returns an image link. Still working on integrating this into the in-game character slot.

---

## Current Scene Functionality

### Character Creation
- Works as intended (with the caveat that skipping skill/name input may break battle mode).
- Displays selected skills and their calculated damage.
- Placeholder for effects display.

### Battle Setup
- Users select 3v3 (*Skirmish*) or 6v6 (*War*) formats.
- Character team selection via tabs (no duplicate character checks yet).
- Future version will require NFC scan instead of manual team setup.

### Battle Scene
- Players select skills and targets using dropdowns.
- Ready buttons trigger round resolution when both sides are ready.
- Visual indicators show attacker/target.
- Effects/stats panels are working.
- Logic exists to prevent characters from acting without resources or HP, but some parts are currently disabled for testing.

### Duty Roster
- Displays all created characters in a scrollable list.
- Will eventually be redesigned to resemble a card binder with flip-through pages.

### Faction Forge (Planned)
- Will be used to create official teams for 6v6 tournament play.
- Generates a “faction card” that stores a permanent copy of selected units.

### Medical Tent (Planned)
- Characters will heal passively between battles. No manual interaction required.

### History (Planned)
- Will track W/L records for each character.

---

## Development Notes

This project is still under active development. Some features are disabled, broken, or in placeholder form for testing purposes. Known limitations:
- No enforcement of character creation requirements
- Duplicate characters can be assigned to both teams
- Ready button can prematurely skip rounds

Despite these, I’ve used this project as a learning tool to deepen my understanding of:
- UI management
- Data filtering and sorting
- Modular system design
- Problem-solving and refactoring
- Working toward NFC and API integration

---

## Contact

If you’d like a walkthrough of the working systems or a deeper look at how any feature was implemented, feel free to reach out.

