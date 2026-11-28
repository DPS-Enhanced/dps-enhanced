// DPS loading screen. Settings come from config.js. A port of bd_loadingscreen by BebikDEV:
// the player's name handed over by the server, the changing status line, the news, info and
// staff panels and the music keys are theirs in idea; the code here is rewritten around one
// settings file.

const config = window.DPS_LOADING || {};
const background = config.background || {};

const $ = (id) => document.getElementById(id);

// Text only, never innerHTML: player names and settings must not be able to inject markup.
function setText(id, text) { $(id).textContent = text || ''; }

// ---------- Player name ----------

// server/main.lua hands the name over while the player is still connecting.
const handover = window.nuiHandoverData || {};
setText('player', handover.name ? `, ${handover.name}` : '');

const greetings = config.greetings || [];
setText('greeting', greetings[Math.floor(Math.random() * greetings.length)]);

// ---------- Background ----------

document.documentElement.style.setProperty('--dim', String(background.dim ?? 0.45));

// Any failure simply leaves the DPS backdrop showing, which is always underneath.
function useBackdrop() {
    $('youtube').hidden = true;
    $('video').hidden = true;
}

function startYouTube(id) {
    let ready = false;

    window.onYouTubeIframeAPIReady = () => {
        new window.YT.Player('youtube-frame', {
            videoId: id,
            playerVars: { autoplay: 1, mute: 1, loop: 1, playlist: id, controls: 0, disablekb: 1, modestbranding: 1, rel: 0, playsinline: 1, iv_load_policy: 3 },
            events: {
                onReady: (event) => { ready = true; event.target.mute(); event.target.playVideo(); },
                onError: useBackdrop,
            },
        });
    };

    const frame = document.createElement('div');
    frame.id = 'youtube-frame';
    $('youtube').append(frame);
    // Shown from the start: a player inside a hidden box does not start. The DPS backdrop is
    // underneath, so nothing looks broken while it loads, and a failure hides the box again.
    $('youtube').hidden = false;

    const api = document.createElement('script');
    api.src = 'https://www.youtube.com/iframe_api';
    api.onerror = useBackdrop;
    document.head.append(api);

    // No answer from YouTube in 8 seconds: stop waiting.
    setTimeout(() => { if (!ready) useBackdrop(); }, 8000);
}

function startVideo(file) {
    const video = $('video');
    video.src = file;
    video.onerror = useBackdrop;
    video.oncanplay = () => { video.hidden = false; };
    video.play().catch(useBackdrop);
}

function startImages(files) {
    const slides = files.map((file) => {
        const slide = document.createElement('div');
        slide.className = 'slide';
        slide.style.backgroundImage = `url("${encodeURI(file)}")`;
        $('slides').append(slide);
        return slide;
    });

    let current = 0;
    slides[0].classList.add('on');
    if (slides.length < 2) return;

    setInterval(() => {
        slides[current].classList.remove('on');
        current = (current + 1) % slides.length;
        slides[current].classList.add('on');
    }, (background.imageSeconds || 8) * 1000);
}

if (background.youtube) startYouTube(background.youtube);
else if (background.video) startVideo(background.video);
else if (background.images && background.images.length) startImages(background.images);

// ---------- Panels ----------

function fillPanel(id, panel) {
    if (!panel || !panel.lines || !panel.lines.length) return;

    const element = $(id);
    element.querySelector('h3').textContent = panel.title || '';
    const time = element.querySelector('time');
    if (time) time.textContent = panel.updated || '';

    for (const line of panel.lines) {
        const paragraph = document.createElement('p');
        paragraph.textContent = line;
        element.querySelector('.lines').append(paragraph);
    }
    element.hidden = false;
}

fillPanel('news', config.news);
fillPanel('info', config.info);

if (config.staff && config.staff.length) {
    for (const person of config.staff) {
        const row = document.createElement('li');
        const name = document.createElement('span');
        name.textContent = person.name;
        const role = document.createElement('span');
        role.className = 'role';
        role.textContent = person.role;
        row.append(name, role);
        $('staff').querySelector('ul').append(row);
    }
    $('staff').hidden = false;
}

for (const link of config.links || []) {
    const button = document.createElement('button');
    button.textContent = link.label;
    // The loading screen cannot open a browser tab itself; the game does it.
    button.addEventListener('click', () => window.invokeNative && window.invokeNative('openUrl', link.url));
    $('links').append(button);
}

// ---------- Progress ----------

const steps = config.steps && config.steps.length ? config.steps : ['Loading'];
let step = 0;

setInterval(() => {
    $('step').classList.add('out');
    setTimeout(() => {
        step = (step + 1) % steps.length;
        setText('step', steps[step]);
        $('step').classList.remove('out');
    }, 600);
}, 4000);

setText('step', steps[0]);

// The game reports how far along loading is, 0 to 1. Never let the bar move backwards.
let progress = 0;
window.addEventListener('message', ({ data }) => {
    if (data && data.eventName === 'loadProgress' && typeof data.loadFraction === 'number') {
        progress = Math.max(progress, data.loadFraction);
        $('fill').style.width = `${Math.round(progress * 100)}%`;
    }
});

// ---------- Music ----------

const songs = config.music || [];
const audio = $('audio');
let song = 0;

function playSong(index) {
    song = (index + songs.length) % songs.length;
    audio.src = songs[song].file;
    setText('song', songs[song].title);
    audio.play().catch(() => {});
}

if (songs.length) {
    audio.volume = config.musicVolume ?? 0.2;
    $('music').hidden = false;
    playSong(Math.floor(Math.random() * songs.length));

    window.addEventListener('keydown', (event) => {
        if (event.code === 'Space') audio.paused ? audio.play() : audio.pause();
        else if (event.key === 'ArrowLeft') playSong(song - 1);
        else if (event.key === 'ArrowRight') playSong(song + 1);
        else if (event.key === 'ArrowUp') audio.volume = Math.min(audio.volume + 0.05, 1);
        else if (event.key === 'ArrowDown') audio.volume = Math.max(audio.volume - 0.05, 0);
        else return;
        event.preventDefault();
    });
}
