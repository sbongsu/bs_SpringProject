<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageName" value="๋๋ฅ๋๋ฅ" />
<%@ include file="../common/head.jspf"%>
<%--KakaoMap --%>
<div class="w-9/12 mt-5 overflow-x-auto">
  <p class="text-lg map-font font-bold mb-1">* ๐ฅ์ง ์ฃผ๋ณ 3km ์ด๋ด ๋๋ฌผ๋ณ์๐ฅ</p>
  <div id="map" class="mx-auto w-full h-72"></div>
</div>

<%--KakaoMap ์คํฌ๋ฆฝํธ ์์--%>
<script>
	var mapContainer = document.getElementById('map'), // ์ง๋๋ฅผ ํ์ํ  div 
	mapOption = {
		center : new kakao.maps.LatLng(33.450701, 126.570667), // ์ง๋์ ์ค์ฌ์ขํ
		level : 3
	// ์ง๋์ ํ๋ ๋ ๋ฒจ 
	};

	var map = new kakao.maps.Map(mapContainer, mapOption); // ์ง๋๋ฅผ ์์ฑํฉ๋๋ค

	var imageSrc = 'https://cdn-icons-png.flaticon.com/512/3014/3014764.png', // ๋ง์ปค์ด๋ฏธ์ง์ ์ฃผ์์๋๋ค    
	imageSize = new kakao.maps.Size(60, 65), // ๋ง์ปค์ด๋ฏธ์ง์ ํฌ๊ธฐ์๋๋ค
	imageOption = {
		offset : new kakao.maps.Point(27, 69)
	}; // ๋ง์ปค์ด๋ฏธ์ง์ ์ต์์๋๋ค. ๋ง์ปค์ ์ขํ์ ์ผ์น์ํฌ ์ด๋ฏธ์ง ์์์์ ์ขํ๋ฅผ ์ค์ ํฉ๋๋ค.

	// ์ฅ์ ๊ฒ์ ๊ฐ์ฒด๋ฅผ ์์ฑํฉ๋๋ค
	var ps = new kakao.maps.services.Places();

	// HTML5์ geolocation์ผ๋ก ์ฌ์ฉํ  ์ ์๋์ง ํ์ธํฉ๋๋ค 
	if (navigator.geolocation) {

		// GeoLocation์ ์ด์ฉํด์ ์ ์ ์์น๋ฅผ ์ป์ด์ต๋๋ค
		navigator.geolocation.getCurrentPosition(function(position) {

			var lat = position.coords.latitude, // ์๋
			lon = position.coords.longitude; // ๊ฒฝ๋

			var locPosition = new kakao.maps.LatLng(lat, lon), // ๋ง์ปค๊ฐ ํ์๋  ์์น๋ฅผ geolocation์ผ๋ก ์ป์ด์จ ์ขํ๋ก ์์ฑํฉ๋๋ค
			message = '<div style="padding:5px;">์ฌ๊ธฐ์ ๊ณ์ ๊ฐ์?!</div>'; // ์ธํฌ์๋์ฐ์ ํ์๋  ๋ด์ฉ์๋๋ค

			// ๋ง์ปค์ ์ธํฌ์๋์ฐ๋ฅผ ํ์ํฉ๋๋ค
			displayMarker(locPosition, message);

			var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize,
					imageOption), markerPosition = locPosition // ๋ง์ปค๊ฐ ํ์๋  ์์น์๋๋ค
			// ๋ง์ปค๋ฅผ ์์ฑํฉ๋๋ค
			var marker = new kakao.maps.Marker({
				position : markerPosition,
				image : markerImage
			// ๋ง์ปค์ด๋ฏธ์ง ์ค์  
			});

			//๋ง์ปค๊ฐ ์ง๋ ์์ ํ์๋๋๋ก ์ค์ ํฉ๋๋ค
			marker.setMap(map);

			var iwContent = message, // ์ธํฌ์๋์ฐ์ ํ์ํ  ๋ด์ฉ
			iwRemoveable = true;

			// ์ง๋ ์ค์ฌ์ขํ๋ฅผ ์ ์์์น๋ก ๋ณ๊ฒฝํฉ๋๋ค
			map.setCenter(locPosition);

			//ํค์๋๋ก ์ฅ์๋ฅผ ๊ฒ์ํฉ๋๋ค
			ps.keywordSearch('๋๋ฌผ๋ณ์', placesSearchCB, {
				radius : 3000,
				location : locPosition
			});
		});

	} else { // HTML5์ GeoLocation์ ์ฌ์ฉํ  ์ ์์๋ ๋ง์ปค ํ์ ์์น์ ์ธํฌ์๋์ฐ ๋ด์ฉ์ ์ค์ ํฉ๋๋ค

		var locPosition = new kakao.maps.LatLng(33.450701, 126.570667), message = 'geolocation์ ์ฌ์ฉํ ์ ์์ด์..'

		displayMarker(locPosition, message);
	}

	// ์ง๋์ ๋ง์ปค์ ์ธํฌ์๋์ฐ๋ฅผ ํ์ํ๋ ํจ์์๋๋ค
	function displayMarker(locPosition, message) {
		var iwContent = message, // ์ธํฌ์๋์ฐ์ ํ์ํ  ๋ด์ฉ
		iwRemoveable = true;

		// ์ธํฌ์๋์ฐ๋ฅผ ์์ฑํฉ๋๋ค
		var infowindow = new kakao.maps.InfoWindow({
			content : iwContent,
			removable : iwRemoveable
		});

		// ์ธํฌ์๋์ฐ๋ฅผ ๋ง์ปค์์ ํ์ํฉ๋๋ค 
		infowindow.open(map, marker);

	} //ํค์๋๋ถ๋ถ
	// ํค์๋ ๊ฒ์ ์๋ฃ ์ ํธ์ถ๋๋ ์ฝ๋ฐฑํจ์ ์๋๋ค
	function placesSearchCB(data, status, pagination) {
		if (status === kakao.maps.services.Status.OK) {

			// ๊ฒ์๋ ์ฅ์ ์์น๋ฅผ ๊ธฐ์ค์ผ๋ก ์ง๋ ๋ฒ์๋ฅผ ์ฌ์ค์ ํ๊ธฐ์ํด
			// LatLngBounds ๊ฐ์ฒด์ ์ขํ๋ฅผ ์ถ๊ฐํฉ๋๋ค
			var bounds = new kakao.maps.LatLngBounds();

			for (var i = 0; i < data.length; i++) {
				displayMarker(data[i]);
				bounds.extend(new kakao.maps.LatLng(data[i].y, data[i].x));
			}

			// ๊ฒ์๋ ์ฅ์ ์์น๋ฅผ ๊ธฐ์ค์ผ๋ก ์ง๋ ๋ฒ์๋ฅผ ์ฌ์ค์ ํฉ๋๋ค
			map.setBounds(bounds);
		}
	}

	// ์ง๋์ ๋ง์ปค๋ฅผ ํ์ํ๋ ํจ์์๋๋ค
	function displayMarker(place) {

		// ๋ง์ปค๋ฅผ ์์ฑํ๊ณ  ์ง๋์ ํ์ํฉ๋๋ค
		var marker = new kakao.maps.Marker({
			map : map,
			position : new kakao.maps.LatLng(place.y, place.x)
		});

		// ๋ง์ปค์ ํด๋ฆญ์ด๋ฒคํธ๋ฅผ ๋ฑ๋กํฉ๋๋ค
		kakao.maps.event.addListener(marker, 'click', function() {
			// ๋ง์ปค๋ฅผ ํด๋ฆญํ๋ฉด ์ฅ์๋ช์ด ์ธํฌ์๋์ฐ์ ํ์ถ๋ฉ๋๋ค
			infowindow.setContent('<div style="padding:5px;font-size:12px;">'
					+ place.place_name + '</div>');
			infowindow.open(map, marker);
		});
	}
