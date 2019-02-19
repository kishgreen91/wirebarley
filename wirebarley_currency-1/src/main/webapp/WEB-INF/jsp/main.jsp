<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<%@ include file="/WEB-INF/include/include_header.jspf"%>
</head>
<body id="main">
	<div class="wrap">
		 <div class="bottom">
			 <h1>환율 계산</h1>
			 
			 <h3>송금국가: 미국(USD)</h3>
			 <h3>수취국가: 
					<select id="country"> <!-- select box 사용 한국, 일본 필리핀 -->
					<option title="USDKRW" value="" selected="selected">한국(KRW)</option>
						<option title="USDJPY" value="">일본(JPN)</option>
						<option title="USDPHP" value="">필리핀(PHP)</option>
					</select>
			</h3>
		 </div>
		 <div id="id_c" class="bottom">
		 	<h3 id="current"></h3>
		 </div>
		 <div class="bottom">
		 	<h3>송금액: <input id="deposite" type="number" value="100">USD</h3>
		 	<button type="button" id="submit">Submit</button>
		 	<h3 id="total"></h3>
		 </div>
	</div>    
</body>
<script type="text/javascript">
$(document).ready(function(){
	currency_init();
	$("#country").change(function(){
		currency_init();
		$("#total").empty();
	});
	$("#submit").click(function(){
		numberCheck();
	});
	$("#deposite").keypress(function(e){
		if(e.which==13){
			numberCheck();
		}
	});
});

function currency_init(){//수취국가를 선택/변경시 api로 서버에 요청 후 환율정보 가져온다.
	var selected = $("#country option:selected").attr("title");
	$.ajax({
		url : "<c:url value='/live_currency.do' />",
		type : "GET",
		async : false,
		success : function(data, status) {
			$.each(data, function(key, value) {
				if(selected === key){
					exchange_rate=value.toFixed(2);//환율과 수취금액은 소숫점 2째자리까지  value = 1234 또는 1234.00000해도 두자리로 나온다.
					$("#country option:selected").val(value);					
					$("#current").empty();
					$("#current").append("환율: " + numberComma(exchange_rate));
					currency_name(key);
				}
			});
		},
		error: function(e){
			alert(e.responseText);
		}
	});
}
</script>
</html>

