// dps_welcome screen. The game sends 'welcome', 'open' and 'close'; this page sends back 'look'
// (which card you are on) and 'spawn' (which one you picked).

const resource = typeof GetParentResourceName === 'function' ? GetParentResourceName() : 'dps_welcome';

const TAGS = { continue: 'Continue', job: 'Job', public: 'Public', home: 'Home' };

const welcome = document.getElementById('welcome');
const picker = document.getElementById('picker');
const cards = document.getElementById('cards');

let spawns = [];
let selected = 0;
let chosen = false;

function send(name, data) {
    return fetch(`https://${resource}/${name}`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json; charset=UTF-8' },
        body: JSON.stringify(data),
    }).catch(() => {});
}

// dps_lib's theme uses plain names (navy, accent); the style sheet uses --dps-navy, --dps-accent.
function applyTheme(theme) {
    if (!theme) return;
    for (const [name, value] of Object.entries(theme)) {
        if (typeof value === 'string' && value.startsWith('#')) {
            document.documentElement.style.setProperty(`--dps-${name}`, value);
        }
    }
}

function select(index, tellGame) {
    if (!spawns.length || chosen) return;
    selected = (index + spawns.length) % spawns.length;

    [...cards.children].forEach((card, i) => card.classList.toggle('selected', i === selected));
    cards.children[selected].scrollIntoView({ block: 'nearest' });

    if (tellGame) send('look', { index: selected });
}

function choose() {
    if (!spawns.length || chosen) return;
    chosen = true;
    send('spawn', { index: selected });
}

function render() {
    cards.replaceChildren();

    spawns.forEach((spawn, index) => {
        const card = document.createElement('li');
        card.className = `card kind-${spawn.kind}`;

        const tag = document.createElement('span');
        tag.className = 'tag';
        tag.textContent = TAGS[spawn.kind] || 'Spawn';

        const text = document.createElement('div');
        const label = document.createElement('div');
        label.className = 'label';
        label.textContent = spawn.label;
        text.append(label);

        if (spawn.detail) {
            const detail = document.createElement('div');
            detail.className = 'detail';
            detail.textContent = spawn.detail;
            text.append(detail);
        }

        card.append(tag, text);
        // One click looks, a second click on the same card starts there.
        card.addEventListener('click', () => (index === selected ? choose() : select(index, true)));
        cards.append(card);
    });
}

window.addEventListener('message', ({ data }) => {
    if (data.action === 'welcome') {
        document.getElementById('welcome-name').textContent = data.serverName || '';
        document.getElementById('welcome-player').textContent = data.firstName ? `Good to have you, ${data.firstName}.` : '';
        welcome.hidden = false;
    } else if (data.action === 'open') {
        applyTheme(data.theme);
        spawns = data.spawns || [];
        chosen = false;
        document.getElementById('server-name').textContent = data.serverName || '';
        render();
        welcome.hidden = true;
        picker.hidden = false;
        select(0, false);
    } else if (data.action === 'close') {
        picker.hidden = true;
        welcome.hidden = true;
        spawns = [];
    }
});

window.addEventListener('keydown', (event) => {
    if (picker.hidden) return;

    if (event.key === 'ArrowUp' || event.key === 'w') select(selected - 1, true);
    else if (event.key === 'ArrowDown' || event.key === 's') select(selected + 1, true);
    else if (event.key === 'Enter') choose();
    else return;

    event.preventDefault();
});
