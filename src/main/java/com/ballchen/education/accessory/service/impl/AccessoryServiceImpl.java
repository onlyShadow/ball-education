package com.ballchen.education.accessory.service.impl;

import com.ballchen.education.accessory.dao.IAccessoryDAO;
import com.ballchen.education.accessory.entity.Accessory;
import com.ballchen.education.accessory.service.IAccessoryService;
import com.ballchen.education.consts.PublicConsts;
import com.ballchen.education.utils.PublicUtils;
import com.ballchen.education.utils.SftpUtils;
import com.jcraft.jsch.JSchException;
import com.jcraft.jsch.SftpException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.Map;
import java.util.UUID;

/**
 * Created by ballchen on 2016/7/19.
 */
@Service
@Transactional
public class AccessoryServiceImpl implements IAccessoryService {

    @Autowired
    private IAccessoryDAO accessoryDAO;

    @Override
    public int deleteByPrimaryKey(String id) {
        return accessoryDAO.deleteByPrimaryKey(id);
    }

    @Override
    public int insert(Accessory record) {
        return accessoryDAO.insert(record);
    }

    @Override
    public int insertSelective(Accessory record) {
        return accessoryDAO.insertSelective(record);
    }

    @Override
    public Accessory selectByPrimaryKey(String id) {
        return accessoryDAO.selectByPrimaryKey(id);
    }

    @Override
    public int updateByPrimaryKeySelective(Accessory record) {
        return accessoryDAO.updateByPrimaryKeySelective(record);
    }

    @Override
    public int updateByPrimaryKey(Accessory record) {
        return accessoryDAO.updateByPrimaryKey(record);
    }

    @Override
    public Accessory getAccessoryByMultipartFile(MultipartFile imgFile) {
        Accessory accessory = null;
        if(imgFile!=null){
            //获得文件服务器文件路径
            String fileServiceFilePath = this.getClass().getClassLoader().getResource("/").getPath()+ PublicConsts.fileServiceFilePath;
            //获得文件服务器配置
            Map<String,Object> fileServeProperties = PublicUtils.getAllProperties(fileServiceFilePath);
            String userName = (String)fileServeProperties.get("userName");
            String password = (String)fileServeProperties.get("password");
            String host = (String)fileServeProperties.get("host");
            Integer port = Integer.valueOf((String)fileServeProperties.get("port"));
            String filePath = (String)fileServeProperties.get("filePath");
            SftpUtils sftpUtils = new SftpUtils(userName,password,host,port);
            boolean flag;
            //获得文件名
            String fileName = imgFile.getOriginalFilename().substring(0, imgFile.getOriginalFilename().lastIndexOf("."));
            //获得文件扩展名
            String ext = imgFile.getOriginalFilename().substring(imgFile.getOriginalFilename().lastIndexOf("."),imgFile.getOriginalFilename().length());
            //获得保存到服务器的文件名
            String saveFileServeName = UUID.randomUUID().toString();
            try {
                sftpUtils.connect();
                //上传文件至服务器
                sftpUtils.uploadFile(imgFile.getInputStream(),filePath+"/"+saveFileServeName+ext);
                flag = true;
                if(flag){//上传成功，实例化附件
                    accessory = new Accessory();
                    accessory.setId(UUID.randomUUID().toString());
                    accessory.setUrl(saveFileServeName+ext);
                    accessory.setFileName(fileName);
                    accessory.setExt(ext);
                    accessory.setSaveName(saveFileServeName);
                    accessory.setAccessoryName(fileName);
                }
            } catch (IOException e) {
                e.printStackTrace();
            } catch (SftpException e) {
                e.printStackTrace();
            } catch (JSchException e) {
                e.printStackTrace();
            }finally {
                sftpUtils.disconnect();
            }
        }
        return accessory;
    }
}