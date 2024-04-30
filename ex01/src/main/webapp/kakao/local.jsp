<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div>
	<h1>지역검색</h1>
</div>
<div class="row mb-4">
    <form class="col-6" name="frm" action="">
        <div class="input-group">
            <input class="form-control" name="query" type="text" value="가산동" placeholder="장소명">
            <button class="btn btn-dark">검색</button>
        </div>
    </form>
</div>
<div id="div_local"></div>
<div class="text-center my-3">
    <button class="btn btn-dark" id="prev">이전</button>
    <span class="mx-3" id="page">1</span>
    <button class="btn btn-dark" id="next">다음</button>
</div>
<div id="map"></div>
<script id="temp_local" type="X-handlebars-template">
    <table class="table table-hover">
        <tr class="table-dark">
            <th>장소명</th>
            <th>전화번호</th>
            <th>주소</th>
            <th>위치</th>
        </tr>
        {{#each documents}}
            <tr>
                <td>{{place_name}}</td>
                <td>{{phone}}</td>
                <td>{{address_name}}</td>
                <td><button x="{{x}}" y="{{y}}" place_url="{{place_url}}" place_name="{{place_name}}" address_name="{{address_name}}" class="btn btn-dark btn-sm location">위치</button></td>
            </tr>
        {{/each}}
    </table>
</script>
<script>
    let query = $(frm.query).val();
    let page = 1;
    getData();
    // 위치 버튼을 클릭한 경우
    $('#div_local').on("click", ".location", function(){
        const x = $(this).attr("x");
        const y = $(this).attr("y");
        const place_url = $(this).attr("place_url");
        const place_name = $(this).attr("place_name");
        const address_name = $(this).attr("address_name");
        // alert(x + ":" + y);
        var container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
        var options = { //지도를 생성할 때 필요한 기본 옵션
            center: new kakao.maps.LatLng(y, x), //지도의 중심좌표.
            level: 3 //지도의 레벨(확대, 축소 정도)
        };

        var map = new kakao.maps.Map(container, options); //지도 생성 및 객체 리턴
        
        // 지도에 지형정보를 표시하도록 지도타입을 추가합니다
        map.addOverlayMapTypeId(kakao.maps.MapTypeId.TERRAIN);

        // 마커가 표시될 위치입니다 
        var markerPosition  = new kakao.maps.LatLng(y, x); 

        // 마커를 생성합니다
        var marker = new kakao.maps.Marker({
            position: markerPosition
        });

        // 마커가 지도 위에 표시되도록 설정합니다
        marker.setMap(map);

        var iwContent = '<div style="width:200px;padding:5px;">'+ place_name + '<br><a href="'+place_url+'" style="color:blue" target="_blank">'+ address_name +'</a></div>', // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
            iwPosition = new kakao.maps.LatLng(y, x); //인포윈도우 표시 위치입니다

        // 인포윈도우를 생성합니다
        var infowindow = new kakao.maps.InfoWindow({
            position : iwPosition, 
            content : iwContent 
        });
        
        // 마커에 마우스오버 이벤트를 등록합니다
        kakao.maps.event.addListener(marker, 'mouseover', function() {
        // 마커에 마우스오버 이벤트가 발생하면 인포윈도우를 마커위에 표시합니다
            infowindow.open(map, marker);
        });

        // 마커에 마우스아웃 이벤트를 등록합니다
        kakao.maps.event.addListener(marker, 'mouseout', function() {
            // 마커에 마우스아웃 이벤트가 발생하면 인포윈도우를 제거합니다
            infowindow.close();
        });
        // 마커에 클릭이벤트를 등록합니다
        kakao.maps.event.addListener(marker, 'click', function() {
            // 마커 위에 인포윈도우를 표시합니다
            infowindow.open(map, marker);  
        });
    });

    $("#next").on("click", function(){
        page++;
        getData();
    });

    $("#prev").on("click", function(){
        page--;
        getData();
    });

    $(frm).on("submit", function(e){
        e.preventDefault();
        query = $(frm.query).val();
        if(query==""){
            alert("장소명을 입력하세요!");
        }else {
            getData();
            page = 1;
        }
    });

    function getData() {
        $.ajax({
            type:"get",
            url:"https://dapi.kakao.com/v2/local/search/keyword.json",
            dataType:"json",
            data:{query:query, size:5, page:page},
            headers:{"Authorization":"KakaoAK 35c0aa5e699cabcb9592ef08fb07d91a"},
            success:function(data){
                console.log(data);
                // alert("성공!");
                const temp = Handlebars.compile($('#temp_local').html());
                $('#div_local').html(temp(data));
                const last = Math.ceil(data.meta.pageable_count/5);
                $('#page').html(page + '/' + last);
                if(page==1){
                    $('#prev').attr('hidden', true);
                }else {
                    $('#prev').attr('hidden', false);
                }
                if(data.meta.is_end){
                    $('#next').attr('hidden', true);
                }else {
                    $('#next').attr('hidden', false);
                }
            }
        })
    }
</script>
