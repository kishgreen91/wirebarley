var exchange_rate;//환율
var name_with_usd;//환율명(USD포함)
var name_without_usd;//환율명(USD제외)

function calculate(){	
	var total = (exchange_rate*$("#deposite").val()).toFixed(2);//환율과 수취금액은 소숫점 2째자리까지, 환율 곱하기 입력갑
	total = numberComma(total);
	$("#total").empty();
	$("#total").append("수취금액은 " + total + " " + name_without_usd + " 입니다").removeAttr("style");
}

function currency_name(currency){//환율과 수취금액에 적용될 text
	name_with_usd=currency.slice(3,6)+"/"+currency.slice(0,3);
	name_without_usd=currency.slice(3,6);
	$("#current").append(name_with_usd);
}

function numberComma(number){//환율과 수취금액은 3자리 이상 되면 콤마를 가운데 찍어 보여줍니다.
	var parts = number.toString().split(".");
    parts[0] = parts[0].replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    return parts.join(".");
}

function numberCheck(){//입력값이 숫자인지, 값이 0<x<=10000 사이인지 확인
	var deposite = $("#deposite").val();
	if($.isNumeric && deposite > 0 && deposite <=10000){
		calculate();	
	}else{
		$("#total").empty();
		$("#total").append("송금액이 바르지 않습니다").css("color", "red");
	}
}