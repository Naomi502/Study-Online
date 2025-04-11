package com.jd;

import org.junit.jupiter.api.Test;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.URL;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.HashMap;
import java.util.Map;
import java.util.stream.Collectors;

@RestController
public class QrcodeController {

    private static final String API_KEY = "80360c1e300acae5bb8bb8e51d297d02";
    private static final String API_URL = "http://apis.juhe.cn/qrcode/api";

    @GetMapping("/qrcode")
    public String generateQrcode(
            @RequestParam String text,
            @RequestParam(required = false, defaultValue = "") String el,
            @RequestParam(required = false, defaultValue = "") String bgcolor,
            @RequestParam(required = false, defaultValue = "") String fgcolor,
            @RequestParam(required = false, defaultValue = "") String logo,
            @RequestParam(required = false, defaultValue = "") String w,
            @RequestParam(required = false, defaultValue = "") String m,
            @RequestParam(required = false, defaultValue = "") String lw,
            @RequestParam(required = false, defaultValue = "") String type
    ) throws Exception {
        Map<String, String> map = new HashMap<>();
        map.put("key", API_KEY);
        map.put("text", text);
        map.put("el", el);
        map.put("bgcolor", bgcolor);
        map.put("fgcolor", fgcolor);
        map.put("logo", logo);
        map.put("w", w);
        map.put("m", m);
        map.put("lw", lw);
        map.put("type", type);

        URL url = new URL(String.format("%s?%s", API_URL, params(map)));
        BufferedReader in = new BufferedReader(new InputStreamReader(url.openConnection().getInputStream()));
        String inputLine;
        StringBuilder response = new StringBuilder();
        while ((inputLine = in.readLine()) != null) {
            response.append(inputLine);
        }
        in.close();
        return response.toString();
    }

    public static String params(Map<String, String> map) {
        return map.entrySet().stream()
                .map(entry -> {
                    try {
                        return entry.getKey() + "=" + URLEncoder.encode(entry.getValue(), StandardCharsets.UTF_8.toString());
                    } catch (Exception e) {
                        e.printStackTrace();
                        return entry.getKey() + "=" + entry.getValue();
                    }
                })
                .collect(Collectors.joining("&"));
    }
}