#!/usr/bin/env python

# URXVT Colors -> Terminator config file format by Stolid. Enjoy. I can't promise it will work every time.

import subprocess, os

urxvt_cfg = os.path.expanduser('~')+'/.Xresources'

colors = []
def getColorSetting(search):
	p1 = subprocess.Popen(['grep', search, urxvt_cfg], stdout=subprocess.PIPE)
	output = subprocess.Popen(['head', '-n1'], stdin=p1.stdout, stdout=subprocess.PIPE)
	r = ' '.join(output.communicate()[0].split())
	r = '#' + r.split('#')[-1]
	return r
for i in range(0,15+1):
	p1 = subprocess.Popen(['grep', 'color'+str(i), urxvt_cfg], stdout=subprocess.PIPE)
	p2 = subprocess.Popen(['head', '-n1'], stdin=p1.stdout, stdout=subprocess.PIPE)
	output = p2.communicate()[0]
	color = ' '.join(output.split())
	color = color.split('#')[-1]
	colors.append('#'+color)
#print colors
print '\nColors parsed out of ~/.Xresources and terminator-config-file-ized (replace the relevant lines in your ~/.config/terminator/config):\n'
print 'palette = "' + (':'.join(colors)) + '"'
print 'background_color = "' + getColorSetting('*background:') + '"'
print 'foreground_color = "' + getColorSetting('*foreground:') + '"'
print 'cursor_color = "' + getColorSetting('cursorColor:') + '"'
