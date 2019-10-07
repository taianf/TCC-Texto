function getCookie(Name) {
  var search = Name + "="
  if (document.cookie.length > 0) {
    offset = document.cookie.indexOf(search)
    if (offset != -1) {        // if cookie exists
      offset += search.length
      // set index of beginning of value
      end = document.cookie.indexOf(";", offset)   
      // set index of end of cookie value
      if (end == -1)        
         end = document.cookie.length
      return unescape(document.cookie.substring(offset, end))
    }
  }
}

function hasCookie(Name) {
  if (getCookie(Name) == undefined) {
    alert("Cookies need to be enabled in your browser!");
  }
}
