package com.wirebarley.test;

import java.io.IOException;

import org.apache.http.HttpEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class MainController {

	@RequestMapping(value = "/main.do")
	public ModelAndView openQnaList() throws Exception {
		ModelAndView mv = new ModelAndView("/main");
		return mv;
	}
	
	@GetMapping("/live_currency.do")
    public ModelAndView greeting() throws Exception {//api 정보요청후 한국, 일본, 필리핀 환율 값 jsp페이지로 전송
        ModelAndView mv = new ModelAndView("jsonView");
        
        final String ACCESS_KEY = "b73548e7dfafe81dbc454dd498e19415";
    	final String BASE_URL = "http://apilayer.net/api/";
    	final String ENDPOINT = "live";
    	String[] exchage = {"USDKRW", "USDJPY", "USDPHP"};//사용할 수취국가 목록
    	
    	CloseableHttpClient httpClient = HttpClients.createDefault();
        
    	HttpGet get = new HttpGet(BASE_URL + ENDPOINT + "?access_key=" + ACCESS_KEY);
    	
    	try {
			CloseableHttpResponse response = httpClient.execute(get);
			HttpEntity entity = (HttpEntity) response.getEntity();
			
			JSONObject result = new JSONObject(EntityUtils.toString(entity));
			
			for(int i=0; i<exchage.length; i++) {
				mv.addObject(exchage[i], result.getJSONObject("quotes").get(exchage[i]));
			}
            
            System.out.println("model: " + mv.getModelMap());
            
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    	
        return mv;
    }
}
