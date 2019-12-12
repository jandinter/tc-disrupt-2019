function ajax_get(url,data,callback){

console.log(data)

	var xmlhttp = new XMLHttpRequest();

	 xmlhttp.onreadystatechange = function() {

	 	 if (xmlhttp.readyState == 4 && xmlhttp.status == 200){
	 	 	console.log("Hello Jan");

	 	 	try{
	 	 		var data = JSON.parse(xmlhttp.responseText);
	 	 	}
	 	 	catch(err){
	 	 		console.log("An error occured" + xmlhttp.responseText);
	 	 		return;
	 	 	}

	 	 	callback(data);

	 	 }


	 }

	 xmlhttp.open("GET",url,true);
	 xmlhttp.send();
}




ajax_get('/updates',{longitude: 40, latitude: 40, radius: 50}, function(data) {
	console.log(data)
    document.getElementById("title").innerHTML = data["title"];
 
    var html = "<h2>" + data["title"] + "</h2>";
    html += "<h3>" + data["id"] + "</h3>";
    html += "<ul>";
       for (var i=0; i < 3; i++) {
           html += '<li><a href="' + data["body"] + '">'  + "</a></li>";
       }
    html += "</ul>";
    document.getElementById("text").innerHTML = html;
});

