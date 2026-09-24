tell application "Safari"
    if (count of windows) > 0 then
        tell front document
            do JavaScript "
            (function() {
                const videos = document.querySelectorAll('video');
                if (videos.length === 0) return;

                const speeds = [0.5, 0.75, 1.0, 1.25, 1.5, 1.75, 2.0, 2.5];
                const currentRate = Math.round(videos[0].playbackRate * 100) / 100;

                let nextSpeed = speeds.find(s => s > currentRate);
                if (nextSpeed === undefined) nextSpeed = speeds[speeds.length - 1];

                videos.forEach(v => { v.playbackRate = nextSpeed; });

                const oldBadge = document.getElementById('speed-hud-badge');
                if (oldBadge) oldBadge.remove();

                const badge = document.createElement('div');
                badge.id = 'speed-hud-badge';
                badge.textContent = '⚡ ' + nextSpeed.toFixed(2).replace(/\\.00$/, '.0').replace(/0$/, '') + 'x';

                badge.style.position = 'fixed';
                badge.style.top = '50%';
                badge.style.left = '50%';
                badge.style.transform = 'translate(-50%, -50%)';
                badge.style.zIndex = '2147483647';
                badge.style.backgroundColor = 'rgba(25, 25, 28, 0.65)';
                badge.style.backdropFilter = 'blur(20px)';
                badge.style.webkitBackdropFilter = 'blur(20px)';
                badge.style.color = '#FFFFFF';
                badge.style.padding = '18px 36px';
                badge.style.borderRadius = '18px';
                badge.style.fontSize = '32px';
                badge.style.fontWeight = '600';
                badge.style.fontFamily = '-apple-system, BlinkMacSystemFont, \"SF Pro Display\", sans-serif';
                badge.style.border = '1px solid rgba(255, 255, 255, 0.22)';
                badge.style.boxShadow = '0 20px 40px rgba(0, 0, 0, 0.45)';
                badge.style.pointerEvents = 'none';
                badge.style.transition = 'opacity 0.25s ease';

                document.body.appendChild(badge);

                setTimeout(() => {
                    badge.style.opacity = '0';
                    setTimeout(() => badge.remove(), 250);
                }, 800);
            })();
            "
        end tell
    end if
end tell
