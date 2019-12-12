
//Script to change or fire a new URL every map change 

		while(true){
					if(cruncher_map.dragPan.isActive()){
				var long = cruncher_map.getCenter().toArray()[0];
				var lat = cruncher_map.getCenter().toArray()[1];
				var old_url = window.location.href.split('?')[0]
				//Replace this line with the Ajax request
				window.history.pushState({}, document.title, "/" + `${old_url}` + "/" + `${long}` + "/" +`${lat}`);
				console.log(`${old_url}` + "?" + "long=" + `${long}` + "&" + "lat=" +`${lat}`)}
			}



//AJAX GET Func
function ajax_get(url, data, callback) {
    var xmlhttp = new XMLHttpRequest();
    xmlhttp.onreadystatechange = function() {
        if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
            console.log('responseText:' + xmlhttp.responseText);
            try {
                var data = JSON.parse(xmlhttp.responseText);
            } catch(err) {
                console.log(err.message + " in " + xmlhttp.responseText);
                return;
            }
            callback(data);
        }
    };
 
    xmlhttp.open("GET", url, true);
    xmlhttp.send();
}

ajax_get('Users/ahmed/Desktop/AjaxEx/tweets.json',{/*parameters*/} function(data){
    //change the HTML elements 
});