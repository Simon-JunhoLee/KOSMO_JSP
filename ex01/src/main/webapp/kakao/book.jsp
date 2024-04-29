<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div>
	<h1>도서검색</h1>
	<div class="row mb-2">
	    <div class="col-6 col-md-4">
	        <form class="input-group" name="frm" action="">
	            <input class="form-control" type="text" name="query" value="java" placeholder="도서명">
	            <button class="btn btn-dark">검색</button>
	        </form>
	    </div>
	</div>
	<div id="div_book" class="row"></div>
	<div class="text-center my-3">
	    <button class="btn btn-dark" id="prev">이전</button>
	    <span class="mx-3" id="page">1</span>
	    <button class="btn btn-dark" id="next">다음</button>
	</div>
	<script id="temp_book" type="x-handlebars-template">
		{{#each documents}}
			<div class="col-6 col-md-4 col-lg-2">
				<div class="card mx-1 my-3">
					<div class="card-body">
						<img src="{{check thumbnail}}" width="100%">
					</div>
					<div class="card-footer">
						<div class="ellipsis">{{title}}</div>
					</div>
				</div>
			</div>
		{{/each}}
	</script>
</div>
<script>
	Handlebars.registerHelper("check", function(thumbnail){
	    if(thumbnail) {
	        return thumbnail;
	    }else {
	        return "http://via.placeholder.com/124x180";
	    }
	});

	let query = $('[name="query"]').val();
	let page = 1;
	let size = 6;
	getData();
	// 다음 버튼을 클릭한 경우 (페이징 처리)
    $("#next").on("click", function(){
        page++;
        getData();
    });

    // 이전 버튼을 클릭한 경우 (페이징 처리)
    $("#prev").on("click", function(){
        page--;
        getData();
    });
    
	$(frm).on("submit", function(e){
		e.preventDefault();
		query = $('[name="query"]').val();
		if(query==''){
			alert('도서명을 입력하세요.');
		}else {
			getData();
			page = 1;
		}
	});
	
	function getData(){
		$.ajax({
			type:"get",
			url:"https://dapi.kakao.com/v3/search/book?target=title",
			headers:{"Authorization":"KakaoAK 35c0aa5e699cabcb9592ef08fb07d91a"},
			dataType:"json",
			data:{query:query, size:size, page:page},
			success:function(data){
				console.log(data);
				const temp = Handlebars.compile($('#temp_book').html());
				$('#div_book').html(temp(data));
				const last = Math.ceil(data.meta.pageable_count/size);
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
		});
	}
</script>