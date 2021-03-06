package com.ballchen.education.utils;


import com.ballchen.education.consts.PublicConsts;
import org.springframework.cglib.beans.BeanMap;

import java.io.*;
import java.util.*;

/**
 * Created by ballchen on 2016/6/28.
 */
public class PublicUtils {

    /**
     * 写入所有
     * @param filePath 文件路径
     * @param paramMap 键值对
     * @return boolean
     */
    public static boolean writeAllProperties(String filePath,Map<String,Object> paramMap){
        boolean flag = false;
        Properties properties = new Properties();
        InputStream in = null;
        OutputStream out = null;
        try {
            Iterator<String> iterator = paramMap.keySet().iterator();
            in = new FileInputStream(filePath);
            properties.load(in);
            out = new FileOutputStream(filePath);
            while(iterator.hasNext()){
                String key = iterator.next();
                properties.setProperty(key, String.valueOf(paramMap.get(key)));
            }
            properties.store(out,"Update ");
            flag = true;
        }catch (IOException e) {
            //e.printStackTrace();
            flag = false;
        }finally {
            try {
                out.close();
                in.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        return flag;
    }
    /**
     * 写入properties
     * @param filePath 配置文件路径
     * @param key 键值
     * @param value value
     * @return boolean
     */
    public static boolean writeProperties(String filePath,String key,String value){
        boolean flag = false;
        Properties properties = new Properties();
        InputStream in = null;
        OutputStream out = null;
        try {
            in = new FileInputStream(filePath);
            properties.load(in);
            out = new FileOutputStream(filePath);
            properties.setProperty(key,value);
            properties.store(out,"Update " + key + " name");
            flag = true;
        }catch (IOException e) {
            //e.printStackTrace();
            flag = false;
        }finally {
            try {
                out.close();
                in.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        return flag;
    }

    /**
     * 根据键值获取value
     * @param filePath 文件路径
     * @param key 键值
     * @return String
     * @throws IOException IO异常
     */
    public static String getValueByKey(String filePath,String key) {
        Properties properties = new Properties();
        InputStream in = null;
        String value = null;
        try {
            in = new BufferedInputStream(new FileInputStream(filePath));
            properties.load(in);
            value = properties.getProperty(key);
        } catch (IOException e) {
            e.printStackTrace();
        }finally {
            try {
                in.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        return value;
    }

    public static Map<String,Object> getUseableFileServerProperties(String rootUrl){
        Properties pps = new Properties();
        InputStream in;
        Map<String,Object> jsonObject = null;
        String sftpFileServiceProperties = rootUrl+PublicConsts.SFTP_FILE_SERVER_PROPERTIES_NAME;
        String qiniuCloudProperties = rootUrl+PublicConsts.QINIU_CLOUD_PEOPERTIES_NAME;
        boolean sftpFileServiceDenied = Boolean.valueOf(PublicUtils.getValueByKey(sftpFileServiceProperties,"denied"));
        try {
            jsonObject = new HashMap<>();
            if(!sftpFileServiceDenied){
                in = new BufferedInputStream(new FileInputStream(sftpFileServiceProperties));
                jsonObject.put("type",PublicConsts.FILE_SERVER_TYPE_SFTP);
            }else{
                in = new BufferedInputStream(new FileInputStream(qiniuCloudProperties));
                jsonObject.put("type",PublicConsts.FILE_SERVER_TYPE_QINIU);
            }
            pps.load(in);
            Enumeration en = pps.propertyNames(); //得到配置文件的名字
            while(en.hasMoreElements()) {
                String strKey = (String) en.nextElement();
                String strValue = pps.getProperty(strKey);
                jsonObject.put(strKey,strValue);
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return jsonObject;
    }

    /**
     * 读取Properties的全部信息
     * @param filePath 文件路径
     * @return JSONObject
     */
    public static Map<String,Object> getAllProperties(String filePath) {
        Properties pps = new Properties();
        InputStream in;
        Map<String,Object> jsonObject = null;
        try {
            jsonObject = new HashMap<>();
            in = new BufferedInputStream(new FileInputStream(filePath));
            pps.load(in);
            Enumeration en = pps.propertyNames(); //得到配置文件的名字
            while(en.hasMoreElements()) {
                String strKey = (String) en.nextElement();
                String strValue = pps.getProperty(strKey);
                jsonObject.put(strKey,strValue);
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return jsonObject;
    }

    /**
     * 获得唯一逐渐
     * @return String
     */
    public static String getUUID(){
        return UUID.randomUUID().toString();
    }
    /**
     * 将POJO转换成Map
     * @param object
     * @return
     */
    public static Map<String,Object> parsePOJOtoMap(Object object){
        Map<String,Object> map = new HashMap<>();
        if(object!=null){
            BeanMap beanMap = BeanMap.create(object);
            Set<String> keySet = beanMap.keySet();
            Iterator<String> it = keySet.iterator();
            while(it.hasNext()){
                String key = it.next();
                Object value = beanMap.get(key);
                if(value!=null){
                    map.put(key,value);
                }
            }
        }
        return map;
    }

/*    public static void main(String [] args){
        JSONObject jsonObject = PublicUtils.getAllProperties("C:/IEDA_WORKSPACE/ball-education/src/main/resources/sftpFileServer.properties");
        System.out.println(jsonObject.toJSONString());
        boolean flag = PublicUtils.writeProperties("C:/IEDA_WORKSPACE/ball-education/src/main/resources/sftpFileServer.properties","host","/public/upfile");
        System.out.println(flag);
        Map<String,Object> paramMap = new HashMap<>();
        paramMap.put("userName","admin1");
        paramMap.put("password","admin121");
        paramMap.put("port",3000);
        paramMap.put("host","/admin/fileManage");
        flag = PublicUtils.writeAllProperties("C:/IEDA_WORKSPACE/ball-education/src/main/resources/sftpFileServer.properties",paramMap);
    }*/
}
