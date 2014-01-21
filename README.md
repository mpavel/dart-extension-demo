Demo Dartium Extension
======================

I took the code from the Chrome Demo Extension (http://developer.chrome.com/extensions/getstarted.html)
and replaced pretty much everything with dart.

I also kept the dart dummy code.

In Dartium I went to Settings > Extensions > Developer mode > Load unpacked extension

(choose the 'web' folder) and load the code to see if it works. It does ;-)


Purpose of Experiment
=====================

To see if you can build a Chrome extension in Dart,
test it in Dartium, and then use dart2js to generate
the javascript required for a 'normal' Chrome extension.