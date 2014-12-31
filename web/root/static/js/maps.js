var $maps = function () {
    var map;
    var addr;
    var geocoder;

    function initialize() {
		var mapOptions = {
			center: new google.maps.LatLng(-23.549035, -46.634438),
			zoom: 16,
		};
		geocoder = new google.maps.Geocoder();

   	    map = new google.maps.Map(document.getElementById("map"),mapOptions);
    }

	function loadproject(){

		$.getJSON('/home/project_map',function(data,status){
			var json = data;
			$.each(json, function(i, pj){
				marker = "";
				var myLatlng = new google.maps.LatLng(pj.latitude,pj.longitude);	
				marker = new google.maps.Marker({
    	            position: myLatlng,
	                map: map,
					title: pj.name,
					url : "/home/project/"+pj.id
        	    });

				google.maps.event.addListener(marker, 'click', function() {
        			window.location.href = marker.url;
    			});
			});
		});
	
	}

	function codeAddress(data){
		geocoder.geocode({ 'address': data + ', Brasil', 'region': 'BR' }, function (results, status) {
                 return results;
		});
	}
	
	function setlocal(location){
		map.setCenter(location);
	    map.setZoom(16);
	}

	return {
		initialize	: initialize,
		loadproject : loadproject,
		codeAddress : codeAddress,
		setlocal      : setlocal
	};
}();

$(document).ready(function () {
	$maps.initialize();
	if ($("#pagetype").val() == 'home'){	
		$maps.loadproject();
	}		

	$("#type").change(function(){
		var id = $( "#type option:selected" ).val();
     	$.get("/home/project/type",{type_id: id}).done( function(data){
			document.getElementById("result").innerHTML=data
       	});
	});

	$("#homeregion").change(function(){
		var id = $( "#homeregion option:selected" ).val();
     	$.get("/home/project/region",{region_id: id}).done( function(data){
			document.getElementById("result").innerHTML=data
       	});
	});


	$("#txtaddress").autocomplete({
	source: function (request, response) {
	
	   geocoder = new google.maps.Geocoder();
       geocoder.geocode({ 'address': request.term + ', Brasil', 'region': 'BR' }, function (results, status) {
          response($.map(results, function (item) {
                return {
                    label: item.formatted_address,
                    value: item.formatted_address,
                    latitude: item.geometry.location.lat(),
                    longitude: item.geometry.location.lng()
                }
          }));
       })
    },
    select: function (event, ui) {
        var location = new google.maps.LatLng(ui.item.latitude, ui.item.longitude);
		
		if ($("#pagetype").val() == 'home'){		
 			$.get("/home/project/region_by_cep",{latitude: ui.item.latitude, longitude: ui.item.longitude}).done( function(data){
				document.getElementById("result").innerHTML=data
        	});
        	$maps.setlocal(location);
		}

		if ($("#pagetype").val() == 'region'){			
 			$.getJSON("/home/region/id",{latitude: ui.item.latitude, longitude: ui.item.longitude},function(data,status){
					window.location.href="/home/region/"+data.id;
			});
		}
			
    }
    });


});
