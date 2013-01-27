function initialize( center  ) {
  directionsDisplay = new google.maps.DirectionsRenderer();
  var latlng = new google.maps.LatLng( center[0] , center[1] );
  var myOptions = { zoom: 15, center: latlng , mapTypeId: google.maps.MapTypeId.ROADMAP , mapTypeControl: false };
  map = new google.maps.Map(document.getElementById("map"), myOptions);
  directionsDisplay.setMap(map );
  var centerMarker = new google.maps.Marker( {position: latlng, map:map, title:'Me'  }); 
  return map;
}

function init_link( center ){
  $("#new a").attr("href", "/toilets/new/?latitude="+center.lat()+"&longitude="+center.lng() );
}

function clean_marker( ){
  for( var i = 0 ; i < markerArray.length ;i++){
    markerArray[i].setMap( null );
  }
}

function draw_marker( data ) {
  if( !$.isArray( data)){
    data= [data] ;
  }
  
  if( markerArray != undefined && markerArray.length > 0 ){
    clean_marker();  
  }
  markerArray = new Array( data.length );
  //var infowindowArray = new Array( data.length );
  //var infowindow = new google.maps.InfoWindow( {content:'loading...'} );

  var img = new google.maps.MarkerImage( '/image/has_both.png', new google.maps.Size( 128,128), new google.maps.Point(0,0), new google.maps.Point(0,32), new google.maps.Size(32,32) );
  for( var i =0 ; i < data.length ; i++){
    var latlng = new google.maps.LatLng( data[i]['latitude'], data[i]['longitude'] );
     markerArray[i] = new google.maps.Marker( {position: latlng, map: map, title: data[i]['name'] , clickable: true , icon:img} );
    markerArray[i].id  = data[i]['id'] ;
    google.maps.event.addListener( markerArray[i], 'click', function() {
     // infowindow.setContent( this.title );
     // infowindow.open( map, this );
     // map.setCenter(this.position );
      $.get( "/toilets/" + this.id+".json",  show_toilet );
      cal_route( this.getPosition() );
    });
  }
  var nearist_i = find_nearist( data );
  if( nearist_i != null ){ 
    $.get( "/toilets/"+ markerArray[nearist_i].id+".json", show_toilet );
    cal_route( markerArray[nearist_i].getPosition() );
  }
}
function cal_distance( a_lat, a_lng, b_lat, b_lng ){
  return Math.pow( (a_lat - b_lat ) , 2) + Math.pow( ( a_lng - b_lng ) ,2) ;
} 
function find_nearist( data ){
  if( data.length == 0 || data == undefined ){
   return null; 
 }

 var nearist_i = 0;
 var nearist_dist = cal_distance( data[nearist_i]['latitude'], data[nearist_i]['longitude'] , center.lat(), center.lng() );
  for( var i = 1 ; i < data.length ; i++){  
   var tmp_dist = cal_distance( data[i]['latitude'] , data[i]['longitude'] , center.lat(), center.lng() );
    if ( tmp_dist < nearist_dist ){
      nearist_i = i ;
      nearist_dist = tmp_dist ;
    } 
  }
  return nearist_i ;
}

function init_map( data ){
 var toilets = data['toilets']; 
  var center = data['center'];
 map = initialize( center ) ;
  
  draw_marker( toilets , map );
}

function show_toilet( data ){
  $("#toilet .name").html( data['toilet']['name'] );
  $("#toilet .address").html( data['toilet']['address'] );    
  $("#score .cleanness .value").html( (new Number(data['score']['cleanness'])).toFixed(1) ); 
  $("#score .safety .value").html( (new Number(data['score']['safety'])).toFixed(1) ); 
  $("#score .privacy .value").html( (new Number(data['score']['privacy'])).toFixed(1) ); 
  $("#score .comfort .value").html( (new Number(data['score']['comfort'])).toFixed(1) ); 
  $("#scoring a").attr('href', '/toilet_ratings/new/?toilet_id=' +data['toilet']['id']);  
  if( data['toilet']['has_male'] ){ $("#toilet .type .has_male " ).html( "<img src='/image/has_male.png' class='toilet-icon'>")};
  if( data['toilet']['has_female'] ){ $("#toilet .type .has_female " ).html( "<img src='/image/has_female.png' class='toilet-icon'>")};
  if( data['toilet']['has_both'] ){ $("#toilet .type .has_both " ).html( "<img src='/image/has_both.png' class='toilet-icon'>")};
  if( data['toilet']['has_free_access'] ){ $("#toilet .type .has_free_access " ).html( "<img src='/image/has_free_access.png' class='toilet-icon'>")};
  if( data['toilet']['has_family'] ){ $("#toilet .type .has_family " ).html( "<img src='/image/has_family.png' class='toilet-icon'>")};
}
function cal_route( dst ){
  var request = {
    origin: center, 
    destination: dst,
    travelMode: google.maps.DirectionsTravelMode.WALKING
  };
  directionsService.route( request , function( response, status){
    if (status == google.maps.DirectionsStatus.OK) {
      directionsDisplay.setDirections(response);
    }
  });
}

function get_address( google_latlng , call_back_function ){
   var geocoder = new google.maps.Geocoder();
    geocoder.geocode({'latLng': google_latlng}, function(results, status) {
      if (status == google.maps.GeocoderStatus.OK) {
        if (results[1]) {
          call_back_function( results[1].formatted_address);
        } else {
          alert("No results found");
        }
      } else {
        alert("Geocoder failed due to: " + status);
      }
    });
}
function set_address( address  ){
  $(".field #toilet_address").html( address );
}

function set_condition_search_button( ){
  $("#condition .option .checkbox").change( condition_search); 
}
function condition_search(){
  var condition={};
  $('#condition .option input:checkbox').each( function(i, e){ 
    condition[e.name.match(/\[(\S+)\]/)[1]] = e.checked;
  });
  condition['lat'] = center.lat();
  condition['lng'] = center.lng();
  $.get( "/toilets.json" , condition, function(data  ){draw_marker(data['toilets']); } ); 
}
