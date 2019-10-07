var expires = new Date()
var today   = new Date()

function setCookie(name, value, hours) {
  var expire = new Date();
  expire.setTime (expire.getTime() + (1000 * 60 * 60 * hours));
  document.cookie = name + "=" + escape(value)
  + ((expire == null) ? "" : ("; expires=" + expire.toGMTString()))
}
function unsetCookie(name) {
  var exp = new Date();
  exp.setTime(today.getTime() - 10);
  document.cookie = name + "=" + "; expires=" + exp.toGMTString()
}
expires.setTime(today.getTime() + 86400*365)