</script>
<%--KakaoMap ์คํฌ๋ฆฝํธ ๋--%>

<%--๋งค๊ฑฐ์ง ์์--%>
<div class="overflow-x-auto mt-5 w-3/4">
<p class="font-bold">๐ฐ Magazine ๐ฐ</p>
  <div class="flex justify-between">
    <div class="card w-52 bg-base-100 shadow-xl">
      <figure>
        <a href="https://m.post.naver.com/viewer/postView.naver?volumeNo=33408857&memberNo=48228308"><img src="https://mocoblob.blob.core.windows.net/assets/magazine/img/14_1646729162033_0.png" class="rounded-xl"
        /></a>
      </figure>
      <div class="card-body items-center text-center mt-2">
        <div class="card-actions">
          <p>๋ฐฅ๋งํผ ์ค์ํ <br>๐'๊ฐ ๋ฐฅ๊ทธ๋ฆ'๐</p>
        </div>
      </div>
    </div>

    <div class="card w-52 bg-base-100 shadow-xl">
      <figure>
        <a href="https://blog.naver.com/blue_bells82/222668509336?isInf=true"><img src="https://s3.ap-northeast-2.amazonaws.com/elasticbeanstalk-ap-northeast-2-176213403491/media/magazine_img/magazine_302/104_%E1%84%8A%E1%85%A5%E1%86%B7%E1%84%82%E1%85%A6%E1%84%8B%E1%85%B5%E1%86%AF.jpg" class="rounded-xl"
        /></a>
      </figure>
      <div class="card-body items-center text-center mt-2">
        <div class="card-actions">
          <p>๊ณ ์์ด ํ๊ท ์๋ช<br>๊ณ ์์ด ์ฌ๋๋์ด<br>๋น๊ต ๐</p>
        </div>
      </div>
    </div>

    <div class="card w-52 bg-base-100 shadow-xl">
      <figure>
        <a href="https://blog.naver.com/bichon-haru/222671760311?isInf=true"><img src="https://coop.ewha.ac.kr/ezstock/1534729386.jpg" class="rounded-xl"
        /></a>
      </figure>
      <div class="card-body items-center text-center mt-2">
        <div class="card-actions">
          <p>๊ฐ์์ง ๊ตฌํ  ์์ธ<br>๊ตฌํ ์ ๋์ฒ๋ฐฉ๋ฒ๐ฅ</p>
        </div>
      </div>
    </div>

    <div class="card w-52 bg-base-100 shadow-xl">
      <figure>
        <a href="https://blog.naver.com/bichon-haru/222671760311?isInf=true"><img src="https://en.pimg.jp/074/445/953/1/74445953.jpg" class="rounded-xl"
        /></a>
      </figure>
      <div class="card-body items-center text-center">
        <div class="card-actions">
          <p>"๊ฐ์์ง๊ฐ ์ํ์"<br>๋๋ฌผ๋ณ์ ์ ๊ณ ๋ฅด๋๋ฒ!๐ฅ</p>
        </div>
      </div>
    </div>

    <div class="card w-52 bg-base-100 shadow-xl">
      <figure>
        <a href="https://blog.naver.com/theclassamc/222350465167?isInf=true"><img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR0lm_p2a6Pp3u4urBysshmTY4lGcCPfwtgQg&usqp=CAU" class="rounded-xl"
        /></a>
      </figure>
      <div class="card-body items-center text-center">
        <div class="card-actions">
          <p>๊ณ ์์ด ๋ณด์์<br>๊ณ ๊ธฐ ๊ด์ฐฎ์๊น? ๐</p>
        </div>
      </div>
    </div>
  </div>
</div>
<%--๋งค๊ฑฐ์ง ๋--%>
<%@ include file="../common/foot.jspf"%>