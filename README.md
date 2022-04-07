# Deadbolt-GameMaker-1.4

Public repo for modding [Deadbolt](https://store.steampowered.com/app/394970/DEADBOLT/) in GameMaker 1.4.

**Contains no actual game source code.**

## Tools

| Name | Description |
| ---- | ----------- |
| [UMT](https://github.com/krzys-h/UndertaleModTool) | Edit code and sprites. Fast and easy to use |
| [Gamemaker 1.4 Docs](https://gmsdocs.codemuffin.com/1.4.1749/) | Learn GameMaker's language, GML. The link is actually to a self-hosted mirror of the 1.4.1749 docs (which aren't online anymore) |
| [Gamemaker Studio 1.4.1749](https://github.com/ithinkandicode/Deadbolt-GameMaker-1.4/issues/11) | (Optional) Apply your mods in the original development environment, and re-compile the game. The is the best approach for huge mods requiring new scripts and refactors, but it's slow to compile and there are many issues to fix. The [issues](https://github.com/ithinkandicode/Deadbolt-GameMaker-1.4/issues) will help you here. <sup>\*1</sup> |
| [UMT-ExportToProjectScript](https://github.com/ithinkandicode/Deadbolt-GMS-1.4-Misc/issues/33) | (Optional) Use this with UMT to export Deadbolt to an project, which you can open with GMS 1.4. Only works with UMT [v0.3.5.7](https://github.com/krzys-h/UndertaleModTool/releases/tag/0.3.5.7) or below. Use [this PR](https://github.com/ithinkandicode/UndertaleModTool-ExportToProjectScript/tree/fix/12-colkind-BBoxMode), which fixes a breaking issue.

<sup>\*1</sup> <small>Note that a license may be required, and apparently it's not possible to gain one anymore (although you can get a license key from [G2A](https://www.g2a.com/search?query=GameMaker:%20Studio%20Professional), and I believe they can still be used to activate licenses in your YoYoGames account)</small>

## Resources

I've made several spreadsheets while modding Deadbolt. They may contain info that helps with modding.

- [MASTER DATA](https://docs.google.com/spreadsheets/d/1qRyF3laHK2bKYyI552aA5PElzib8ak1FfLNxDId9Lzg/edit#gid=482879943)
- [Editor](https://docs.google.com/spreadsheets/d/1XsQPEOL5d5vsu0OXlZaMR01yTMRrRebbrrtjea6FaHU/edit#gid=0)
- [DB Mod Ref - Indexes](https://docs.google.com/spreadsheets/d/1ZlLrv0tgd8B8AMzEKddYo6MskwjNiJcEcl-W2aAqy-k/edit#gid=678910982)
- [DB Mod Ref - Enums](https://docs.google.com/spreadsheets/d/1zIzck_q13ycJwOZQVV7S25nnjehm8xr932ZGZXNYIQI/edit#gid=758297861)
- [DB Mod Ref - Objects Misc](https://docs.google.com/spreadsheets/d/1_bMv3tmPiZAR0CAgwDnsR3DWfPws7FI7GuVk2VTZrTg/edit#gid=1452938826)

### Enums Sheet

The [Enums sheet](https://docs.google.com/spreadsheets/d/1zIzck_q13ycJwOZQVV7S25nnjehm8xr932ZGZXNYIQI/edit#gid=758297861) is a huge help. Enums are converted to ints automatically, and can't be reverse-compiled.

The weapon enums are especially helpful. They let you work out that this:

`global.weapon[21, 13] = 50`

Translates to this:

`global.weapon[{ Mousegun }, { dmg = 50 }]`

...Because Mousegun (PPistol) has the index 21, and the damage stat is set with the index 13.

### Indexes Sheet

The [Indexes sheet](https://docs.google.com/spreadsheets/d/1ZlLrv0tgd8B8AMzEKddYo6MskwjNiJcEcl-W2aAqy-k/edit#gid=1330816122) is also good, because UMT often doesn't know which objects or sprites certain parts of code refer to (eg. see `use_reactor`).

For example, if you look at the decompiled code for `use_reactor`, you'll see this code:

    switch active_reactor.object_index
    {
        case oSnowSecret:

            if (active_reactor.active == 0)
            {
                active_reactor.active = 1
                oP.state = 16
                oP.inspect_timer = 0
            }
            break

        case 97:

            if (active_reactor.active == 0)
            {
                active_reactor.active = 1
                oP.state = 16
                oP.inspect_timer = -999999
                global.cutscene_timeline = 21
                instance_create(x, y, oCutscene)
            }
            break

		...
	}

We can see that this switch statement loops over various interactive objects, but it doesn't show what object 97 is.

But if you look up object index 97, you'll see that it's for `oCarIbzan`.
