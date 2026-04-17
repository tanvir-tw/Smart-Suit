function validate() {

	 var urlStr=website;
			if (urlStr.indexOf(" ") != -1) {
				alert("Spaces are not allowed in a URL");
				return false;
			}

			if (urlStr == "" || urlStr == null) {
				return true;
			}

			urlStr = urlStr.toLowerCase();

			var specialChars = "\\(\\)><@,;:\\\\\\\"\\.\\[\\]";
			var validChars = "\[^\\s" + specialChars + "\]";
			var atom = validChars + '+';
			var urlPat = /^http:\/\/(\w*)\.([\-\+a-z0-9]*)\.(\w*)/;
			var matchArray = urlStr.match(urlPat);

			if (matchArray == null) {
				alert("The URL seems incorrect \ncheck it begins with http://\n and it has 2 .'s");
				return false;
			}

			var user = matchArray[2];
			var domain = matchArray[3];

			for (i = 0; i < user.length; i++) {
				if (user.charCodeAt(i) > 127) {
					alert("This domain contains invalid characters.");
					return false;
				}
			}

			for (i = 0; i < domain.length; i++) {
				if (domain.charCodeAt(i) > 127) {
					alert("This domain name contains invalid characters.");
					return false;
				}
			}

			var atomPat = new RegExp("^" + atom + "$");
			var domArr = domain.split(".");
			var len = domArr.length;

			for (i = 0; i < len; i++) {
				if (domArr[i].search(atomPat) == -1) {
					alert("The domain name does not seem to be valid.");
					return false;
				}
			}

			return true;
}


