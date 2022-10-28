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

## Mappings

Put your cursor on a word and do one of the following:
```
<leader>ss   --> convert to snake case
<leader>sS   --> convert to upper snake case
<leader>sc   --> convert to camel case
<leader>sC   --> convert to upper camel case
<leader>sk   --> convert to kebab case
<leader>sK   --> convert to screaming kebab case
. (dot)      --> repeat last conversion (requires repeat.vim)
```
