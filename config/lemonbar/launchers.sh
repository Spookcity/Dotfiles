#!/bin/bash
while true; do
	echo -e "%{A:chromium:} \uead9 %{A}%{F#ff6600}|%{F-}%{A:chromium www.reddit.com:} \ueac6 %{A}%{F#ff6600}|%{F-}%{A:chromium www.github.com:} \ueab0 %{A}%{F#ff6600}|%{F-}%{A:chromium play.spotify.com:} \uea94 %{A}%{F#ff6600}|%{F-}%{A:chromium www.soundcloud.com/discover:} \ueac3 %{A}%{F#ff6600}|%{F-}%{A:chromium www.monstercat.com:} \ue9ef %{A}%{F#ff6600}|%{F-}%{A:chromium www.google.com:} \uea88 %{A}%{F#ff6600}|%{F-}%{A:chromium www.paypal.com:} \uead8 %{A}%{F#ff6600}|%{F-}%{A:chromium www.stackoverflow.com:} \uead0 %{A}%{F#ff6600}|%{F-}%{A:chromium www.youtube.com/feed/subscriptions:} \uea9d %{A}%{F#ff6600}|%{F-}%{A:chromium mail.google.com/mail/u/0/#inbox:} \uea83 %{A}%{F#ff6600}|%{F-}%{A:chromium drive.google.com/drive/u/2/my-drive:} \uea8f %{A}%{F#ff6600}|%{F-}%{A:chromium www.asciitable.com:} \ueae5 %{A}%{F#ff6600}|%{F-}%{A:chromium beta.speedtest.net:} \ue9a6%{A}"
	sleep 60;
done | lemonbar -p -d -B#c0262626 -F#A0A0A0 -a 14 -g 492x20+2705+10 -r 3 -R#FF993d00 -f "Source Code Pro-9" -f "Icomoon-11" | bash