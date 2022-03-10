<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageName" value="댕냥댕냥" />
<%@ include file="../common/head.jspf"%>
<div class="w-9/12 mt-5 overflow-x-auto">
<p class="text-lg map-font font-bold mb-1">* 🏥집 주변 3km 이내 동물병원🏥</p>
  <div id="map" class="mx-auto w-full h-72"></div>
 </div>
  
<script>
var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = { 
        center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
        level: 3 // 지도의 확대 레벨 
    }; 

var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다

var imageSrc = 'https://cdn-icons-png.flaticon.com/512/3014/3014764.png', // 마커이미지의 주소입니다    
imageSize = new kakao.maps.Size(60, 65), // 마커이미지의 크기입니다
imageOption = {offset: new kakao.maps.Point(27, 69)}; // 마커이미지의 옵션입니다. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정합니다.

// 장소 검색 객체를 생성합니다
var ps = new kakao.maps.services.Places(); 

// HTML5의 geolocation으로 사용할 수 있는지 확인합니다 
if (navigator.geolocation) {
    
    // GeoLocation을 이용해서 접속 위치를 얻어옵니다
    navigator.geolocation.getCurrentPosition(function(position) {
        
        var lat = position.coords.latitude, // 위도
            lon = position.coords.longitude; // 경도
        
        var locPosition = new kakao.maps.LatLng(lat, lon), // 마커가 표시될 위치를 geolocation으로 얻어온 좌표로 생성합니다
            message = '<div style="padding:5px;">여기에 계신가요?!</div>'; // 인포윈도우에 표시될 내용입니다
                    
        // 마커와 인포윈도우를 표시합니다
        displayMarker(locPosition, message);
            
        var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption),
      	markerPosition = locPosition // 마커가 표시될 위치입니다
     // 마커를 생성합니다
      	var marker = new kakao.maps.Marker({
      	    position: markerPosition, 
      	    image: markerImage // 마커이미지 설정 
      	});
    	
    //마커가 지도 위에 표시되도록 설정합니다
    	marker.setMap(map);  
        
        var iwContent = message, // 인포윈도우에 표시할 내용
            iwRemoveable = true;
        
        // 지도 중심좌표를 접속위치로 변경합니다
        map.setCenter(locPosition);      
            
      //키워드로 장소를 검색합니다
        ps.keywordSearch('동물병원', placesSearchCB, {
        	radius: 3000,
            location: locPosition
        }); 
      });
    
} else { // HTML5의 GeoLocation을 사용할 수 없을때 마커 표시 위치와 인포윈도우 내용을 설정합니다
    
    var locPosition = new kakao.maps.LatLng(33.450701, 126.570667),    
        message = 'geolocation을 사용할수 없어요..'
        
    displayMarker(locPosition, message);
}



// 지도에 마커와 인포윈도우를 표시하는 함수입니다
function displayMarker(locPosition, message) {
  var iwContent = message, // 인포윈도우에 표시할 내용
  iwRemoveable = true;

// 인포윈도우를 생성합니다
var infowindow = new kakao.maps.InfoWindow({
  content : iwContent,
  removable : iwRemoveable
});

// 인포윈도우를 마커위에 표시합니다 
infowindow.open(map, marker);
	
}    //키워드부분
    // 키워드 검색 완료 시 호출되는 콜백함수 입니다
function placesSearchCB (data, status, pagination) {
    if (status === kakao.maps.services.Status.OK) {

        // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
        // LatLngBounds 객체에 좌표를 추가합니다
        var bounds = new kakao.maps.LatLngBounds();

        for (var i=0; i<data.length; i++) {
            displayMarker(data[i]);    
            bounds.extend(new kakao.maps.LatLng(data[i].y, data[i].x));
        }       

        // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
        map.setBounds(bounds);
    } 
}

// 지도에 마커를 표시하는 함수입니다
function displayMarker(place) {
    
    // 마커를 생성하고 지도에 표시합니다
    var marker = new kakao.maps.Marker({
        map: map,
        position: new kakao.maps.LatLng(place.y, place.x) 
    });

    // 마커에 클릭이벤트를 등록합니다
    kakao.maps.event.addListener(marker, 'click', function() {
        // 마커를 클릭하면 장소명이 인포윈도우에 표출됩니다
        infowindow.setContent('<div style="padding:5px;font-size:12px;">' + place.place_name + '</div>');
        infowindow.open(map, marker);
    });
}
</script>

<%@ include file="../common/foot.jspf"%>