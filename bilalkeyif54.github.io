<!DOCTYPE html>
<html lang="de">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>EA FC 26 - Pack Opener & Squad Builder</title>
    <style>
        body {
            font-family: 'Arial Black', sans-serif;
            background-color: #0b0e14;
            color: white;
            text-align: center;
            margin: 0;
            padding: 20px;
            overflow-x: hidden;
        }
        h1 { color: #f5c423; text-shadow: 2px 2px 5px #000; letter-spacing: 2px; font-size: 28px; }
        .btn {
            background: linear-gradient(135deg, #f5c423, #b8860b);
            color: black; border: none; padding: 15px 35px;
            font-size: 18px; font-weight: bold; cursor: pointer;
            border-radius: 4px; box-shadow: 0 0 15px rgba(245, 196, 35, 0.4);
            transition: 0.2s; text-transform: uppercase;
        }
        .btn:hover { transform: scale(1.05); box-shadow: 0 0 25px rgba(245, 196, 35, 0.7); }
        
        /* PACK ANIMATION CONTAINER */
        #stage {
            display: flex; justify-content: center; align-items: center;
            margin-top: 30px; min-height: 320px; position: relative;
        }
        .fc-pack {
            width: 160px; height: 240px;
            background: linear-gradient(135deg, #1a2238, #0a0d1a);
            border: 3px solid #f5c423; border-radius: 10px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.8);
            display: flex; flex-direction: column; justify-content: center; align-items: center;
            cursor: pointer; transition: 0.5s; position: absolute;
            animation: float 3s ease-in-out infinite;
        }
        @keyframes float { 0%, 100% { transform: translateY(0) rotate(0deg); } 50% { transform: translateY(-10px) rotate(1deg); } }
        .fc-pack-logo { font-size: 32px; font-weight: bold; color: #f5c423; text-shadow: 0 0 10px #f5c423; }
        
        /* ANIMATIONS-KLEBEN */
        .pack-open-anim { animation: openPackEffect 1.5s forwards ease-in-out !important; }
        @keyframes openPackEffect {
            0% { transform: scale(1) rotate(0deg); filter: brightness(1); }
            50% { transform: scale(1.2) rotate(-5deg); filter: brightness(2); }
            90% { transform: scale(0.1) rotate(180deg); opacity: 1; filter: brightness(5); }
            100% { transform: scale(0); opacity: 0; }
        }

        #pack-container { display: flex; justify-content: center; gap: 15px; flex-wrap: wrap; width: 100%; }

        /* EA FC ORIGINAL KARTEN DESIGN */
        .fc-card {
            width: 160px; height: 240px; position: relative;
            background-size: cover; border-radius: 8px;
            clip-path: polygon(18% 0%, 82% 0%, 100% 12%, 100% 85%, 50% 100%, 0% 85%, 0% 12%);
            box-shadow: 0 8px 20px rgba(0,0,0,0.7);
            color: black; text-align: center; cursor: pointer;
            transform: scale(0); animation: cardPop 0.5s forwards cubic-bezier(0.175, 0.885, 0.32, 1.275);
        }
        @keyframes cardPop { to { transform: scale(1); } }
        .gold-card { background: linear-gradient(135deg, #ffe066 0%, #f5c423 50%, #b8860b 100%); border: 1px solid #fff; }
        .silver-card { background: linear-gradient(135deg, #e0e0e0 0%, #b0b0b0 50%, #707070 100%); border: 1px solid #fff; }
        
        .card-top { position: absolute; top: 20px; left: 15px; text-align: left; line-height: 1.1; }
        .card-rating { font-size: 28px; font-weight: 900; margin: 0; }
        .card-pos { font-size: 12px; font-weight: bold; opacity: 0.8; text-transform: uppercase; }
        
        .card-badge { width: 25px; height: 25px; background: rgba(0,0,0,0.1); border-radius: 50%; position: absolute; top: 22px; right: 15px; }
        .card-face { width: 95px; height: 95px; background: rgba(255,255,255,0.2); border-radius: 50%; margin: 45px auto 0 auto; display: flex; align-items: center; justify-content: center; font-size: 35px; }
        
        .card-name { font-size: 14px; font-weight: bold; margin: 10px 0 2px 0; text-transform: uppercase; text-shadow: 0px 1px 1px rgba(255,255,255,0.5); padding: 0 5px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap; }
        .card-club { font-size: 10px; font-weight: bold; opacity: 0.7; }
        .card-league { font-size: 9px; font-weight: bold; color: #111; margin-top: 2px; font-style: italic; }

        /* SQUAD BUILDER (SPIELFELD) */
        h2 { color: #f5c423; margin-top: 50px; text-transform: uppercase; font-size: 20px; }
        #pitch {
            width: 100%; max-width: 560px; height: 640px;
            background-color: #2e6f40; background-image: radial-gradient(#39844c 40%, transparent 41%), linear-gradient(rgba(255,255,255,0.1) 2px, transparent 2px);
            background-size: 100% 100%, 100% 80px; border: 4px solid white;
            margin: 20px auto; border-radius: 12px; position: relative;
            box-shadow: 0 10px 30px rgba(0,0,0,0.5);
        }
        #pitch::before {
            content: ''; position: absolute; top: 50%; left: 0; right: 0; height: 2px; background: white;
        }
        #pitch-center {
            position: absolute; top: 50%; left: 50%; width: 100px; height: 100px;
            border: 2px solid white; border-radius: 50%; transform: translate(-50%, -50%);
        }
        
        /* AUFSTELLUNG POSITIONEN (4-3-3 FORMATION) */
        .pitch-pos {
            position: absolute; width: 85px; height: 110px;
            border: 2px dashed rgba(255,255,255,0.4); border-radius: 6px;
            transform: translate(-50%, -50%); display: flex; flex-direction: column;
            justify-content: center; align-items: center; cursor: pointer; transition: 0.2s;
        }
        .pitch-pos:hover { background: rgba(255,255,255,0.15); border-color: white; }
        .pos-label { font-size: 12px; font-weight: bold; background: rgba(0,0,0,0.6); padding: 2px 6px; border-radius: 4px; color: #f5c423; }
        
        /* Positionen Koordinaten */
        .pos-lw  { top: 15%; left: 20%; }
        .pos-st  { top: 10%; left: 50%; }
        .pos-rw  { top: 15%; left: 80%; }
        .pos-lcm { top: 42%; left: 25%; }
        .pos-cm  { top: 46%; left: 50%; }
        .pos-rcm { top: 42%; left: 75%; }
        .pos-lb  { top: 70%; left: 15%; }
        .pos-lcb { top: 73%; left: 38%; }
        .pos-rcb { top: 73%; left: 62%; }
        .pos-rb  { top: 70%; left: 85%; }
        .pos-gk  { top: 90%; left: 50%; }

        /* Kleine Karte im Spielfeld */
        .pitch-pos .fc-card { width: 100%; height: 100%; top: 0; left: 0; position: absolute; }
        .pitch-pos .card-rating { font-size: 16px; }
        .pitch-pos .card-top { top: 8px; left: 8px; }
        .pitch-pos .card-face { width: 45px; height: 45px; margin: 20px auto 0 auto; font-size: 20px; }
        .pitch-pos .card-name { font-size: 10px; margin: 4px 0 0 0; }
        .pitch-pos .card-club, .pitch-pos .card-league, .pitch-pos .card-badge, .pitch-pos .card-pos { display: none; }
    </style>
</head>
<body>

    <h1>EA SPORTS FC 26 PACK OPENER</h1>
    <button class="btn" onclick="triggerPackAnimation()">Pack öffnen</button>

    <div id="stage">
        <div id="pack" class="fc-pack" onclick="triggerPackAnimation()">
            <div class="fc-pack-logo">FC 26</div>
            <div style="font-size:12px; margin-top:10px; color:#aaa;">GOLD PACK</div>
        </div>
        <div id="pack-container"></div>
    </div>

    <h2>Dein Squad Builder (Klicke Spieler zum Aufstellen an)</h2>
    <p style="font-size: 13px; color: #aaa; margin-top: -10px;">Formation: 4-3-3</p>
    
    <div id="pitch">
        <div id="pitch-center"></div>
        <div class="pitch-pos pos-lw" onclick="placeSelectedPlayer('LW')"><span class="pos-label">LF</span></div>
        <div class="pitch-pos pos-st" onclick="placeSelectedPlayer('ST')"><span class="pos-label">ST</span></div>
        <div class="pitch-pos pos-rw" onclick="placeSelectedPlayer('RW')"><span class="pos-label">RF</span></div>
        <div class="pitch-pos pos-lcm" onclick="placeSelectedPlayer('LCM')"><span class="pos-label">ZM</span></div>
        <div class="pitch-pos pos-cm" onclick="placeSelectedPlayer('CM')"><span class="pos-label">ZM</span></div>
        <div class="pitch-pos pos-rcm" onclick="placeSelectedPlayer('RCM')"><span class="pos-label">ZM</span></div>
        <div class="pitch-pos pos-lb" onclick="placeSelectedPlayer('LB')"><span class="pos-label">LV</span></div>
        <div class="pitch-pos pos-lcb" onclick="placeSelectedPlayer('LCB')"><span class="pos-label">IV</span></div>
        <div class="pitch-pos pos-rcb" onclick="placeSelectedPlayer('RCB')"><span class="pos-label">IV</span></div>
        <div class="pitch-pos pos-rb" onclick="placeSelectedPlayer('RB')"><span class="pos-label">RV</span></div>
        <div class="pitch-pos pos-gk" onclick="placeSelectedPlayer('GK')"><span class="pos-label">TW</span></div>
    </div>

    <script>
        const players = [
            // PREMIER LEAGUE
            { name: "M. Salah", rating: 91, club: "Liverpool", league: "Premier League", pos: "RW", emoji: "👑" },
            { name: "E. Haaland", rating: 91, club: "Man City", league: "Premier League", pos: "ST", emoji: "🤖" },
            { name: "K. De Bruyne", rating: 90, club: "Man City", league: "Premier League", pos: "CM", emoji: "🎯" },
            { name: "B. Saka", rating: 89, club: "Arsenal", league: "Premier League", pos: "RW", emoji: "🌶️" },
            { name: "V. van Dijk", rating: 89, club: "Liverpool", league: "Premier League", pos: "LCB", emoji: "🧱" },
            { name: "Rodri", rating: 90, club: "Man City", league: "Premier League", pos: "CM", emoji: "🕹️" },
            { name: "Son Heung-min", rating: 87, club: "Tottenham", league: "Premier League", pos: "LW", emoji: "⚡" },
            // LA LIGA
            { name: "K. Mbappé", rating: 91, club: "Real Madrid", league: "La Liga", pos: "ST", emoji: "🐢" },
