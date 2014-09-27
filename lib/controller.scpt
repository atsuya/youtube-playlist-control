on control(direction)
  set code to "
    var direction = " & direction & ";
    var event = new MouseEvent('click', { 'view': window, 'bubbles': true, 'cancelable': true });

    var classNames = {
      'next': ['yt-uix-button-icon-watch-appbar-play-next', 'yt-uix-button-icon-watch-queue-next'],
      'previous': ['yt-uix-button-icon-watch-appbar-play-prev', 'yt-uix-button-icon-watch-queue-prev'],
      'play': ['ytp-button-play', 'yt-uix-button-icon-watch-appbar-play-play', 'yt-uix-button-icon-watch-queue-play'],
      'pause': ['ytp-button-pause', 'yt-uix-button-icon-watch-appbar-play-pause', 'yt-uix-button-icon-watch-queue-pause']
    };
    var className = classNames[direction];
    var theClassName = null;

    className.forEach(function each(klass) {
      if (document.getElementsByClassName(klass)[0] !== undefined) {
        console.log('found: ' + klass);
        if (!theClassName) {
          theClassName = klass;
        }
      }
    });

    if (theClassName) {
      console.log('using: ' + theClassName);
      var nextButton = document.getElementsByClassName(theClassName)[0]
      nextButton.dispatchEvent(event);
    }
  "

  set targetTab to activeTab() of me
  executeJavaScript(targetTab, code) of me
end control

on activeTab()
  set targetTab to null

  tell application "Google Chrome"
    repeat with theWindow in every window
      repeat with theTab in every tab of theWindow
        if theTab's title ends with "- YouTube" then
          set targetTab to theTab
          exit repeat
        end if
      end repeat
    end repeat
  end tell

  return targetTab
end activeTab

on executeJavaScript(activeTab, code)
  set result to null

  tell application "Google Chrome"
    set result to execute activeTab javascript code
  end tell

  return result
end executeJavaScript
