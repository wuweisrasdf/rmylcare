package com.healthcare.common.utils;

import javax.xml.parsers.DocumentBuilderFactory;
import java.io.ByteArrayInputStream;
import java.io.InputStream;

import java.util.*;

import org.springframework.util.DigestUtils;
import org.w3c.dom.Document;

import javax.xml.parsers.DocumentBuilder;


import java.nio.charset.StandardCharsets;
import java.util.stream.Collectors;

public class WxPayUtils {

    // 生成随机字符串
    public static String generateNonceStr() {
        return UUID.randomUUID().toString().replaceAll("-", "").substring(0, 32);
    }

    // 生成签名
    public static String createSign(SortedMap<String, String> params, String key) {
        String signStr = params.entrySet().stream()
                .filter(e -> e.getValue() != null && !"".equals(e.getValue()) && !"sign".equals(e.getKey()))
                .map(e -> e.getKey() + "=" + e.getValue())
                .collect(Collectors.joining("&"));
        signStr += "&key=" + key;

        return DigestUtils.md5DigestAsHex(signStr.getBytes()).toUpperCase();
    }

    // 验证签名
    public static boolean isSignatureValid(Map<String, String> params, String key) {
        SortedMap<String, String> sortedParams = new TreeMap<>(params);
        String sign = sortedParams.get("sign");
        return createSign(sortedParams, key).equals(sign);
    }

    // Map 转 XML
    public static String mapToXml(Map<String, String> data) throws Exception {
        StringBuilder sb = new StringBuilder();
        sb.append("<xml>");
        for (Map.Entry<String, String> entry : data.entrySet()) {
            sb.append("<").append(entry.getKey()).append(">")
                    .append("<![CDATA[").append(entry.getValue()).append("]]>")
                    .append("</").append(entry.getKey()).append(">");
        }
        sb.append("</xml>");
        return sb.toString();
    }

    // XML 转 Map
    public static Map<String, String> xmlToMap(String xmlStr) throws Exception {
        Map<String, String> map = new HashMap<>();
        InputStream inputStream = new ByteArrayInputStream(xmlStr.getBytes(StandardCharsets.UTF_8));
        DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
        factory.setExpandEntityReferences(false);
        DocumentBuilder builder = factory.newDocumentBuilder();
        Document doc = builder.parse(inputStream);
        doc.getDocumentElement().normalize();

        org.w3c.dom.NodeList nodeList = doc.getDocumentElement().getChildNodes();
        for (int i = 0; i < nodeList.getLength(); i++) {
            org.w3c.dom.Node node = nodeList.item(i);
            map.put(node.getNodeName(), node.getTextContent());
        }

        return map;
    }

    // 读取微信回调的 XML 流并转 Map
    public static Map<String, String> readXml(InputStream inputStream) throws Exception {
        StringBuilder sb = new StringBuilder();
        Scanner scanner = new Scanner(inputStream, StandardCharsets.UTF_8.name());
        while (scanner.hasNextLine()) {
            sb.append(scanner.nextLine());
        }
        scanner.close();
        return xmlToMap(sb.toString());
    }
}
