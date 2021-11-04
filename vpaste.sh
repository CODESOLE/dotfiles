uri="http://vpaste.net/"
if [ -f "$1" ]; then
	out=`curl -s -F "text=<$1" "$uri?$2"`
else
	out=`curl -s -F 'text=<-' "$uri?$1"`
fi
echo "$out"
if [ -x "`which xclip 2>/dev/null`" -a "$DISPLAY" ]; then
	echo -n "$out" | xclip -i -selection primary
	echo -n "$out" | xclip -i -selection clipboard
fi
