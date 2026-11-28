// Loading screen settings. This is the only file you need to change.
// After a change, restart the resource. Players see it the next time they join.

window.DPS_LOADING = {
    serverName: 'Del Perro Sands',

    // ---------- Background ----------
    // Pick ONE of these. The first one that is filled in is used:
    //   youtube  a YouTube video ID: the letters after "watch?v=" in the video's address
    //   video    a video file in this folder, for example 'intro.webm' (add it to fxmanifest.lua too)
    //   images   pictures in this folder, shown one after another
    // If none is set, or the video cannot play, the DPS background is shown instead.
    background: {
        // The video bd_loadingscreen ships with, by GamingCZE11. Swap in your own.
        // Not every video works: if its owner has switched off playing it on other sites, YouTube
        // refuses and the DPS background shows instead. Test your video before you rely on it.
        youtube: 'o9tVz3JbjEs',
        video: '',
        images: [],
        imageSeconds: 8,
        // How dark the layer over the background is, 0 to 1. Higher is easier to read on.
        dim: 0.45,
    },

    // ---------- Words ----------
    // Shown under the player's name. One is picked at random.
    greetings: [
        'Begin your new adventure.',
        'Discover your new city.',
        'Step into a world of new possibilities.',
    ],

    // Shown next to the progress bar, one after another.
    steps: ['Joining server', 'Preparing assets', 'Establishing connection'],

    // ---------- Panels ----------
    // Leave `lines` empty to hide a panel.
    news: {
        title: 'Updates',
        updated: '',
        lines: [],
    },

    info: {
        title: 'Server information',
        lines: [],
    },

    // Staff list. Leave it empty to hide it.
    //   { name = 'Name', role = 'Owner' }
    staff: [],

    // ---------- Links ----------
    // Buttons in the corner. Leave it empty to hide them.
    //   { label: 'Discord', url: 'https://discord.gg/your-invite' }
    links: [],

    // ---------- Music ----------
    // Sound files in this folder (add each one to fxmanifest.lua too). Leave empty for no music.
    // Only use music you have the right to use.
    //   { file: 'song.mp3', title: 'Artist - Song' }
    music: [],
    musicVolume: 0.2,
};
