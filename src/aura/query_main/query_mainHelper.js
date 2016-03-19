({
	getFields : function(str) {
        return str.match('SELECT(.+)FROM.+')[1].trim().split(',').map(function(s) {
            return s.trim();
        });
	}
})