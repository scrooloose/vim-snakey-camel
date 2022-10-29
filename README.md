```
  █████████                       █████
 ███░░░░░███                     ░░███
░███    ░░░  ████████    ██████   ░███ █████  ██████  █████ ████
░░█████████ ░░███░░███  ░░░░░███  ░███░░███  ███░░███░░███ ░███
 ░░░░░░░░███ ░███ ░███   ███████  ░██████░  ░███████  ░███ ░███
 ███    ░███ ░███ ░███  ███░░███  ░███░░███ ░███░░░   ░███ ░███
░░█████████  ████ █████░░████████ ████ █████░░██████  ░░███████
 ░░░░░░░░░  ░░░░ ░░░░░  ░░░░░░░░ ░░░░ ░░░░░  ░░░░░░    ░░░░░███
                                                       ███ ░███
                                                      ░░██████
                                                       ░░░░░░
   █████████                                     ████
  ███░░░░░███                                   ░░███
 ███     ░░░   ██████   █████████████    ██████  ░███
░███          ░░░░░███ ░░███░░███░░███  ███░░███ ░███
░███           ███████  ░███ ░███ ░███ ░███████  ░███
░░███     ███ ███░░███  ░███ ░███ ░███ ░███░░░   ░███
 ░░█████████ ░░████████ █████░███ █████░░██████  █████
  ░░░░░░░░░   ░░░░░░░░ ░░░░░ ░░░ ░░░░░  ░░░░░░  ░░░░░
```

We live in a world where all the cases have come together into a single, giant mega-orgy
in and around our web browsers. Sometimes implementing a single feature can require the same
names to be specified in 3 or more different cases across the project! A tool is needed
to bring order to this orgiastic chaos.

---

Convert words to different cases! A sad necessity in our world of colliding web languages.

Supports all your favourites:
* Snake and screaming snake
* Camel and upper camel
* Kebab and screaming kebab

Install [repeat.vim](https://github.com/tpope/vim-repeat) to repeat case conversions with `.`

![Snakey Camel Demo](https://github.com/scrooloose/vim-snakey-camel/raw/master/demo.gif)

## Usage

Put your cursor on a word and use the following mappings

| Map          | Converts current word to                                               |
|--------------|------------------------------------------------------------------------|
| `<leader>ss` | To snake case                                                          |
| `<leader>sS` | To upper snake case                                                    |
| `<leader>sc` | To camel case                                                          |
| `<leader>sC` | To upper camel case                                                    |
| `<leader>sk` | To kebab case                                                          |
| `<leader>sK` | To screaming kebab case                                                |
| `<leader>s.` | Cycles through the most common cases - use once then repeat with (dot) |
| `.` (dot)    | repeat last conversion (requires repeat.vim)                           |

## Overriding mappings

If the default mappings don't satisfy you, simply create another mapping and
the default will go away.

Example:
```vim
nmap <leader>XX <Plug>SnakeyCamelToScreamingKebab
```

See below for a list of the other plug mappings to map to.

| \<Plug\> Map                      |
|-----------------------------------|
| <Plug>SnakeyCamelToSnake          |
| <Plug>SnakeyCamelToScreamingSnake |
| <Plug>SnakeyCamelToCamel          |
| <Plug>SnakeyCamelToUpperCamel     |
| <Plug>SnakeyCamelToKebab          |
| <Plug>SnakeyCamelToScreamingKebab |
| <Plug>SnakeyCamelToNextInCycle    |
