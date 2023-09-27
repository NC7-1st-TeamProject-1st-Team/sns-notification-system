package bitcamp.myapp.controller;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.URI;
import java.net.URL;
import java.nio.charset.StandardCharsets;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Base64;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import bitcamp.myapp.service.SmsService;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;

@Component
@PropertySource("classpath:ncs.properties")
@RequestMapping("/auth")
public class NaverSensV2 {
    @Value("${ncs.accessKey}")
    private String accessKey;

    @Value("${ncs.secretKey}")
    private String secretKey;

    @Value("${ncs.serviceId}")
    private String serviceId;

    @Value("${ncs.senderPhone}")
    private String phone;

    public void sendMsg(String phoneNumber, String rand) {
        // 호스트 URL
        String hostNameUrl = "https://sens.apigw.ntruss.com";
        // 요청 URL
        String requestUrl = "/sms/v2/services/";
        // 요청 URL Type
        String requestUrlType = "/messages";
        // 개인 인증키
        accessKey = "75pWjJhG9pprB66ehLxc";
        // 2차 인증을 위해 서비스마다 할당되는 service secret
        secretKey = "ghfYItSWx3lzr1cH2RpxzXHgxebEvdoLMEVSxjUm";
        // 프로젝트에 할당된 SMS 서비스 ID
        serviceId = "ncp:sms:kr:316390617576:sms_practice";
        //
        phone = "01076662821";

        // 요청 method
        String method = "POST";
        String timestamp = Long.toString(System.currentTimeMillis());
        requestUrl += serviceId + requestUrlType;
        String apiUrl = hostNameUrl + requestUrl;

        // JSON 을 활용한 body data 생성
        JSONObject bodyJson = new JSONObject();
        JSONObject toJson = new JSONObject();
        JSONArray toArr = new JSONArray();

        // 메시지 Type (sms | lms)
        bodyJson.put("type", "sms");
        bodyJson.put("contentType", "COMM");
        bodyJson.put("countryCode", "82");

        bodyJson.put("from", "01076662821");
        bodyJson.put("subject", "테스트 제목입니다.");
        bodyJson.put("content", "테스트 내용입니다.");

        // 난수와 함께 전송
        toJson.put("content", "본인인증 코드는 [" + rand + "] 입니다.");
        toJson.put("to", phoneNumber);
        toArr.add(toJson);


        // 발신번호 * 사전에 인증/등록된 번호만 사용할 수 있습니다.
        bodyJson.put("messages", toArr);

        // 출력 포맷을 설정하기
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");

        String body = bodyJson.toJSONString();
        String to = toJson.toJSONString();

        System.out.println(body);
        System.out.println("phoneNumber 값" + rand);
        System.out.println("phoneNumber 값" + to);

        try {
            String url = "https://sens.apigw.ntruss.com/sms/v2/services/" + serviceId + "/messages";

            RestTemplate restTemplate = new RestTemplate();
            HttpHeaders headers = new HttpHeaders();
            headers.set("Content-Type", "application/json; charset=UTF-8");
            headers.set("x-ncp-apigw-timestamp", timestamp);
            headers.set("x-ncp-iam-access-key", accessKey);
            headers.set("x-ncp-apigw-signature-v2", makeSignature(requestUrl, timestamp, method, accessKey, secretKey));

            HttpEntity<String> requestContent = new HttpEntity<>(body, headers);

            ResponseEntity<String> responseEntity = restTemplate.exchange(
                    url,
                    HttpMethod.POST,
                    requestContent,
                    String.class
            );

            System.out.println(responseEntity.getStatusCode());
            System.out.println(responseEntity.getHeaders());
            System.out.println(responseEntity.getBody());

        } catch (Exception e) {
            System.out.println(e);
        }
    }


    public static String makeSignature(
            String url,
            String timestamp,
            String method,
            String accessKey,
            String secretKey
    ) throws NoSuchAlgorithmException, InvalidKeyException {

        String space = " ";
        String newLine = "\n";

        String message = new StringBuilder()
                .append(method)
                .append(space)
                .append(url)
                .append(newLine)
                .append(timestamp)
                .append(newLine)
                .append(accessKey)
                .toString();

        SecretKeySpec signingKey;
        String encodeBase64String;
        try {
            signingKey = new SecretKeySpec(secretKey.getBytes("UTF-8"), "HmacSHA256");
            Mac mac = Mac.getInstance("HmacSHA256");
            mac.init(signingKey);
            byte[] rawHmac = mac.doFinal(message.getBytes("UTF-8"));
            encodeBase64String = Base64.getEncoder().encodeToString(rawHmac);
        } catch (UnsupportedEncodingException e) {
            encodeBase64String = e.toString();
        }


        return encodeBase64String;
    }


}