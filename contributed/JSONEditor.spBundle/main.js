window.debounce = function() {
  var wait, func, timeout;
  if (arguments.length == 2) {
    wait = arguments[0];
    func = arguments[1];
  } else {
    wait = 300;
    func = arguments[0];
  }
  return function() {
    var self = this, args = arguments;
    clearTimeout(timeout);
    timeout = setTimeout(function() {
      timeout = null;
      func.apply(self, args);
    }, wait);
  }
}
window.resizeTo(window.screen.width - 20, window.screen.height - 100);
window.moveTo(10, 0);
system.makeHTMLOutputWindowKeyWindow();
window.onload = function() {
  window.editor = new JSONEditor(document.getElementById('editor'), {
    name: 'document',
    change: debounce(500, function() {
      var data = JSON.stringify(editor.get()).replace(/\"/g, "\\\"");
      system.run("echo \"update document set data = '" + data + "' where id = '" + editor.get().id + "';\" > " + spQueryFile);
      system.run("open sequelpro://" + spProcessId + "@passToDoc/ExecuteQuery/");
      system.run("open sequelpro://" + spProcessId + "@passToDoc/ReloadContentTable");
    })
  });
  window.editor.set(record);
  window.editor.focus();
}